package thx.geom;

import thx.geom.shape.Box;

class EdgeLinear implements Edge {
	@:isVar public var area(get, null) : Float;
	@:isVar public var box(get, null) : Box;
	@:isVar public var length(get, null) : Float;
	@:isVar public var lengthSquared(get, null) : Float;
	@:isVar public var line(get, null) : Line;
	public var isLinear(default, null) : Bool;
	public var p0(default, null) : Point;
	public var p1(default, null) : Point;
	public var first(default, null) : Point;
	public var last(default, null) : Point;

	public function new(p0 : Point, p1 : Point) {
		isLinear = true;
		first = this.p0 = p0;
		last = this.p1 = p1;
	}
	public function equals(other : Edge) : Bool {
		if(!Std.is(other, EdgeLinear)) return false;
		var t : EdgeLinear = cast other;
		return p0.nearEquals(t.p0) && p1.nearEquals(t.p1);
	}

	public function matches(other : Edge) : Bool
		return first.nearEquals(other.first) && last.nearEquals(other.last);

	public function transform(matrix : Matrix4x4) : EdgeLinear
		return new EdgeLinear(p0.transform(matrix), p1.transform(matrix));

	public function flip() : EdgeLinear
		return new EdgeLinear(p1, p0);

	public function direction() : Point
		return last - first;

	public function intersects(other : Edge) : Bool
		return intersections(other).length > 0;

	public function intersections(other : Edge) : Array<Point> {
		if(!box.intersects(other.box))
			return [];
		if(Std.is(other, EdgeLinear)) {
			var other : EdgeLinear = cast other;
			var ps = intersectionsLine(other.line);
			if(ps.length == 0 || other.intersectsLine(line))
				return ps;
			else
				return [];
		} else {
			var other : EdgeCubic = cast other;
			// TODO
			return throw "not implemented";
		}
	}

	public function intersectsLine(line : Line) : Bool
		return intersectionsLine(line).length > 0;

	public function intersectionsLine(line : Line) : Array<Point> {
		var l = Line.fromPoints(p0, p1),
			p = l.intersectionLine(line);
		if(null == p || p.x < p0.min(p1).x || p.x > p0.max(p1).x)
			return [];
		return [p];
	}

	public function split(v : Float) : Array<Edge> {
		var mid = interpolate(v);
		return [
			new EdgeLinear(p0, mid),
			new EdgeLinear(mid, p1)
		];
	}

	public function interpolate(v : Float) : Point
		return p0.interpolate(p1, v);

	public function toArray()
		return [p0,p1];

	public function toString() : String
		return 'Edge($p0,$p1)';

	function get_area() : Float {
		if(null == area) {
			var p = p1 - p0;
			area = p.x * p.y / 2;
		}
		return area;
	}

	function get_box() : Box {
		if(null == box) {
			box = Box.fromPoints(p0, p1);
		}
		return box;
	}

	function get_length() : Float {
		if(null == length)
			length = Math.sqrt(lengthSquared);
		return length;
	}

	function get_lengthSquared() {
		if(null == lengthSquared)
			lengthSquared = (p1-p0).lengthSquared;
		return lengthSquared;
	}

	function get_line() : Line {
		if(null == line)
			line = Line.fromPoints(p0, p1);
		return line;
	}
}