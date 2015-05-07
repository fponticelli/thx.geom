package thx.geom.d2;

using thx.Arrays;
using thx.Floats;

class ArcSegment extends Segment<ArcSegment> {
  public static function toCubic(arc : ArcSegment) : Array<CubicCurveSegment> {
    var values = arcToCubic(arc.start.x, arc.start.y, arc.radius.x, arc.radius.y, arc.xAxisRotate.radians, arc.largeArcFlag, arc.sweepFlag, arc.end.x, arc.end.y, null),
        start  = arc.start,
        result = [];
    for(i in 0...Std.int(values.length / 3)) {
      result.push(new CubicCurveSegment(
        start,
        Point.create(
          values[i*3][0],
          values[i*3][1]
        ),
        Point.create(
          values[i*3+1][0],
          values[i*3+1][1]
        ),
        start = Point.create(
          values[i*3+2][0],
          values[i*3+2][1]
        )
      ));

    }
    return result;
  }

  static function arcToCubic(x1 : Float, y1 : Float, rx : Float, ry : Float, angle : Float, large_arc_flag : Bool, sweep_flag : Bool, x2 : Float, y2 : Float, ?recursive : Array<Float>) : Array<Array<Float>> {
    // for more information of where this math came from visit:
    // http://www.w3.org/TR/SVG11/implnote.html#ArcImplementationNotes

    function rotate(x : Float, y : Float, rad : Float)
      return {
        x : x * Math.cos(rad) - y * Math.sin(rad),
        y : x * Math.sin(rad) + y * Math.cos(rad)
      };

    var _120 = Math.PI * 120 / 180,
        res  = [],
        xy, f1, f2, cx, cy;
    if (null == recursive) {
      xy = rotate(x1, y1, -angle);
      x1 = xy.x;
      y1 = xy.y;
      xy = rotate(x2, y2, -angle);
      x2 = xy.x;
      y2 = xy.y;
      var cos = Math.cos(angle),
          sin = Math.sin(angle),
          x = (x1 - x2) / 2,
          y = (y1 - y2) / 2;
      var h = (x * x) / (rx * rx) + (y * y) / (ry * ry);
      if (h > 1) {
        h = Math.sqrt(h);
        rx = h * rx;
        ry = h * ry;
      }
      var rx2 = rx * rx,
          ry2 = ry * ry,
          k = (large_arc_flag == sweep_flag ? -1 : 1) *
              Math.sqrt(Math.abs((rx2 * ry2 - rx2 * y * y - ry2 * x * x) / (rx2 * y * y + ry2 * x * x)));

      cx = k * rx * y / ry + (x1 + x2) / 2;
      cy = k * -ry * x / rx + (y1 + y2) / 2;
      f1 = Math.asin(((y1 - cy) / ry).roundTo(9));
      f2 = Math.asin(((y2 - cy) / ry).roundTo(9));

      f1 = x1 < cx ? Math.PI - f1 : f1;
      f2 = x2 < cx ? Math.PI - f2 : f2;
      if(f1 < 0) f1 = Math.PI * 2 + f1;
      if(f2 < 0) f2 = Math.PI * 2 + f2;
      if (sweep_flag && f1 > f2) {
        f1 = f1 - Math.PI * 2;
      }
      if (!sweep_flag && f2 > f1) {
        f2 = f2 - Math.PI * 2;
      }
    } else {
      f1 = recursive[0];
      f2 = recursive[1];
      cx = recursive[2];
      cy = recursive[3];
    }
    var df = f2 - f1;
    if (Math.abs(df) > _120) {
      var f2old = f2,
          x2old = x2,
          y2old = y2;
      f2 = f1 + _120 * (sweep_flag && f2 > f1 ? 1 : -1);
      x2 = cx + rx * Math.cos(f2);
      y2 = cy + ry * Math.sin(f2);
      res = arcToCubic(x2, y2, rx, ry, angle, false, sweep_flag, x2old, y2old, [f2, f2old, cx, cy]);
    }
    df = f2 - f1;
    var c1 = Math.cos(f1),
        s1 = Math.sin(f1),
        c2 = Math.cos(f2),
        s2 = Math.sin(f2),
        t = Math.tan(df / 4),
        hx = 4 / 3 * rx * t,
        hy = 4 / 3 * ry * t,
        m1 = [x1, y1],
        m2 = [x1 + hx * s1, y1 - hy * c1],
        m3 = [x2 + hx * s2, y2 - hy * c2],
        m4 = [x2, y2];
    m2[0] = 2 * m1[0] - m2[0];
    m2[1] = 2 * m1[1] - m2[1];
    if (null != recursive) {
      return [m2, m3, m4].concat(res);
    } else {
      var res2 = [m2, m3, m4].concat(res).flatten(); // ???? .join().split(",");
      var newres = [];
      var ii = res2.length;
      var i = 0;
      var c = 0;
      while(i < ii) {
        newres[c++] = [
          rotate(res2[i], res2[i + 1], angle).x,
          rotate(res2[++i - 1], res2[i], angle).y
        ];
        i++;
      }
      return newres;
    }
  }

  public var radius(default, null) : Vector;
  public var largeArcFlag : Bool;
  public var sweepFlag : Bool;
  public var xAxisRotate(default, null) : Angle;
  public function new(start : Point, radius : Vector, largeArcFlag : Bool, sweepFlag : Bool, xAxisRotate : Angle, end : Point) {
    // TODO box definition is not complete
    super(start, end, [start, end]);
    this.radius = radius;
    this.largeArcFlag = largeArcFlag;
    this.sweepFlag = sweepFlag;
    this.xAxisRotate = xAxisRotate;
  }

  override public function equals(other : ArcSegment) : Bool
    return super.equals(other) && radius == other.radius && largeArcFlag == other.largeArcFlag && sweepFlag == other.sweepFlag && xAxisRotate == other.xAxisRotate;

  override public function nearEquals(other : ArcSegment) : Bool
    return super.equals(other) && radius.nearEquals(other.radius) && largeArcFlag == other.largeArcFlag && sweepFlag == other.sweepFlag && xAxisRotate.nearEquals(other.xAxisRotate);

  override public function toString()
    return 'ArcSegment(sx:${start.x},sy:${start.y},rot:${xAxisRotate.degrees}°,laf:${largeArcFlag},sf:${sweepFlag},ex:${end.x},ey:${end.y})';
}
