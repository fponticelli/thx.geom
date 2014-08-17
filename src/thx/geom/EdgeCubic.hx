package thx.geom;

import thx.geom.shape.Box;

class EdgeCubic implements Edge {
	@:isVar public var box(get, null) : Box;
	@:isVar public var area(get, null) : Float;
	@:isVar public var length(get, null) : Float;
	@:isVar public var lengthSquared(get, null) : Float;
	public var isLinear(default, null) : Bool;
	public var p0(default, null) : Point;
	public var p1(default, null) : Point;
	public var p2(default, null) : Point;
	public var p3(default, null) : Point;
	public var first(default, null) : Point;
	public var last(default, null) : Point;

	public function new(p0 : Point, p1 : Point, p2 : Point, p3 : Point) {
		isLinear = false;
		first = this.p0 = p0;
		this.p1 = p1;
		this.p2 = p2;
		last = this.p3 = p3;
	}
	public function equals(other : Edge) : Bool {
		if(!Std.is(other, EdgeCubic)) return false;
		var t : EdgeCubic = cast other;
		return p0.nearEquals(t.p0) && p1.nearEquals(t.p1) && p2.nearEquals(t.p2) && p3.nearEquals(t.p3);
	}

	public function matches(other : Edge) : Bool
		return first.nearEquals(other.first) && last.nearEquals(other.last);

	public function transform(matrix : Matrix4x4) : EdgeCubic
		return new EdgeCubic(p0.transform(matrix), p1.transform(matrix), p2.transform(matrix), p3.transform(matrix));

	public function flip() : Edge
		return new EdgeCubic(p3, p2, p1, p0);

	public function direction() : Point
		return last - first;

	public function intersects(other : Edge) : Bool
		return intersections(other).length > 0;

	public function intersections(other : Edge) : Array<Point>
		return throw "not implemented";

	public function intersectsWithLine(line : Line) : Bool
		return intersectionsWithLine(line).length > 0;

	public function intersectionsWithLine(line : Line) : Array<Point>
		return throw "not implemented";

	public function split(v : Float) : Array<Edge>
		return throw "not implemented";

	public function interpolate(v : Float) : Point
		return throw "not implemented";

	public function toString() : String
		return 'Edge($p0,$p1,$p2,$p3)';

	function get_area() : Float
		return throw "not implemented";

	function get_box() : Box {
		if(null == box)
			box = Box.fromPoints(p0, p1).expandByPoints([p2, p3]);
		return box;
	}

	function get_length() : Float {
		if(null == length)
			length = Math.sqrt(lengthSquared);
		return length;
	}

	function get_lengthSquared() : Float
		return throw "not implemented";

}