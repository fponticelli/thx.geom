package thx.geom;

abstract Point(Array<Float>) {
	public static var zero(default, null) : Point = new Point(0, 0);

	@:from static inline function fromObject(o : { x : Float, y : Float })
		return new Point(o.x, o.y);

	@:from static inline function fromArray(arr : Array<Int>)
		return new Point(arr[0], arr[1]);

	@:from static inline public function fromAngle(angle : Float)
		return new Point(Math.cos(angle), Math.sin(angle));

	#if thx-unit
	@:from static inline public function fromRadians(rad : Radian)
		return new Point(rad.cos(), rad.sin());

	@:from static inline public function fromDegrees(deg : Degree)
		return new Point(deg.cos(), deg.sin());
	#end

	inline public function new(x : Float, y : Float)
		this = [x, y];

	public var x(get, never) : Float;
	public var y(get, never) : Float;
	public var length(get, never) : Float;
	public var lengthSquared(get, never) : Float;

	inline function get_x() return this[0];
	inline function get_y() return this[1];
	inline function get_length() return Math.sqrt(lengthSquared);
	inline function get_lengthSquared() return x * x + y * y;

	inline function interpolate(p : Point, f : Float)
		return add(subtract(p).divideNumber(f));

	inline function middle(p : Point)
		return interpolate(p, 0.5);

	inline public function isZero()
		return x == 0 && y == 0;

	public function isNearZero()
		return Const.EPSILON >= Math.abs(x) && Const.EPSILON >= Math.abs(y);

	inline public function toString()
		return 'Point($x,$y)';

	@:to inline function toArray() : Array<Float>
		return this.copy();

	@:to inline function toObject() : { x : Float, y : Float }
		return { x : x, y : y };

	@:op(A+B) inline function add(p : Point)
		return new Point(x + p.x, y + p.y);

	@:op(A+B) inline function addNumber(v : Float)
		return new Point(x + v, y + v);

	@:op(-A) inline function negate()
		return new Point(-x, -y);

	@:op(A-B) inline function subtract(p : Point)
		return add(p.negate());

	@:op(A-B) inline function subtractNumber(v : Float)
		return addNumber(-v);

	@:op(A*B) inline function multiply(p : Point)
		return new Point(x * p.x, y * p.y);

	@:commutative
	@:op(A*B) inline function multiplyNumber(v : Float)
		return new Point(x * v, y * v);

	@:op(A/B) inline function divide(p : Point)
		return new Point(x / p.x, y / p.y);

	@:op(A/B) inline function divideNumber(v : Float)
		return new Point(x / v, y / v);

	inline public function dot(p : Point) : Float
		return x * p.x + y * p.y;

	inline public function normal()
		return new Point(y, -x);

	inline public function normalize()
		return divide(length);

	inline public function equals(other : Point)
		return (x == other.x) && (y == other.y);

	inline public function distanceTo(other : Point)
		return subtract(other).length;

	inline public function distanceToSquared(other : Point)
		return subtract(other).lengthSquared;

//	inline public function transform(matrix : Matrix4x4)
//		return matrix.leftMultiplyPoint(this);

	#if thx-unit
	@:to inline public function toDegrees() : Degree
		return toRadians().toDegree();

	@:to inline public function toRadians() : Radian
		return new Radian(Math.atan2(y, x));
	#end

	@:to inline public function toAngle() : Float
		return Math.atan2(y, x);

	inline public function cross(other : Point)
		return x * other.y - y * other.x;

	inline public function min(other : Point) {
		return new Point(
			Math.min(x, other.x),
			Math.min(y, other.y)
		);
	}

	inline public function max(other : Point) {
		return new Point(
			Math.max(x, other.x),
			Math.max(y, other.y)
		);
	}
}