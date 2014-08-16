package thx.geom;

using thx.core.Iterators;
import thx.geom.shape.Box;

class Spline {
	@:isVar public var area(get, null) : Float;
	@:isVar public var length(get, null) : Float;
	@:isVar public var isSelfIntersecting(get, null) : Bool;
	@:isVar public var isPolygon(get, null) : Bool;
	@:isVar public var box(get, null) : Box;
	var edges : Array<Edge>;

	public static function fromPoints(arr : Array<Array<Point>>, ?closed : Bool) {
		var nodes = arr.map(function(c) {
				return new SplineNode(c[0], c[1], c[2]);
			});
		return new Spline(nodes, closed);
	}

	public static function fromArray(arr : Array<Point>, ?closed : Bool) {
		var nodes = arr.map(function(c) {
				return new SplineNode(c, null, null);
			});
		return new Spline(nodes, closed);
	}

	public static function fromCoords(arr : Array<Array<Float>>, ?closed : Bool) {
		var nodes = arr.map(function(c) {
				var p    = new Point(c[0], c[1]),
					nout = null == c[2] ? Point.zero : new Point(c[2], c[3]),
					nin  = null == c[4] ? Point.zero : new Point(c[4], c[5]);
				return new SplineNode(p, nout, nin);
			});
		return new Spline(nodes, closed);
	}

	var nodes : Array<SplineNode>;
	public var closed(default, null) : Bool;
	public function new(nodes : Array<SplineNode>, closed = true) {
		this.nodes = nodes;
		this.closed = closed;
	}

	public function iterator()
		return nodes.iterator();

	public function iterate(?fstart : Point -> Void, fit : Point -> Point -> Point -> Point -> Void) {
		var a,b;
		if(null != fstart)
			fstart(nodes[0].point);
		for(i in 0...nodes.length - 1) {
			a = nodes[i];
			b = nodes[i+1];
			fit(a.point, b.point, a.normalOut, b.normalIn);
		}
		if(closed) {
			a = nodes[nodes.length-1];
			b = nodes[0];
			fit(a.point, b.point, a.normalOut, b.normalIn);
		}
	}

	public function iterateEdges(f : Edge -> Void) {
		if(null != edges)
			edges.map(f);
		else {
			edges = [];
			iterate(function(a, b, nout, nin) {
				var side = new Edge(new Vertex(a, nout), new Vertex(b, nin));
				edges.push(side);
				f(side);
			});
		}
	}

	public function transform(matrix : Matrix4x4) {
		var ismirror = matrix.isMirroring(),
			result = new Spline(iterator().map(function(node) return node.transform(matrix)), closed);
		if(ismirror)
			result = result.flip();
		return result;
	}

	public function flip() {
		var arr = iterator().map(function(node) return node.flip());
		arr.reverse();
		return new Spline(arr, closed);
	}

	function get_area() : Float {
		if(null == area) {
			area = 0;
			iterateEdges(function(edge) {
				area += edge.area;
			});
		}
		return area;
	}
	function get_length() : Float {
		if(null == length) {
			length = 0;
			iterateEdges(function(edge) {
				length += edge.length;
			});
		}
		return length;
	}
	function get_isSelfIntersecting() : Bool {
		return false;
	}
	function get_isPolygon() : Bool {
		return false;
	}
	function get_box() : Box {
		if(null == box) {
			if(nodes.length > 0) {
				box = new Box(nodes[0].point, nodes[0].point);
				iterate(function(a, b, nout, nin) {
					box = box.expandByPoints([a, b, nout, nin]);
				});
			}
		}
		return box;
	}

	public function contains(p : Point) {
		throw 'not implemented';
	}

	public function intersectionsWithSpline(other : Spline) {
		throw 'not implemented';
	}

	public function intersectionsWithLine(line : Line) {
		throw 'not implemented';
	}

	public function at(distance : Float) : Point {
		throw 'not implemented';
	}

	public function interpolate(distance : Float) : Point {
		throw 'not implemented';
	}

	public function tangent(distance : Float) : Vertex {
		throw 'not implemented';
	}

	public function interpolateTangent(distance : Float) : Vertex {
		throw 'not implemented';
	}


//	public function getArea() {
//		var area = 0.0;
//		for(side in edges)
//			area += side.vertex0.position.cross(side.vertex1.position);
//		return area / 2;
//	}

//	public function isSelfIntersecting() {
//		var length = edges.length,
//			side0, side1;
//		for(i in 0...length) {
//			side0 = edges[i];
//			for(j in i + 1...length) {
//				side1 = edges[j];
//				if(side1.intersects(side0)) {
//					return true;
//				}
//			}
//		}
//	}

	public function toString() {
		return 'Spline(${nodes.map(function(n) return "["+n.toStringValues()+"]").join(", ")},$closed)';
	}
}