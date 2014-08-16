package thx.geom;

class SplineNode {
	public var point(default, null) : Point;
	public var normalIn(default, null) : Null<Point>;
	public var normalOut(default, null) : Null<Point>;

	public function new(point : Point, normalout : Point, normalin : Point) {
		this.point = point;
		this.normalOut = null == normalout || normalout.nearEquals(point) ? null : normalout;
		this.normalIn = null == normalin || normalin.nearEquals(point) ? null : normalin;
	}

	public function transform(matrix : Matrix4x4)
		return new SplineNode(
			point.transform(matrix),
			null != normalIn ? normalIn.transform(matrix) : null,
			null != normalOut ? normalOut.transform(matrix) : null
		);

	public function flip()
		return new SplineNode(point, normalIn, normalOut);

	public function toStringValues() {
		var nout = null == normalOut ? 'null' : '${normalOut.y},${normalOut.y}',
			nin  = null == normalIn ? 'null' : '${normalIn.y},${normalIn.y}';
		return '${point.x},${point.y},$nout,$nin';
	}

	public function toString() {
		return 'SplineNode(${toStringValues()})';
	}
}