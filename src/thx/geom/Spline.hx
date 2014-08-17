package thx.geom;

using thx.core.Iterators;
import thx.geom.shape.Box;

class Spline {
	@:isVar public var area(get, null) : Float;
	@:isVar public var length(get, null) : Float;
	@:isVar public var isSelfIntersecting(get, null) : Bool;
	@:isVar public var isPolygon(get, null) : Bool;
	@:isVar public var box(get, null) : Box;
	@:isVar public var edges(get, null) : Array<Edge>;

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
	public var isClosed(default, null) : Bool;
	public function new(nodes : Array<SplineNode>, closed = true) {
		this.nodes = nodes;
		this.isClosed = closed;
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
		if(isClosed) {
			a = nodes[nodes.length-1];
			b = nodes[0];
			fit(a.point, b.point, a.normalOut, b.normalIn);
		}
	}

	static function createEdge(a, b, nout, nin) : Edge {
		if(null == nout && null == nin)
			return new EdgeLinear(a, b);
		else if(null != nout)
			return new EdgeCubic(a, nout, b, b);
		else if(null != nin)
			return new EdgeCubic(a, a, nin, b);
		else
			return new EdgeCubic(a, nout, nin, b);
	}

	public function iterateEdges(f : Edge -> Void) {
		edges.map(f);
	}

	function get_edges() {
		if(null == edges) {
			edges = [];
			iterate(function(a, b, nout, nin) {
				edges.push(createEdge(a, b, nout, nin));
			});
		}
		return edges;
	}

	public function transform(matrix : Matrix4x4) {
		var ismirror = matrix.isMirroring(),
			result = new Spline(iterator().map(function(node) return node.transform(matrix)), isClosed);
		if(ismirror)
			result = result.flip();
		return result;
	}

	public function flip() {
		var arr = iterator().map(function(node) return node.flip());
		arr.reverse();
		return new Spline(arr, isClosed);
	}

	public function contains(p : Point) {
		throw 'not implemented';
	}

	public function intersectsPath(other : Path) : Bool
		return intersectionsPath(other).length > 0;

	public function intersectsSpline(other : Spline) : Bool
		return intersectionsSpline(other).length > 0;

	public function intersectsLine(line : Line) : Bool
		return intersectionsLine(line).length > 0;

	public function intersectionsPath(other : Path) : Array<Point> {
		throw 'not implemented';
	}

	public function intersectionsSpline(other : Spline) : Array<Point> {
		throw 'not implemented';
	}

	public function intersectionsLine(line : Line) : Array<Point> {
		throw 'not implemented';
	}

	public function split(value : Float) : Point {
		throw 'not implemented';
	}

	public function interpolate(value : Float) : Point {
		throw 'not implemented';
	}

	public function toString() {
		return 'Spline(${nodes.map(function(n) return "["+n.toStringValues()+"]").join(", ")},$isClosed)';
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
		if(null == isSelfIntersecting) {
			var edges = edges;
			isSelfIntersecting = false;
			for(i in 0...edges.length) {
				for(j in i + 1...edges.length) {
					if(edges[j].intersects(edges[i])) {
						isSelfIntersecting = true;
						break;
					}
				}
			}
		}
		return isSelfIntersecting;
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
}