package thx.geom;

import thx.geom.d2.Point;

using thx.core.Arrays;
using thx.core.Floats;
import thx.geom.m.*;

abstract Matrix23(M23) from M23 to M23 {
  public static function create(a : Float, b : Float, c : Float, d : Float, e : Float, f : Float) : Matrix23
    return new MutM23(a, b, c, d, e, f);

  public var a(get, set) : Float;
  public var b(get, set) : Float;
  public var c(get, set) : Float;
  public var d(get, set) : Float;
  public var e(get, set) : Float;
  public var f(get, set) : Float;

  inline public function new(m : M23)
    this = m;

  public function flipX() : Matrix23
    return mul(-1, 0, 0, 1, 0, 0);

  public function flipY() : Matrix23
    return mul(1, 0, 0, -1, 0, 0);

  @:op(A*B) public function multiply(other : Matrix23) : Matrix23
    return create(other.a, other.b, other.c, other.d, other.e, other.f);

  private function mul(a : Float, b : Float, c : Float, d : Float, e : Float, f : Float) : Matrix23
    return create(
      this.a * a + this.c * b,
      this.b * a + this.d * b,
      this.a * c + this.c * d,
      this.b * c + this.d * d,
      this.a * e + this.c * f + this.e,
      this.b * e + this.d * f + this.f
    );

  public function inverse() : Matrix23
    return null;

  public function rotate(angle : Float) : Matrix23 {
    var c = angle.cos(),
        s = angle.sin();
    return mul(c, s, -s, -c, 0, 0);
  }

  public function rotateFromVector(x : Float, y : Float) : Matrix23
    return rotate(y.atan2(x));

  public function rotateFromPoint(point : Point) : Matrix23
    return rotateFromVector(point.x, point.y);

  public function translate(x : Float, y : Float) : Matrix23
    return mul(1, 0, 0, 1, x, y);

  public function scale(scaleFactor : Float) : Matrix23
    return mul(scaleFactor, 0, 0, scaleFactor, 0, 0);

  public function scaleNonUniform(scaleFactorX : Float, scaleFactorY : Float) : Matrix23
    return mul(scaleFactorX, 0, 0, scaleFactorY, 0, 0);

  public function skewX(angle : Float) : Matrix23
    return mul(1, 0, angle.tan(), 1, 0, 0);

  public function skewY(angle : Float) : Matrix23
    return mul(1, angle.tan(), 0, 1, 0, 0);

  public function toString()
    return 'matrix($a,$b,$c,$d,$e,$f)';

  function get_a() return this.a;
  function get_b() return this.b;
  function get_c() return this.c;
  function get_d() return this.d;
  function get_e() return this.e;
  function get_f() return this.f;
  function set_a(v : Float) return this.a = v;
  function set_b(v : Float) return this.b = v;
  function set_c(v : Float) return this.c = v;
  function set_d(v : Float) return this.d = v;
  function set_e(v : Float) return this.e = v;
  function set_f(v : Float) return this.f = v;
}