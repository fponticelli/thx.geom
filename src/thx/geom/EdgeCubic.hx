package thx.geom;

import thx.geom.d2.Line;
import thx.geom.d2.Point;
import thx.geom.shape.Box;
import thx.core.Floats;
using thx.core.Arrays;

class EdgeCubic implements Edge {
  public static var NEAR_FLAT : Float = 1.0 + Floats.EPSILON;
  public var box(get, null) : Box;
  public var area(get, null) : Float;
  public var length(get, null) : Float;
  public var lengthSquared(get, null) : Float;
  public var linearSegments(get, null) : Array<EdgeLinear>;
  public var linearSpline(get, null) : Spline;
  public var isLinear(get, null) : Bool;
  public var p0(default, null) : Point;
  public var p1(default, null) : Point;
  public var p2(default, null) : Point;
  public var p3(default, null) : Point;
  public var first(default, null) : Point;
  public var last(default, null) : Point;
  public var normalIn(default, null) : Point;
  public var normalOut(default, null) : Point;

  public function new(p0 : Point, p1 : Point, p2 : Point, p3 : Point) {
    first     = this.p0 = p0;
    normalOut = this.p1 = p1;
    normalIn  = this.p2 = p2;
    last      = this.p3 = p3;
  }
  public function equals(other : Edge) : Bool {
    if(isLinear && other.isLinear) return matches(other);
    var t : EdgeCubic = cast other;
    return p0.nearEquals(t.p0) && p1.nearEquals(t.p1) && p2.nearEquals(t.p2) && p3.nearEquals(t.p3);
  }

  public function matches(other : Edge) : Bool
    return first.nearEquals(other.first) && last.nearEquals(other.last);

  public function transform(matrix : Matrix4x4) : EdgeCubic
    return new EdgeCubic(p0.transform(matrix), p1.transform(matrix), p2.transform(matrix), p3.transform(matrix));

  public function flip() : Edge
    return new EdgeCubic(p3, p2, p1, p0);

  public function direction() : Point
    return last - first;

  public function intersects(other : Edge) : Bool
    return intersections(other).length > 0;

  public function intersections(other : Edge) : Array<Point>
    return if(Std.is(other, EdgeLinear))
      intersectionsEdgeLinear(cast other);
    else
      intersectionsEdgeCubic(cast other);

  public function intersectionsEdgeLinear(other : EdgeLinear) : Array<Point>
    return linearSegments.map(function(edge : EdgeLinear)
      return edge.intersectionsEdgeLinear(other)
    ).flatten();

  public function intersectionsEdgeCubic(other : EdgeCubic) : Array<Point>
    return linearSpline.intersectionsSpline(other.linearSpline);

  public function intersectsLine(line : Line) : Bool
    return intersectionsLine(line).length > 0;

  public function intersectionsLine(line : Line) : Array<Point>
    return linearSpline.intersectionsLine(line);

  public function split(v : Float) : Array<Edge> {
    var node = interpolateNode(v);
    if(null == node)
      return [];
    return [
      new EdgeCubic(p0, p1, node.normalIn, node.position),
      new EdgeCubic(node.position, node.normalOut, p2, p3)
    ];
  }

  public function interpolate(v : Float) : Point {
    var n = interpolateNode(v);
    if(null == n)
      return null;
    return n.position;
  }

  public function interpolateNode(v : Float) : SplineNode {
    var edges = subdivide(v);
    return new SplineNode(
      edges[0].last,
      edges[1].normalOut,
      edges[0].normalIn
    );
  }

  public function toLinear()
    return new EdgeLinear(first, last);

  public function toArray()
    return [p0,p1,p2,p3];

  public function toString() : String
    return 'Edge($p0,$p1,$p2,$p3)';

  public function toSpline()
    return Spline.fromEdges([this], false);

  public function isNearFlat() : Bool {
    var sum = p0.distanceTo(p1) + p1.distanceTo(p2) + p2.distanceTo(p3),
        len = p0.distanceTo(p3);
    return (sum / len) <= NEAR_FLAT;
  }

  public function subdivide(v : Float = 0.5) {
    var l1 = p0 + (p1 - p0) * v,
        m  = p1 + (p2 - p1) * v,
        r2 = p2 + (p3 - p2) * v,
        l2 = l1 + ( m - l1) * v,
        r1 =  m + (r2 -  m) * v,
        l3 = l2 + (r1 - l2) * v;
    return [
      new EdgeCubic(p0, l1, l2, l3),
      new EdgeCubic(l3, r1, r2, p3)
    ];
  }

  function get_area() : Float
    return linearSegments.reduce(function(acc, edge) {
      return acc + edge.area;
    }, 0);

  function get_box() : Box
    return Box.fromPoints(p0, p1).expandByPoints([p2, p3]);

  function get_isLinear() {
    var line = Line.fromPoints(p0, p3);
    if(!p1.isOnLine(line) || !p0.isOnLine(line))
      return false;
    else {
      var box = Box.fromPoints(p0, p3);
      return box.contains(p1) && box.contains(p2);
    }
  }

  function get_length() : Float
    return linearSegments.reduce(function(acc, edge)
      return acc + edge.length, 0);

  function get_lengthSquared() : Float
    return linearSegments.reduce(function(acc, edge)
      return acc + edge.lengthSquared, 0);

  function get_linearSegments() {
    var tosplit = [this],
        linearSegments = [],
        edge;
    while(tosplit.length > 0) {
      edge = tosplit.shift();
      if(edge.isNearFlat()) {
        linearSegments.push(edge.toLinear());
      } else {
        tosplit = edge.subdivide().concat(tosplit);
      }
    }
    return linearSegments;
  }

  function get_linearSpline()
    return Spline.fromEdges(cast linearSegments, false);
}