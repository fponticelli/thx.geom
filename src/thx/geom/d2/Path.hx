package thx.geom.d2;

import thx.geom.d2.svg.Svg;
using thx.Arrays;
using thx.Floats;
using thx.Functions;

class Path implements IShape {
  public static function fromSVGPath(d : String)
    return new Path(Svg.parsePath(d));

  public var box(default, null) : Rect;

  var segments : Array<Segment<Dynamic>>;

  public function new(?list : Array<Segment<Dynamic>>) {
    segments = null == list ? [] : list;
    box = Rect.fromRects({
      iterator : function() return segments.map.fn(_.box).iterator()
    });
  }

  public function iterator()
    return segments.iterator();

  public function toSVGPath() {
    var buf = [],
        end = Point.create(Math.NaN, Math.NaN),
        startingPoint = end;

    for(segment in segments) {
      if(!end.equals(segment.start)) {
        buf.push('M ${r(segment.start.x)} ${r(segment.start.y)}');
        startingPoint = segment.start;
      }
      switch Type.getClass(segment) {
        case LineSegment:
          buf.push('L ${r(segment.end.x)} ${r(segment.end.y)}');
        case QuadraticCurveSegment:
          var s : QuadraticCurveSegment = cast segment;
          buf.push('Q ${r(s.c1.x)} ${r(s.c1.y)} ${r(s.end.x)} ${r(s.end.y)}');
        case CubicCurveSegment:
          var s : CubicCurveSegment = cast segment;
          buf.push('C ${r(s.c1.x)} ${r(s.c1.y)} ${r(s.c2.x)} ${r(s.c2.y)} ${r(s.end.x)} ${r(s.end.y)}');
        case ArcSegment:
          var s : ArcSegment = cast segment;
          buf.push('A ${r(s.radius.x)} ${r(s.radius.y)} ${r(s.xAxisRotate.degrees)} ${s.largeArcFlag ? 1 : 0} ${s.sweepFlag ? 1 : 0} ${r(s.end.x)} ${r(s.end.y)}');
      }
      if(segment.end.equals(startingPoint)) {
        buf.push("Z");
      }
      end = segment.end;
    }

    return buf.join(" ");
  }

  static function r(v : Float)
    return v.roundTo(9);

  public function toString()
    return 'Path(segments=${segments.length})';
}
