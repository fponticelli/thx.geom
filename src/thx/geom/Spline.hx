package thx.geom;

using thx.core.Arrays;
using thx.core.Iterators;
import thx.geom.shape.Box;

class Spline {
	@:isVar public var area(get, null) : Float;
	@:isVar public var length(get, null) : Float;
	@:isVar public var isSelfIntersecting(get, null) : Bool;
	@:isVar public var isPolygon(get, null) : Bool;
	@:isVar public var isEmpty(get, null) : Bool;
	@:isVar public var box(get, null) : Box;
	@:isVar public var edges(get, null) : Array<Edge>;

	public static function fromEdges(arr : Array<Edge>, ?closed : Bool) {
		var nodes = [], points;
		if(arr.length > 0) {
			var edge = arr[0], prev = closed ? arr[arr.length-1] : new EdgeLinear(Point.zero, Point.zero);
			if(arr.length == 1) {
				nodes.push(new SplineNode(
					edge.first,
					edge.normalOut,
					null
				));
				nodes.push(new SplineNode(
					edge.last,
					null,
					edge.normalIn
				));
			} else {
				for(i in 0...arr.length) {
					edge = arr[i];
					nodes.push(new SplineNode(
						edge.first,
						edge.normalOut,
						prev.normalIn));
					prev = edge;
				}
				if(!closed) {
					nodes.push(new SplineNode(
						edge.last,
						null,
						edge.normalIn
					));
				}
			}
		}
		var spline = new Spline(nodes, closed);
		//spline.edges = arr;
		return spline;
	}

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

	public static function fromCoords(arr : Array<Array<Null<Float>>>, ?closed : Bool) {
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
			fstart(nodes[0].position);
		for(i in 0...nodes.length - 1) {
			a = nodes[i];
			b = nodes[i+1];
			fit(a.position, b.position, a.normalOut, b.normalIn);
		}
		if(isClosed) {
			a = nodes[nodes.length-1];
			b = nodes[0];
			fit(a.position, b.position, a.normalOut, b.normalIn);
		}
	}

	static function createEdge(a, b, nout, nin) : Edge {
		if(null == nout && null == nin)
			return new EdgeLinear(a, b);
		else if(null == nout)
			return new EdgeCubic(a, a, nin, b);
		else if(null == nin)
			return new EdgeCubic(a, nout, b, b);
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
		//result = Spline.fromEdges(edges.map(function(edge) return edge.transform(matrix)), isClosed);
		if(ismirror)
			result = result.flip();
		return result;
	}

	public function flip() {
		var arr = iterator().map(function(node) return node.flip());
		arr.reverse();
		return new Spline(arr, isClosed);
	}

	public function contains(p : Point) : Bool {
		return throw 'not implemented';
	}

	public function selfIntersections() {
		var intersections = [];
		edges.eachPair(function(a,b) {
			intersections = intersections.concat(a.intersections(b));
			return true;
		});
		return intersections;
	}

	public function intersectsPath(other : Path) : Bool
		return intersectionsPath(other).length > 0;

	public function intersectsSpline(other : Spline) : Bool
		return intersectionsSpline(other).length > 0;

	public function intersectsLine(line : Line) : Bool
		return intersectionsLine(line).length > 0;

	public function intersectionsPath(other : Path) : Array<Point>
		return other.intersectionsSpline(this);

	public function intersectionsSpline(other : Spline) : Array<Point>
		return edges.map(function(a) {
			return other.edges.map(function(b) return a.intersections(b))
				.flatten();
		}).flatten();

	public function intersectionsLine(line : Line) : Array<Point>
		return edges.map(function(edge) {
			return edge.intersectionsLine(line);
		}).flatten();

	public function split(value : Float) : Array<Spline> {
		if(value < 0 || value > 1) return null;
		var len = length,
			nor,
			edge,
			edges = edges;
		for(i in 0...edges.length) {
			edge = edges[i];
			nor = edge.length / len;
			if(value <= nor) {
				var n = edge.split(value);
				return [
					Spline.fromEdges(edges.slice(0, i).concat([n[0]]), isClosed),
					Spline.fromEdges([n[1]].concat(edges.slice(i+1)), isClosed)
				];
			}
			value -= nor;
		}
		return [];
	}

	public function interpolate(value : Float) : Point {
		if(value < 0 || value > 1) return null;
		var len = length,
			nor;
		for(edge in edges) {
			nor = edge.length / len;
			if(value <= nor)
				return edge.interpolate(value);
			value -= nor;
		}
		return null;
	}

	public function toLinear() {
		var edges = edges.map(function(edge)
			return edge.linearSegments).flatten();
		return Spline.fromEdges(cast edges, isClosed);
	}

	public function toPath()
		return new Path([this]);

	public function toPoints()
		return nodes.map(function(node) return node.position);

	public function toString()
		return 'Spline(${nodes.map(function(n) return "["+n.toStringValues()+"]").join(", ")},$isClosed)';

	function get_area() : Float {
		if(Math.isNaN(area)) {
			area = 0;
			iterateEdges(function(edge) {
				area += edge.area;
			});
		}
		return area;
	}
	function get_length() : Float {
		if(Math.isNaN(length)) {
			length = 0;
			iterateEdges(function(edge) {
				length += edge.length;
			});
		}
		return length;
	}

	var _isSelfIntersecting = false;
	function get_isSelfIntersecting() : Bool {
		if(!_isSelfIntersecting) {
			_isSelfIntersecting = true;
			var edges = edges;
			isSelfIntersecting = false;
			edges.eachPair(function(a, b) return !(isSelfIntersecting = a.intersects(b)));
		}
		return isSelfIntersecting;
	}
	function get_isPolygon() : Bool {
		for(node in nodes)
			if(node.normalIn != null || node.normalOut != null)
				return false;
		return true;
	}
	function get_isEmpty() : Bool
		return nodes.length > 1; // a spline with zero or one node is not much of a spline
	function get_box() : Box {
		if(null == box) {
			if(nodes.length > 0) {
				box = new Box(nodes[0].position, nodes[0].position);
				iterate(function(a, b, nout, nin) {
					box = box.expandByPoints([a, b, nout, nin]);
				});
			}
		}
		return box;
	}
}