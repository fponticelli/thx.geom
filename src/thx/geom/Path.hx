package thx.geom;

using thx.core.Iterators;

class Path {
	@:isVar public var area(get, null) : Float;
	@:isVar public var length(get, null) : Float;
	@:isVar public var isSelfIntersecting(get, null) : Bool;
	@:isVar public var isPolygon(get, null) : Bool;
	var edges : Array<Edge>;

	public static function fromPoints(arr : Array<Array<Point>>, ?closed : Bool) {
		var nodes = arr.map(function(c) {
				return new PathNode(c[0], c[1], c[2]);
			});
		return new Path(nodes, closed);
	}

	public static function fromArray(arr : Array<Point>, ?closed : Bool) {
		var nodes = arr.map(function(c) {
				return new PathNode(c, null, null);
			});
		return new Path(nodes, closed);
	}

	public static function fromCoords(arr : Array<Array<Float>>, ?closed : Bool) {
		var nodes = arr.map(function(c) {
				var p    = new Point(c[0], c[1]),
					nout = null == c[2] ? Point.zero : new Point(c[2], c[3]),
					nin  = null == c[4] ? Point.zero : new Point(c[4], c[5]);
				return new PathNode(p, nout, nin);
			});
		return new Path(nodes, closed);
	}

	var nodes : Array<PathNode>;
	public var closed(default, null) : Bool;
	public function new(nodes : Array<PathNode>, closed = true) {
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

	public function iterateSides(f : Edge -> Void) {
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
			result = new Path(iterator().map(function(node) return node.transform(matrix)), closed);
		if(ismirror)
			result = result.flip();
		return result;
	}

	public function flip() {
		var arr = iterator().map(function(node) return node.flip());
		arr.reverse();
		return new Path(arr, closed);
	}

	function get_area() : Float {
		compute();
		return area;
	}
	function get_length() : Float {
		compute();
		return length;
	}
	function get_isSelfIntersecting() : Bool {
		compute();
		return isSelfIntersecting;
	}
	function get_isPolygon() : Bool {
		compute();
		return isPolygon;
	}

	var computed = false;
	function compute() {
		if(computed) return;
		area = 0;
		length = 0;
		isSelfIntersecting = false;
		isPolygon = true;
		iterateSides(function(side) {
			length += side.length;

			// TODO AREA
			// TODO ISSELFINTERSECTING

			if(isPolygon && !side.isLinear())
				isPolygon = false;
		});
	}

//  public function at(distance : Float) : Point {
//
//	}

//  public function interpolate(distance : Float) : Point {
//
//	}

//  public function tangent(distance : Float) : Vertex {
//
//	}

//  public function interpolateTangent(distance : Float) : Vertex {
//
//	}


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
		return 'Path(${nodes.map(function(n) return "["+n.toStringValues()+"]").join(", ")},$closed)';
	}
}