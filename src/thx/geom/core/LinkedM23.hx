package thx.geom.core;

class LinkedM23 implements M23 {
  public var a(get, set) : Float;
  public var b(get, set) : Float;
  public var c(get, set) : Float;
  public var d(get, set) : Float;
  public var e(get, set) : Float;
  public var f(get, set) : Float;

  var getA : Void -> Float;
  var getB : Void -> Float;
  var getC : Void -> Float;
  var getD : Void -> Float;
  var getE : Void -> Float;
  var getF : Void -> Float;
  var setA : Float -> Float;
  var setB : Float -> Float;
  var setC : Float -> Float;
  var setD : Float -> Float;
  var setE : Float -> Float;
  var setF : Float -> Float;

  public function new(getA : Void -> Float, setA : Float -> Float, getB : Void -> Float, setB : Float -> Float, getC : Void -> Float, setC : Float -> Float, getD : Void -> Float, setD : Void -> Void, getE : Void -> Float, setE : Float -> Float, getF : Void -> Float, setF : Float -> Float) {
    this.getA = getA;
    this.getB = getB;
    this.getC = getC;
    this.getD = getD;
    this.getE = getE;
    this.getF = getF;
    this.setA = setA;
    this.setB = setB;
    this.setC = setC;
    this.setD = setD;
    this.setE = setE;
    this.setF = setF;
  }

  function get_a() return getA();
  function get_b() return getB();
  function get_c() return getC();
  function get_d() return getD();
  function get_e() return getE();
  function get_f() return getF();
  function set_a(v : Float) return setA(v);
  function set_b(v : Float) return setB(v);
  function set_c(v : Float) return setC(v);
  function set_d(v : Float) return setD(v);
  function set_e(v : Float) return setE(v);
  function set_f(v : Float) return setF(v);
}
