package thx.geom.shape;

import thx.geom.Point;

abstract Box(Array<Point>) {
	public static function fromPoints(a : Point, b : Point)
		return new Box(
			a.min(b),
			a.max(b)
		);

	inline public function new(bottomLeft : Point, topRight : Point)
		this = [bottomLeft, topRight];

	public var topLeft(get, never) : Point;
	public var topRight(get, never) : Point;
	public var bottomRight(get, never) : Point;
	public var bottomLeft(get, never) : Point;
	public var center(get, never) : Point;
	public var left(get, never) : Float;
	public var right(get, never) : Float;
	public var top(get, never) : Float;
	public var bottom(get, never) : Float;
	public var width(get, never) : Float;
	public var height(get, never) : Float;

	inline function get_topLeft() return new Point(left, top);
	inline function get_topRight() return this[1];
	inline function get_bottomLeft() return this[0];
	inline function get_bottomRight() return new Point(right, bottom);
	inline function get_center() return new Point(left + width / 2, top + height / 2);
	inline function get_left() return bottomLeft.x;
	inline function get_right() return topRight.x;
	inline function get_top() return topRight.y;
	inline function get_bottom() return bottomLeft.y;
	inline function get_width() return right - left;
	inline function get_height() return bottom - top;

	public function expandByPoint(point : Point) : Box
		return new Box(bottomLeft.min(point), topRight.max(point));

	@:to public function toString()
		return 'Box(${topLeft.x},${topLeft.y},$width,$height)';

	@:to public function toPath() {
		return Path.fromArray([
				topLeft,
				topRight,
				bottomRight,
				bottomLeft
			], true);
	}
}