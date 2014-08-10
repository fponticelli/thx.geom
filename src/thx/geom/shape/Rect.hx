package thx.geom.shape;

import thx.geom.Point;

abstract Rect(Array<Point>) {
	inline public function new(topLeft : Point, bottomRight : Point)
		this = [topLeft, bottomRight];

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

	inline function get_topLeft() return this[0];
	inline function get_topRight() return new Point(right, top);
	inline function get_bottomLeft() return new Point(left, bottom);
	inline function get_bottomRight() return this[1];
	inline function get_center() return new Point(left + width / 2, top + height / 2);
	inline function get_left() return topLeft.x;
	inline function get_right() return bottomRight.x;
	inline function get_top() return topLeft.y;
	inline function get_bottom() return bottomRight.y;
	inline function get_width() return right - left;
	inline function get_height() return bottom - top;

	@:to public function toString()
		return 'Rect(${topLeft.x},${topLeft.y},$width,$height)';
}