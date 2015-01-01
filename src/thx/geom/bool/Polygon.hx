package thx.geom.bool;

using thx.core.Iterables;
import thx.geom.Path;
import thx.geom.d2.Point;
import thx.geom.Spline;
import thx.geom.SplineNode;
using thx.core.Bools;

@:access(thx.geom.bool.PolygonVertex)
class Polygon {
  public static function fromSpline(spline : Spline) {
    var points = spline.toPoints();
    return new Polygon(points);
  }

  public var first(default, null) : PolygonVertex;
  var vertices : Int = 0;

  public function new(?points : Iterable<Point>) {
    if(null != points)
      points.pluck(add(new PolygonVertex(_)));
  }

  function add(vertex : PolygonVertex) {
    if(null == first) {
      first = vertex;
      first.next = vertex;
      first.prev = vertex;
    } else {
      var next, prev;
      prev = first.prev;
      next = first;
      next.prev = vertex;
      vertex.next = next;
      vertex.prev = prev;
      prev.next = vertex;
    }
    vertices++;
  }

  public function insert(vertex : PolygonVertex, start : PolygonVertex, end : PolygonVertex) {
    var curr = start,
        prev;

    while (curr != end && curr.alpha < vertex.alpha) {
      curr = curr.next;
    }

    vertex.next = curr;
    prev = curr.prev;
    vertex.prev = prev;
    prev.next = vertex;
    curr.prev = vertex;
    vertices++;
  }

  public function getNext(vertex : PolygonVertex) {
    var c = vertex;
    while(c.intersect) {
      c = c.next;
    }
    return c;
  }

  public function getFirstIntersect() {
    var vertex = first;
    do {
      if(vertex.intersect && !vertex.checked)
        break;
      vertex = vertex.next;
    } while(vertex != first);
    return vertex;
  }

  public function hasUnprocessed() {
    var vertex = first;
    do {
      if(vertex.intersect && !vertex.checked)
        return true;
      vertex = vertex.next;
    } while(vertex != first);
    return false;
  }

  public function union(other : Polygon) {
    return clip(other, false, false);
  }

  public function intersection(other : Polygon) {
    return clip(other, true, true);
  }

  public function difference(other : Polygon) {
    return clip(other, false, true);
  }

  public function clip(clip : Polygon, subjectFlag : Bool, clipperFlag : Bool) {
    var subject = first,
        clipper = clip.first,
        intersection;

    do {
      if(!subject.intersect) {
        do {
          if(!clipper.intersect) {
            intersection = new Intersection(
              subject,
              getNext(subject.next),
              clipper,
              clip.getNext(clipper.next)
            );
            if(intersection.test()) {
              var intersectionSubject = PolygonVertex.createIntersection(intersection.point, intersection.uSubject),
                  intersectionClipper = PolygonVertex.createIntersection(intersection.point, intersection.uClipper);

              intersectionSubject.nextPolygon = intersectionClipper;
              intersectionClipper.nextPolygon = intersectionSubject;

              insert(intersectionSubject, subject, getNext(subject.next));
              clip.insert(intersectionClipper, clipper, clip.getNext(clipper.next));
            }
          }
          clipper = clipper.next;
        } while(clipper != clip.first);
      }
      subject = subject.next;
    } while(subject != first);

    subject = first;
    clipper = clip.first;

    subjectFlag = subjectFlag != subject.isInside(clip);
    clipperFlag = clipperFlag != clipper.isInside(this);

    do {
      if(subject.intersect) {
        subject.entry = subjectFlag;
        subjectFlag = !subjectFlag;
      }
      subject = subject.next;
    } while(subject != first);

    do {
      if(clipper.intersect) {
        clipper.entry = clipperFlag;
        clipperFlag = !clipperFlag;
      }
      clipper = clipper.next;
    } while(clipper != clip.first);

    var polygons = [];

    while(hasUnprocessed()) {
      var current = getFirstIntersect(),
          clipped = new Polygon();
      clipped.add(new PolygonVertex(current.point));
      do {
        current.setChecked();
        if(current.entry) {
          do {
            current = current.next;
            clipped.add(new PolygonVertex(current.point));
          } while(!current.intersect);
        } else {
          do {
            current = current.prev;
            clipped.add(new PolygonVertex(current.point));
          } while(!current.intersect);
        }
        current = current.nextPolygon;
      } while(!current.checked);

      polygons.push(clipped);
    }

    return polygons;
  }

  public function toSpline() {
    var nodes = [],
        vertex = first;
    do {
      nodes.push(new SplineNode(vertex.point));
      vertex = vertex.next;
    } while(vertex != first);
    return new Spline(nodes, true);
  }
}

class PolygonVertex {
  public var point(default, null) : Point;
  public var next(default, null) : PolygonVertex;
  public var prev(default, null) : PolygonVertex;
  public var nextPolygon(default, null) : PolygonVertex;
  public var alpha(default, null) : Float;
  public var entry(default, null) : Bool;
  public var intersect(default, null) : Bool;
  public var checked(default, null) : Bool;

  public static function createIntersection(point : Point, alpha : Float) {
    var v = new PolygonVertex(point);
    v.alpha = alpha;
    v.intersect = true;
    v.entry = false;
    return v;
  }

  public function new(point : Point) {
    this.point = point;
    next = null;
    prev = null;
    nextPolygon = null;
    alpha = 0.0;
    entry = true;
    intersect = false;
    checked = false;
  }

  public function setChecked() {
    checked = true;
    if(null != nextPolygon && !nextPolygon.checked)
      nextPolygon.setChecked();
  }

  public function isInside(polygon : Polygon) {
    var windings = 0,
        boundary = new PolygonVertex(Point.create(Math.POSITIVE_INFINITY, point.y)),
        q = polygon.first;
    do {
      if(!q.intersect && new Intersection(this, boundary, q, polygon.getNext(q.next)).test())
        windings++;
      q = q.next;
    } while(q != polygon.first);
    return (windings % 2) != 0;
  }
}

class Intersection {
  public var point(default, null)  : Point;
  public var uSubject(default, null) : Float;
  public var uClipper(default, null) : Float;

  public function new(s1 : PolygonVertex, s2 : PolygonVertex, c1 : PolygonVertex, c2 : PolygonVertex) {
    var den = (c2.point.y - c1.point.y) * (s2.point.x - s1.point.x) - (c2.point.x - c1.point.x) * (s2.point.y - s1.point.y);

    if (den == 0.0)
      return;

    uSubject = ((c2.point.x - c1.point.x) * (s1.point.y - c1.point.y) - (c2.point.y - c1.point.y) * (s1.point.x - c1.point.x)) / den;
    uClipper = ((s2.point.x - s1.point.x) * (s1.point.y - c1.point.y) - (s2.point.y - s1.point.y) * (s1.point.x - c1.point.x)) / den;

    if (test())
      point = Point.create(
        s1.point.x + uSubject * (s2.point.x - s1.point.x),
        s1.point.y + uSubject * (s2.point.y - s1.point.y)
      );
  }

  public function test()
    return (0 < uSubject && uSubject < 1) && (0 < uClipper && uClipper < 1);
}