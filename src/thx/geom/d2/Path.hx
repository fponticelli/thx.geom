package thx.geom.d2;

import thx.geom.d2.svg.Svg;
using thx.Arrays;

class Path {
  public static function fromSVGPath(d : String)
    return new Path(Svg.parsePath(d));

  var segments : Array<Segment>;
  public function new(?list : Array<Segment>) {
    segments = null == list ? [] : list;
  }

  public function toSVGPath() {
    var buf = [],
        end = Point.create(Math.NaN, Math.NaN),
        startingPoint = end;

    for(segment in segments) {
      if(!end.equals(segment.start)) {
        buf.push('M ${segment.start.x} ${segment.start.y}');
        startingPoint = segment.start;
      }
      switch Type.getClass(segment) {
        case LineSegment:
          buf.push('L ${segment.end.x} ${segment.end.y}');
        case QuadraticCurveSegment:
          var s : QuadraticCurveSegment = cast segment;
          buf.push('Q ${s.c1.x} ${s.c1.y} ${s.end.x} ${s.end.y}');
        case CubicCurveSegment:
          var s : CubicCurveSegment = cast segment;
          buf.push('C ${s.c1.x} ${s.c1.y} ${s.c2.x} ${s.c2.y} ${s.end.x} ${s.end.y}');
        case ArcSegment:
          var s : ArcSegment = cast segment;
          buf.push('A ${s.radius.x} ${s.radius.y} ${s.xAxisRotate.coord} ${s.largeArcFlag ? 1 : 0} ${s.sweepFlag ? 1 : 0} ${s.end.x} ${s.end.y}');
      }
      if(segment.end.equals(startingPoint)) {
        buf.push("Z");
      }
      end = segment.end;
    }

    return buf.join(" ");
  }

  public function toString()
    return 'Path(segments=${segments.length})';
}
