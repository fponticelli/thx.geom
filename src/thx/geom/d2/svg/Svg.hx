package thx.geom.d2.svg;

import thx.geom.d2.Path;
import thx.geom.core.MutableDim;
using thx.Arrays;

class Svg {
  public static function parsePath(d : String) : Array<Segment<Dynamic>> {
    var list : Array<Segment<Dynamic>> = [];
    function capture(qt : Int) {
      var arr = [],
          b = "",
          c;
      for(i in 0...qt) {
        while(d.length > 0 && isFiller(d))
          d = d.substring(1);
        while(d.length > 0 && isNumerical(d)) {
          b += d.substring(0, 1);
          d = d.substring(1);
        }
        arr.push(Std.parseFloat(b));
        b = "";
      }
      return arr;
    }

    function captureOne()
      return capture(1)[0];

    function capturePoints(qt : Int) {
      var c = capture(qt * 2);
      return c.splitBy(2).pluck(Point.create(_[0], _[1]));
    }

    function capturePoint()
      return capturePoints(1)[0];

    var beginShape = 0,
        prev = "L",
        last = Point.create(0, 0),
        smooth = null;

    while(d.length > 0) {
      while(isFiller(d))
        d = d.substring(1);
      var c = d.substring(0, 1);
      d = d.substring(1);

      switch c {
        case "M":
          beginShape = list.length;
          prev = "L";
          smooth = null;
          var p = capturePoint();
          if(last != p)
            last = p;
        case "m":
          beginShape = list.length;
          prev = "l";
          smooth = null;
          var p = capturePoint();
          last = last + p;
        case "L":
          prev = "L";
          smooth = null;
          var p = capturePoint();
          list.push(new LineSegment(last, last = p));
        case "l":
          prev = "l";
          smooth = null;
          var p = capturePoint();
          list.push(new LineSegment(last, last = last + p));
        case "Q":
          prev = "Q";
          var ps = capturePoints(2);
          list.push(new QuadraticCurveSegment(last, smooth = ps[0], last = ps[1]));
        case "q":
          prev = "q";
          var ps = capturePoints(2);
          list.push(new QuadraticCurveSegment(last, smooth = last + ps[0], last = last + ps[1]));
        case "C":
          prev = "C";
          var ps = capturePoints(3);
          list.push(new CubicCurveSegment(last, ps[0], smooth = ps[1], last = ps[2]));
        case "c":
          prev = "c";
          var ps = capturePoints(3);
          list.push(new CubicCurveSegment(last, last + ps[0], smooth = last + ps[1], last = last + ps[2]));
        case "H":
          prev = "H";
          smooth = null;
          var x = captureOne(),
              p = last.clone();
          p.x = x;
          list.push(new LineSegment(last, last = p));
        case "h":
          prev = "h";
          smooth = null;
          var x = captureOne(),
              p = last.clone();
          p.x += x;
          list.push(new LineSegment(last, last = p));
        case "V":
          smooth = null;
          prev = "V";
          var y = captureOne(),
              p = last.clone();
          p.y = y;
          list.push(new LineSegment(last, last = p));
        case "v":
          smooth = null;
          prev = "v";
          var y = captureOne(),
              p = last.clone();
          p.y += y;
          list.push(new LineSegment(last, last = p));
        case "S":
          prev = "S";
          var ps = capturePoints(2);
          smooth = null != smooth ? smooth.reflection(last) : ps[0];
          list.push(new CubicCurveSegment(last, smooth, smooth = ps[0], last = ps[1]));
        case "s":
          smooth = null;
          var ps = capturePoints(2);
          smooth = null != smooth ? smooth.reflection(last) : last + ps[0];
          list.push(new CubicCurveSegment(last, smooth, smooth = last + ps[0], last = last + ps[1]));
        case "T":
          smooth = null;
          prev = "T";
          var p = capturePoint();
          smooth = null != smooth ? smooth.reflection(last) : last;
          list.push(new QuadraticCurveSegment(last, smooth, last = p));
        case "t":
          smooth = null;
          prev = "t";
          var p = capturePoint();
          smooth = null != smooth ? smooth.reflection(last) : last;
          list.push(new QuadraticCurveSegment(last, smooth, last = last + p));
        case "A":
          smooth = null;
          prev = "A";
          var a = capture(7);
          list.push(new ArcSegment(
            last,
            Vector.create(a[0], a[1]),
            a[3] != 0,
            a[4] != 0,
            new MutableDim(a[2]),
            last = Point.create(a[5], a[6])
          ));
        case "a":
          smooth = null;
          prev = "a";
          var a = capture(7);
          list.push(new ArcSegment(
            last,
            Vector.create(a[0], a[1]),
            a[3] != 0,
            a[4] != 0,
            new MutableDim(a[2]),
            last = last + Point.create(a[5], a[6])
          ));
        case "z", "Z":
          smooth = null;
          var first = list[beginShape];
          if(null != first && !first.start.equals(last)) {
            list.push(new LineSegment(last, first.start));
          }
        case ".":
          d = '0.$d'; // numbers with no integer part
        case "-","0","1","2","3","4","5","6","7","8","9","e": // implicit repeat command
          d = prev+c+d;
        case v if(isFiller(v) || v == ""): // skip
        case v:
          throw 'invalid command "$v" in $d';
      }
    }
    return list;
  }

  static function isFiller(s : String) {
    var c = s.substring(0, 1);
    return c == " " || c == "\n" || c == "," || c == "\t";
  }

  static function isNumerical(s : String) {
    var c = s.substring(0, 1);
    return switch c {
      case "-","0","1","2","3","4","5","6","7","8","9","e",".": true;
      case _: false;
    };
  }
}
