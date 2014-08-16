package thx.geom;

class PathNode {
	public var point(default, null) : Point;
	public var normalIn(default, null) : Point;
	public var normalOut(default, null) : Point;

	public function new(point : Point, normalout : Point, normalin : Point) {
		this.point = point;
		this.normalOut = normalout;
		this.normalIn = normalin;
	}

	public function transform(matrix : Matrix4x4)
		return new PathNode(
			point.transform(matrix),
			normalIn.transform(matrix),
			normalOut.transform(matrix)
		);

	public function flip()
		return new PathNode(point, normalIn, normalOut);

	public function toStringValues() {
		var nout = null == normalOut ? 'null' : '${normalOut.y},${normalOut.y}',
			nin  = null == normalIn ? 'null' : '${normalIn.y},${normalIn.y}';
		return '${point.x},${point.y},$nout,$nin';
	}

	public function toString() {
		return 'PathNode(${toStringValues()})';
	}
}