package thx.geom;

import thx.geom.d2.Point;

using thx.core.Arrays;
using thx.core.Floats;
import thx.geom.m.*;

abstract Matrix2x3(M2x3) from M2x3 to M2x3 {
  public static function create(a : Float, b : Float, c : Float, d : Float, e : Float, f : Float) : Matrix2x3
    return new MutM2x3(a, b, c, d, e, f);

  public var a(get, set) : Float;
  public var b(get, set) : Float;
  public var c(get, set) : Float;
  public var d(get, set) : Float;
  public var e(get, set) : Float;
  public var f(get, set) : Float;

  inline public function new(m : M2x3)
    this = m;

  inline public function flipX() : Matrix2x3 {
    return null;
  }
  inline public function flipY() : Matrix2x3 {
    return null;
  }
  inline public function multiply(other : Matrix2x3) : Matrix2x3 {
    return null;
  }
  inline public function inverse() : Matrix2x3 {
    return null;
  }
  inline public function rotate(angle : Float) : Matrix2x3 {
    return null;
  }
  inline public function rotateFromVector(x : Float, y : Float) : Matrix2x3 {
    return null;
  }
  inline public function rotateFromPoint(point : Point) : Matrix2x3 {
    return null;
  }
  inline public function translate(x : Float, y : Float) : Matrix2x3 {
    return null;
  }
  inline public function scale(scaleFactor : Float) : Matrix2x3 {
    return null;
  }
  inline public function scaleNonUniform(scaleFactorX : Float, scaleFactorY : Float) : Matrix2x3 {
    return null;
  }
  inline public function skewX(angle : Float) : Matrix2x3 {
    return null;
  }
  inline public function skewY(angle : Float) : Matrix2x3 {
  private function mul(a : Float, b : Float, c : Float, d : Float, e : Float, f : Float) : Matrix2x3
    return create(
      this.a * a + this.c * b,
      this.b * a + this.d * b,
      this.a * c + this.c * d,
      this.b * c + this.d * d,
      this.a * e + this.c * f + this.e,
      this.b * e + this.d * f + this.f
    );

    return null;
  }

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