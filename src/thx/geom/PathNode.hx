package thx.geom;

class PathNode {
	public var point(default, null) : Point;
	public var normalIn(default, null) : Null<Point>;
	public var normalOut(default, null) : Null<Point>;

	public function new(point : Point, normalout : Point, normalin : Point) {
		this.point = point;
		this.normalOut = normalout;
		this.normalIn = normalin;
	}

	public function toStringValues() {
		var nout = null == normalOut ? 'null' : '${normalOut.y},${normalOut.y}',
			nin  = null == normalIn ? 'null' : '${normalIn.y},${normalIn.y}';
		return '${point.x},${point.y},$nout,$nin';
	}

	public function toString() {
		return 'PathNode(${toStringValues()})';
	}
}