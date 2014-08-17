package thx.geom;

import thx.geom.shape.Box;

class Path {
	@:isVar public var area(get, null) : Float;
	@:isVar public var length(get, null) : Float;
	@:isVar public var isSelfIntersecting(get, null) : Bool;
	@:isVar public var isClosed(get, null) : Bool;
	@:isVar public var box(get, null) : Box;

	var splines : Array<Spline>;
	public function new(splines : Array<Spline>)
		this.splines = splines;

	public function contains(p : Point) : Bool {
		return throw 'not implemented';
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

	public function transform(matrix : Matrix4x4) {
		return throw 'not implemented';
	}

	public function flip() {
		return throw 'not implemented';
	}

	public function intersectsPath(other : Path) : Bool
		return intersectionsPath(other).length > 0;

	public function intersectsSpline(other : Spline) : Bool
		return intersectionsSpline(other).length > 0;

	public function intersectsLine(line : Line) : Bool
		return intersectionsLine(line).length > 0;

	public function intersectionsPath(other : Path) : Array<Point> {
		return throw 'not implemented';
	}

	public function intersectionsSpline(other : Spline) : Array<Point> {
		return throw 'not implemented';
	}

	public function intersectionsLine(line : Line) : Array<Point> {
		return throw 'not implemented';
	}

	public function split(value : Float) : Point {
		return throw 'not implemented';
	}

	public function interpolate(value : Float) : Point {
		return throw 'not implemented';
	}

	public function hull(other : Spline) {
		return throw 'not implemented';
	}

	public function minkowsky(other : Spline) {
		return throw 'not implemented';
	}

	public function toString() {
		return 'Path(${splines.map(function(s) return "["+s.toString()+"]").join(", ")},$isClosed)';
	}

	function get_isClosed() : Bool {
		if(null == isClosed) {
			return throw 'not implemented';
		}
		return isClosed;
	}
	function get_area() : Float {
		if(null == area) {
			return throw 'not implemented';
		}
		return area;
	}
	function get_length() : Float {
		if(null == length) {
			return throw 'not implemented';
		}
		return length;
	}
	function get_isSelfIntersecting() : Bool {
		if(null == isSelfIntersecting) {
			return throw 'not implemented';
		}
		return isSelfIntersecting;
	}
	function get_box() : Box {
		if(null == box) {
			return throw 'not implemented';
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