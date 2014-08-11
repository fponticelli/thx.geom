package thx.geom;

class Path {
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
					nout = null == c[2] ? null : new Point(c[2], c[3]),
					nin  = null == c[4] ? null : new Point(c[4], c[5]);
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

	public function iterate(?fstart : Point -> Void, fit : Point -> Point -> Null<Point> -> Null<Point> -> Void) {
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

	public function toString() {
		return 'Path(${nodes.map(function(n) return "["+n.toStringValues()+"]").join(", ")},$closed)';
	}
}