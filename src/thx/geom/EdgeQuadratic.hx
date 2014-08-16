package thx.geom;

class EdgeQuadratic implements Edge {
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
		if(!Std.is(other, EdgeQuadratic)) return false;
		var t : EdgeQuadratic = cast other;
		return p0.nearEquals(t.p0) && p1.nearEquals(t.p1) && p2.nearEquals(t.p2) && p3.nearEquals(t.p3);
	}

	public function matches(other : Edge) : Bool
		return first.nearEquals(other.first) && last.nearEquals(other.last);

	public function intersects(other : Edge) : Bool
		return intersectionsWithEdge(other).length > 0;

	public function transform(matrix : Matrix4x4) : EdgeQuadratic
		return new EdgeQuadratic(p0.transform(matrix), p1.transform(matrix), p2.transform(matrix), p3.transform(matrix));

	public function flip() : Edge
		return new EdgeQuadratic(p3, p2, p1, p0);

	public function direction() : Point
		return last - first;

	public function intersectionsWithEdge(other : Edge) : Array<Point>
		return throw "not implemented";

	public function intersectionsWithLine(line : Line) : Array<Point>
		return throw "not implemented";

	public function split(v : Float) : Array<Edge>
		return throw "not implemented";

	public function interpolate(v : Float) : Point
		return throw "not implemented";

	public function tangent(v : Float) : Vertex
		return throw "not implemented";

	public function toString() : String
		return 'Edge($p0,$p1,$p2,$p3)';

	function get_area() : Float
		return throw "not implemented";

	function get_length() : Float
		return throw "not implemented";

	function get_lengthSquared() : Float
		return throw "not implemented";

}