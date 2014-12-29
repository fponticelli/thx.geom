package thx.geom;

class SplineNode {
  public var position(default, null) : Point;
  public var normalIn(default, null) : Null<Point>;
  public var normalOut(default, null) : Null<Point>;

  public function new(position : Point, ?normalout : Point, ?normalin : Point) {
    this.position = position;
    this.normalOut = null == normalout || normalout.nearEquals(position) ? null : normalout;
    this.normalIn = null == normalin || normalin.nearEquals(position) ? null : normalin;
  }

  public function transform(matrix : Matrix4x4)
    return new SplineNode(
      position.transform(matrix),
      null != normalOut ? normalOut.transform(matrix) : null,
      null != normalIn ? normalIn.transform(matrix) : null
    );

  public function flip()
    return new SplineNode(position, normalIn, normalOut);

  public function toStringValues() {
    var nout = null == normalOut ? 'null' : '${normalOut.y},${normalOut.y}',
      nin  = null == normalIn ? 'null' : '${normalIn.y},${normalIn.y}';
    return '${position.x},${position.y},$nout,$nin';
  }

  public function toString() {
    return 'SplineNode(${toStringValues()})';
  }
}