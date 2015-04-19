package thx.geom.m;

class MutableM23 implements M23 {
  public var a(get, set) : Float;
  public var b(get, set) : Float;
  public var c(get, set) : Float;
  public var d(get, set) : Float;
  public var e(get, set) : Float;
  public var f(get, set) : Float;

  var _a : Float;
  var _b : Float;
  var _c : Float;
  var _d : Float;
  var _e : Float;
  var _f : Float;

  public function new(a : Float, b : Float, c : Float, d : Float, e : Float, f : Float) {
    _a = a;
    _b = b;
    _c = c;
    _d = d;
    _e = e;
    _f = f;
  }

  function get_a() return _a;
  function get_b() return _b;
  function get_c() return _c;
  function get_d() return _d;
  function get_e() return _e;
  function get_f() return _f;
  function set_a(v : Float) return _a = v;
  function set_b(v : Float) return _b = v;
  function set_c(v : Float) return _c = v;
  function set_d(v : Float) return _d = v;
  function set_e(v : Float) return _e = v;
  function set_f(v : Float) return _f = v;
}
