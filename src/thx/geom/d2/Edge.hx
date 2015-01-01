package thx.geom.d2;

import thx.geom.d2.Line;
import thx.geom.d2.Point;
import thx.geom.shape.Box;

interface Edge {
  public var box(get, null) : Box;
  public var area(get, null) : Float;
  public var length(get, null) : Float;
  public var lengthSquared(get, null) : Float;
  public var isLinear(get, null) : Bool;
  public var first(default, null) : Point;
  public var last(default, null) : Point;
  public var normalIn(default, null) : Point;
  public var normalOut(default, null) : Point;
  public var linearSegments(get, null) : Array<EdgeLinear>;
  public var linearSpline(get, null) : Spline;

  public function equals(other : Edge) : Bool;
  public function matches(other : Edge) : Bool;
  public function transform(matrix : Matrix4x4) : Edge;
  public function flip() : Edge;
  public function direction() : Point;
  public function intersects(other : Edge) : Bool;
  public function intersections(other : Edge) : Array<Point>;
  public function intersectsLine(line : Line) : Bool;
  public function intersectionsLine(line : Line) : Array<Point>;
  public function split(v : Float) : Array<Edge>;
  public function interpolate(v : Float) : Point;
  public function interpolateNode(v : Float) : SplineNode;
  public function toArray() : Array<Point>;
  public function toLinear() : EdgeLinear;
  public function toString() : String;
  public function toSpline() : Spline;
}