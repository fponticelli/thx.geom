package thx.geom.angle;

import thx.geom.Const.*;

abstract Radian(Float) {
	@:from public static inline function fromFloat(angle : Float)
		return new Radian(angle);

	inline public function new(radians : Float)
		this = radians;

	inline public function cos()
		return Math.cos(this);

	inline public function sin()
		return Math.sin(this);

	@:to inline public function toString()
		return this + 'rad';

	@:to inline public function toDegree() : Degree
		return new Degree(this * TO_DEGREE);
}