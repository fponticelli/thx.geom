import thx.benchmark.speed.SpeedSuite;
import thx.benchmark.speed.SpeedTest;

class PointSpeed {
  public static function main() {
    var suite = new SpeedSuite();
    suite.addTest("create", testNew(),   2000000);
    suite.addTest("read",   testRead(),  2000000);
    suite.addTest("write",  testWrite(), 2000000);
    suite.addTest("mixed",  testMixed(), 2000000);
    suite.addTest("new and update", testConstructAndUpdate(), 2000000);
    suite.run();
  }

  static function testMixed() {
    var test = new SpeedTest(),
        x = 10.0,
        y = 1.0,
        p1 = new PointArray(x, y),
        p2 = new PointArrayInline(x, y),
        p3 = new PointObject(x, y),
        p4 = new PointObjectInline(x, y),
        p5 = new PointDirect(x, y),
        p6 = new PointAccessor(x, y),
        p7 = new PointInlineAccessor(x, y),
        p8 = new PointAbstractAccessor(x, y),
        p9 = new PointInlineAbstractAccessor(x, y);

    test.add("array abstract", function() {
      p1.x = p1.y * x;
      p1.y = p1.x / y;
    });
    test.add("array abstract inline", function() {
      p2.x = p2.y * x;
      p2.y = p2.x / y;
    }, true);
    test.add("object abstract", function() {
      p3.x = p3.y * x;
      p3.y = p3.x / y;
    });
    test.add("object abstract inline", function() {
      p4.x = p4.y * x;
      p4.y = p4.x / y;
    });
    test.add("instance direct", function() {
      p5.x = p5.y * x;
      p5.y = p5.x / y;
    });
    test.add("instance accessor", function() {
      p6.x = p6.y * x;
      p6.y = p6.x / y;
    });
    test.add("instance accessor inline", function() {
      p7.x = p7.y * x;
      p7.y = p7.x / y;
    });
    test.add("instance abstract accessor", function() {
      p8.x = p8.y * x;
      p8.y = p8.x / y;
    });
    test.add("instance abstract accessor inline", function() {
      p9.x = p9.y * x;
      p9.y = p9.x / y;
    });

    return test;
  }

  static function testWrite() {
    var test = new SpeedTest(),
        x = 10.0,
        y = 1.0,
        p1 = new PointArray(x, y),
        p2 = new PointArrayInline(x, y),
        p3 = new PointObject(x, y),
        p4 = new PointObjectInline(x, y),
        p5 = new PointDirect(x, y),
        p6 = new PointAccessor(x, y),
        p7 = new PointInlineAccessor(x, y),
        p8 = new PointAbstractAccessor(x, y),
        p9 = new PointInlineAbstractAccessor(x, y);

    x = 20.0;
    y = 10.0;

    test.add("array abstract", function() {
      p1.x = x;
      p1.y = y;
    });
    test.add("array abstract inline", function() {
      p2.x = x;
      p2.y = y;
    }, true);
    test.add("object abstract", function() {
      p3.x = x;
      p3.y = y;
    });
    test.add("object abstract inline", function() {
      p4.x = x;
      p4.y = y;
    });
    test.add("instance direct", function() {
      p5.x = x;
      p5.y = y;
    });
    test.add("instance accessor", function() {
      p6.x = x;
      p6.y = y;
    });
    test.add("instance accessor inline", function() {
      p7.x = x;
      p7.y = y;
    });
    test.add("instance abstract accessor", function() {
      p8.x = x;
      p8.y = y;
    });
    test.add("instance abstract accessor inline", function() {
      p9.x = x;
      p9.y = y;
    });

    return test;
  }

  static function testRead() {
    var test = new SpeedTest(),
        x = 10.0,
        y = 1.0,
        p1 = new PointArray(x, y),
        p2 = new PointArrayInline(x, y),
        p3 = new PointObject(x, y),
        p4 = new PointObjectInline(x, y),
        p5 = new PointDirect(x, y),
        p6 = new PointAccessor(x, y),
        p7 = new PointInlineAccessor(x, y),
        p8 = new PointAbstractAccessor(x, y),
        p9 = new PointInlineAbstractAccessor(x, y);

    test.add("array abstract", function() {
      x = p1.x;
      y = p1.y;
    });
    test.add("array abstract inline", function() {
      x = p2.x;
      y = p2.y;
    }, true);
    test.add("object abstract", function() {
      x = p3.x;
      y = p3.y;
    });
    test.add("object abstract inline", function() {
      x = p4.x;
      y = p4.y;
    });
    test.add("instance direct", function() {
      x = p5.x;
      y = p5.y;
    });
    test.add("instance accessor", function() {
      x = p6.x;
      y = p6.y;
    });
    test.add("instance accessor inline", function() {
      x = p7.x;
      y = p7.y;
    });
    test.add("instance abstract accessor", function() {
      x = p8.x;
      y = p8.y;
    });
    test.add("instance abstract accessor inline", function() {
      x = p9.x;
      y = p9.y;
    });

    return test;
  }

  static function testNew() {
    var test = new SpeedTest(),
        x = 10.0,
        y = 1.0,
        p1, p2, p3, p4, p5, p6, p7, p8, p9;

    test.add("array abstract", function() {
      p1 = new PointArray(x, y);
    });
    test.add("array abstract inline", function() {
      p2 = new PointArrayInline(x, y);
    }, true);
    test.add("object abstract", function() {
      p3 = new PointObject(x, y);
    });
    test.add("object abstract inline", function() {
      p4 = new PointObjectInline(x, y);
    });
    test.add("instance direct", function() {
      p5 = new PointDirect(x, y);
    });
    test.add("instance accessor", function() {
      p6 = new PointAccessor(x, y);
    });
    test.add("instance accessor inline", function() {
      p7 = new PointInlineAccessor(x, y);
    });
    test.add("instance abstract accessor", function() {
      p8 = new PointAbstractAccessor(x, y);
    });
    test.add("instance abstract accessor inline", function() {
      p9 = new PointInlineAbstractAccessor(x, y);
    });

    return test;
  }

  static function testConstructAndUpdate() {
    var test = new SpeedTest(),
        x = 10.0,
        y = 1.0,
        p1, p2, p3, p4, p5, p6, p7, p8, p9;

    test.add("array abstract", function() {
      p1 = new PointArray(x, y);
      p1.x = p1.y = p1.x * p1.y;
    });
    test.add("array abstract inline", function() {
      p2 = new PointArrayInline(x, y);
      p2.x = p2.y = p2.x * p2.y;
    }, true);
    test.add("object abstract", function() {
      p3 = new PointObject(x, y);
      p3.x = p3.y = p3.x * p3.y;
    });
    test.add("object abstract inline", function() {
      p4 = new PointObjectInline(x, y);
      p4.x = p4.y = p4.x * p4.y;
    });
    test.add("instance direct", function() {
      p5 = new PointDirect(x, y);
      p5.x = p5.y = p5.x * p5.y;
    });
    test.add("instance accessor", function() {
      p6 = new PointAccessor(x, y);
      p6.x = p6.y = p6.x * p6.y;
    });
    test.add("instance accessor inline", function() {
      p7 = new PointInlineAccessor(x, y);
      p7.x = p7.y = p7.x * p7.y;
    });
    test.add("instance abstract accessor", function() {
      p8 = new PointAbstractAccessor(x, y);
      p8.x = p8.y = p8.x * p8.y;
    });
    test.add("instance abstract accessor inline", function() {
      p9 = new PointInlineAbstractAccessor(x, y);
      p9.x = p9.y = p9.x * p9.y;
    });

    return test;
  }
}

class PointDirect {
  public var x : Float;
  public var y : Float;
  public function new(x : Float, y : Float) {
    this.x = x;
    this.y = y;
  }
}

class PointAccessor implements IPoint {
  public var x(get, set) : Float;
  public var y(get, set) : Float;
  var _x : Float;
  var _y : Float;
  public function new(x : Float, y : Float) {
    _x = x;
    _y = y;
  }

  function get_x() return _x;
  function get_y() return _y;
  function set_x(v) return _x = v;
  function set_y(v) return _y = v;
}

interface IPoint {
  public var x(get, set) : Float;
  public var y(get, set) : Float;
}

abstract PointAbstractAccessor(IPoint) {
  public var x(get, set) : Float;
  public var y(get, set) : Float;
  inline public function new(x : Float, y : Float)
    this = new PointAccessor(x, y);

  inline function get_x() return this.x;
  inline function get_y() return this.y;
  inline function set_x(v) return this.x = v;
  inline function set_y(v) return this.y = v;
}

class PointInlineAccessor implements IPoint {
  public var x(get, set) : Float;
  public var y(get, set) : Float;
  var _x : Float;
  var _y : Float;
  public function new(x : Float, y : Float) {
    _x = x;
    _y = y;
  }

  inline function get_x() return _x;
  inline function get_y() return _y;
  inline function set_x(v) return _x = v;
  inline function set_y(v) return _y = v;
}

abstract PointInlineAbstractAccessor(IPoint) {
  public var x(get, set) : Float;
  public var y(get, set) : Float;
  inline public function new(x : Float, y : Float)
    this = new PointInlineAccessor(x, y);

  inline function get_x() return this.x;
  inline function get_y() return this.y;
  inline function set_x(v) return this.x = v;
  inline function set_y(v) return this.y = v;
}

abstract PointArray(Array<Float>) {
  public function new(x : Float, y : Float) {
    this = [x, y];
  }

  public var x(get, set) : Float;
  public var y(get, set) : Float;

  function get_x() return this[0];
  function get_y() return this[1];

  function set_x(v) return this[0] = v;
  function set_y(v) return this[1] = v;
}

abstract PointArrayInline(Array<Float>) {
  inline public function new(x : Float, y : Float) {
    this = [x, y];
  }

  public var x(get, set) : Float;
  public var y(get, set) : Float;

  inline function get_x() return this[0];
  inline function get_y() return this[1];

  inline function set_x(v) return this[0] = v;
  inline function set_y(v) return this[1] = v;
}

abstract PointObject({ x : Float, y : Float }) {
  public function new(x : Float, y : Float) {
    this = { x : x, y : y };
  }

  public var x(get, set) : Float;
  public var y(get, set) : Float;

  function get_x() return this.x;
  function get_y() return this.y;

  function set_x(v) return this.x = v;
  function set_y(v) return this.y = v;
}

abstract PointObjectInline({ x : Float, y : Float }) {
  inline public function new(x : Float, y : Float) {
    this = { x : x, y : y };
  }

  public var x(get, set) : Float;
  public var y(get, set) : Float;

  inline function get_x() return this.x;
  inline function get_y() return this.y;

  inline function set_x(v) return this.x = v;
  inline function set_y(v) return this.y = v;
}