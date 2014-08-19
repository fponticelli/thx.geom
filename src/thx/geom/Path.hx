package thx.geom;

import thx.geom.shape.Box;
using thx.core.Arrays;

class Path {
	@:isVar public var area(get, null) : Float;
	@:isVar public var length(get, null) : Float;
	@:isVar public var isSelfIntersecting(get, null) : Bool;
	@:isVar public var isClosed(get, null) : Bool;
	@:isVar public var box(get, null) : Box;

	var splines : Array<Spline>;
	public function new(splines : Array<Spline>)
		this.splines = splines; // TODO? .filter(function(spline) return !spline.isEmpty);

	public function contains(p : Point) : Bool {
		for(spline in splines)
			if(spline.contains(p))
				return true;
		return false;
	}

	public function union(other : Path) : Null<Path> {
		return throw 'not implemented';
	}

	public function difference(other : Path) : Null<Path> {
		return throw 'not implemented';
	}

	public function intersection(other : Path) : Null<Path> {
		return throw 'not implemented';
	}

	public function intersections(other : Path) : Array<Point> {
		return throw 'not implemented';
	}

	public function transform(matrix : Matrix4x4)
		return new Path(splines.map(function(spline) return spline.transform(matrix)));

	public function flip() {
		var s = splines.map(function(spline) return spline.flip());
		s.reverse();
		return new Path(s);
	}

	public function intersectsPath(other : Path) : Bool
		return intersectionsPath(other).length > 0;

	public function intersectsSpline(other : Spline) : Bool
		return intersectionsSpline(other).length > 0;

	public function intersectsLine(line : Line) : Bool
		return intersectionsLine(line).length > 0;

	public function intersectionsPath(other : Path) : Array<Point>
		return splines.map(function(spline) {
			return spline.intersectionsPath(other);
		}).flatten();

	public function intersectionsSpline(other : Spline) : Array<Point>
		return splines.map(function(spline) {
			return spline.intersectionsSpline(other);
		}).flatten();

	public function intersectionsLine(line : Line) : Array<Point> {
		return splines.map(function(spline) {
			return spline.intersectionsLine(line);
		}).flatten();
	}

	// TODO, review since it produces too many points
	public function selfIntersections() {
		var intersections = [];
		for(i in 0...splines.length) {
			intersections = intersections.concat(splines[i].selfIntersections());
			for(j in i...splines.length) {
				intersections = intersections.concat(splines[i].intersectionsSpline(splines[j]));
			}
		}
		return intersections;
	}

	public function split(value : Float) : Array<Path> {
		var len = length,
			l, spline;
		for(i in 0...splines.length) {
			spline = splines[i];
			l = spline.length / len;
			if(value <= l) {
				var n = spline.split(value);
				return [
					new Path(splines.slice(0, i).concat([n[0]])),
					new Path([n[1]].concat(splines.slice(i)))
				];
			}
			value -= l;
		}
		return [];
	}

	public function interpolate(value : Float) : Null<Point> {
		var len = length, l;
		for(spline in splines) {
			l = spline.length / len;
			if(value <= l)
				return spline.interpolate(value);
			value -= l;
		}
		return null;
	}

	public function hull(other : Spline) {
		return throw 'not implemented';
	}

	public function minkowsky(other : Spline) {
		return throw 'not implemented';
	}

	public function toPoints()
		return splines.map(function(spline) return spline.toPoints()).flatten();

	public function toString()
		return 'Path(${splines.map(function(s) return "["+s.toString()+"]").join(", ")},$isClosed)';

	function get_isClosed() : Bool {
		if(null == isClosed) {
			isClosed = true;
			for(spline in splines) {
				if(!spline.isClosed) {
					isClosed = false;
					break;
				}
			}
		}
		return isClosed;
	}
	function get_area() : Float {
		if(null == area)
			area = splines.reduce(function(acc, spline) return acc + spline.area, 0);
		return area;
	}
	function get_length() : Float {
		if(null == length)
			length = splines.reduce(function(acc, spline) return acc + spline.length, 0);
		return length;
	}
	function get_isSelfIntersecting() : Bool {
		if(null == isSelfIntersecting) {
			isSelfIntersecting = false;
			for(spline in splines) {
				if(spline.isSelfIntersecting) {
					isSelfIntersecting = true;
					break;
				}
			}
		}
		return isSelfIntersecting;
	}
	function get_box() : Box {
		if(null == box) {
			if(splines.length == 0)
				return null;
			box = splines[0].box;
			for(i in 1...splines.length) {
				var obox = splines[i].box;
				box = box.expandByPoints([obox.bottomLeft, obox.topRight]);
			}
		}
		return box;
	}

//https://github.com/andrewseidl/node-quick-hull-2d/blob/master/quickhull.js
//function cross(o, a, b) {
//   return (a[0] - o[0]) * (b[1] - o[1]) - (a[1] - o[1]) * (b[0] - o[0])
//}
//
///**
// * @param points An array of [X, Y] coordinates
// */
//function convexHull(points) {
//   points.sort(function(a, b) {
//      return a[0] == b[0] ? a[1] - b[1] : a[0] - b[0];
//   });
//
//   var lower = [];
//   for (var i = 0; i < points.length; i++) {
//      while (lower.length >= 2 && cross(lower[lower.length - 2], lower[lower.length - 1], points[i]) <= 0) {
//         lower.pop();
//      }
//      lower.push(points[i]);
//   }
//
//   var upper = [];
//   for (var i = points.length - 1; i >= 0; i--) {
//      while (upper.length >= 2 && cross(upper[upper.length - 2], upper[upper.length - 1], points[i]) <= 0) {
//         upper.pop();
//      }
//      upper.push(points[i]);
//   }
//
//   upper.pop();
//   lower.pop();
//   return lower.concat(upper);
//}
}