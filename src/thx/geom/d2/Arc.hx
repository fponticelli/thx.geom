package thx.geom.d2;

import thx.geom.core.*;
using thx.Floats;

class Arc implements IShape {
  public var center(default, null) : Point;
  public var startAngle(default, null) : Angle;
  public var endAngle(default, null) : Angle;
  public var innerRadius(default, null) : Radius;
  public var outerRadius(default, null) : Radius;
  public var path(default, null) : Path;
  public var box(default, null) : Rect;

  public function new(center : Point, startAngle : Angle, endAngle : Angle, innerRadius : Radius, outerRadius : Radius) {
    this.center      = center;
    this.startAngle  = startAngle;
    this.endAngle    = endAngle;
    this.innerRadius = innerRadius;
    this.outerRadius = outerRadius;

    var setter = function(v : Float) : Float return throw 'cannot set $v',
        sa = Angle.linked(
          function() return startAngle.toFloat().min(endAngle.toFloat()),
          function(v) return startAngle.radians = v
        ),
        ea = Angle.linked(
          function() return startAngle.toFloat().max(endAngle.toFloat()),
          function(v) return endAngle.radians = v
        ),
        ri = Radius.linked(
          function() return innerRadius.toFloat().min(outerRadius.toFloat()),
          function(v) return innerRadius.coord = v
        ),
        ro = Radius.linked(
          function() return innerRadius.toFloat().max(outerRadius.toFloat()),
          function(v) return outerRadius.coord = v
        ),
        spo = Point.linked(
          function() {
            var v : Vector = sa.radians;
            return center.x + v.x * ro.coord;
          },
          function() {
            var v : Vector = sa.radians;
            return center.y + v.y * ro.coord;
          },
          setter, setter
        ),
        epo = Point.linked(
          function() {
            var v : Vector = ea.radians;
            return center.x + v.x * ro.coord;
          },
          function() {
            var v : Vector = ea.radians;
            return center.y + v.y * ro.coord;
          },
          setter, setter
        ),
        spi = Point.linked(
          function() {
            var v : Vector = sa.radians;
            return center.x + v.x * ri.coord;
          },
          function() {
            var v : Vector = sa.radians;
            return center.y + v.y * ri.coord;
          },
          setter, setter
        ),
        epi = Point.linked(
          function() {
            var v : Vector = ea.radians;
            return center.x + v.x * ri.coord;
          },
          function() {
            var v : Vector = ea.radians;
            return center.y + v.y * ri.coord;
          },
          setter, setter
        ),
        angle = Angle.linked(
          function() return ea.radians - sa.radians,
          function(v) {
            ea.radians = sa.radians + v;
            return v;
          }
        ),
        vri = Vector.linked(
          function() return ri.coord,
          function() return ri.coord,
          function(v) return ri.coord = v,
          function(v) return ri.coord = v
        ),
        vro = Vector.linked(
          function() return ro.coord,
          function() return ro.coord,
          function(v) return ro.coord = v,
          function(v) return ro.coord = v
        ),
        sw = Flag.linked(
          function() return angle.degrees >= 180,
          function(v : Bool) : Bool return throw 'cannot set $v'
        ),
        oa = new ArcSegment(spo, vro, sw, true,  angle, epo),
        ia = new ArcSegment(epi, vri, sw, false, angle, spi);
    this.path = new Path([
        new LineSegment(spi, spo),
        oa,
        new LineSegment(epo, epi),
        ia
      ]);
    this.box = this.path.box;
  }

  inline public function toString()
    return 'Arc(${center.x},${center.y}; ${startAngle.degrees} to ${startAngle.degrees};${innerRadius.coord},${outerRadius.coord})';
}
