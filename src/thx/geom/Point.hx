package thx.geom;

abstract Point(Array<Float>) {
	public static var zero(default, null) : Point = new Point(0, 0);

	@:from static inline function fromObject(o : { x : Float, y : Float })
		return new Point(o.x, o.y);

	@:from static inline function fromArray(arr : Array<Int>)
		return new Point(arr[0], arr[1]);

	@:from static inline public function fromAngle(angle : Angle)
		return new Point(Math.cos(angle), Math.sin(angle));

	inline public function new(x : Float, y : Float)
		this = [x, y];

	public var x(get, never) : Float;
	public var y(get, never) : Float;
	public var length(get, never) : Float;
	public var lengthSquared(get, never) : Float;
	private var inst(get, never) : Point;

	inline function get_x() return this[0];
	inline function get_y() return this[1];
	inline function get_length() return Math.sqrt(lengthSquared);
	inline function get_lengthSquared() return x * x + y * y;
	inline function get_inst() : Point return cast this;

	@:op(A+B) inline public function addPoint(p : Point)
		return new Point(x + p.x, y + p.y);

	@:op(A+B) inline public function add(v : Float)
		return new Point(x + v, y + v);

	@:op(-A) inline public function negate()
		return new Point(-x, -y);

	@:op(A-B) inline public function subtractPoint(p : Point)
		return addPoint(p.negate());

	@:op(A-B) inline public function subtract(v : Float)
		return add(-v);

	@:op(A*B) inline public function multiplyPoint(p : Point)
		return new Point(x * p.x, y * p.y);

	@:commutative
	@:op(A*B) inline public function multiply(v : Float)
		return new Point(x * v, y * v);

	@:op(A/B) inline public function dividePoint(p : Point)
		return new Point(x / p.x, y / p.y);

	@:op(A/B) inline public function divide(v : Float)
		return new Point(x / v, y / v);

	@:op(A==B)
	inline public function equals(p : Point)
		return (x == p.x) && (y == p.y);

	@:op(A!=B)
	inline public function notEquals(p : Point)
		return !equals(p);

	inline public function abs() : Point
		return new Point(Math.abs(x), Math.abs(y));

	inline public function nearEquals(p : Point)
		return Math.abs(x - p.x) <= Const.EPSILON && Math.abs(y - p.y) <= Const.EPSILON;

	public function interpolate(p : Point, f : Float)
		return addPoint(p.subtractPoint(inst).multiply(f));

	inline public function isZero()
		return equals(zero);

	inline public function isNearZero()
		return nearEquals(zero);

	inline public function dot(p : Point) : Float
		return x * p.x + y * p.y;

	inline public function normal()
		return new Point(y, -x);

	inline public function normalize()
		return divide(length);

	public function distanceTo(p : Point)
		return subtractPoint(p).length;

	public function distanceToSquared(p : Point)
		return subtractPoint(p).lengthSquared;

	inline public function transform(matrix : Matrix4x4)
		return matrix.leftMultiplyPoint(inst);

	inline public function cross(p : Point)
		return x * p.y - y * p.x;

	inline public function min(p : Point) {
		return new Point(
			Math.min(x, p.x),
			Math.min(y, p.y)
		);
	}

	inline public function max(p : Point) {
		return new Point(
			Math.max(x, p.x),
			Math.max(y, p.y)
		);
	}

	@:to inline public function toAngle() : Angle
		return Math.atan2(y, x);

	@:to inline function toArray() : Array<Float>
		return this.copy();

	@:to inline function toObject() : { x : Float, y : Float }
		return { x : x, y : y };

	@:to inline public function toString()
		return 'Point($x,$y)';
}