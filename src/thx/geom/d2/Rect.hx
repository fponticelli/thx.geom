package thx.geom.d2;

import thx.geom.d2.xy.*;

class Rect {
  public static inline function create(x : Float, y : Float, width : Float, height : Float)
    return new Rect(Point.create(x, y), Size.create(width, height));

  public var position : Point;
  public var size : Size;
  public var x(get, set) : Float;
  public var y(get, set) : Float;
  public var width(get, set) : Float;
  public var height(get, set) : Float;
  public var left(get, set) : Float;
  public var right(get, set) : Float;
  public var top(get, set) : Float;
  public var bottom(get, set) : Float;
  public var area(get, never) : Float;
  public var perimeter(get, never) : Float;

  public function new(position : Point, size : Size) {
    this.position = position;
    this.size = size;
  }

  public function center() : Point
    return Point.linked(
      function() return x + width / 2,
      function() return y + height / 2,
      function(v) return x = v - width / 2,
      function(v) return y = v - height / 2
    );

  public function centerLeft() : Point
    return Point.linked(
      function() return left,
      function() return y + height / 2,
      function(v) return left = v,
      function(v) return y = v - height / 2
    );

  public function centerRight() : Point
    return Point.linked(
      function() return right,
      function() return y + height / 2,
      function(v) return right = v,
      function(v) return y = v - height / 2
    );

  public function centerTop() : Point
    return Point.linked(
      function() return x + width / 2,
      function() return top,
      function(v) return x = v - width / 2,
      function(v) return top = v
    );

  public function centerBottom() : Point
    return Point.linked(
      function() return x + width / 2,
      function() return bottom,
      function(v) return x = v - width / 2,
      function(v) return bottom = v
    );

  public function topLeft() : Point
    return Point.linked(
      function() return left,
      function() return top,
      function(v) return left = v,
      function(v) return top = v
    );

  public function topRight() : Point
    return Point.linked(
      function() return right,
      function() return top,
      function(v) return right = v,
      function(v) return top = v
    );

  public function bottomLeft() : Point
    return Point.linked(
      function() return left,
      function() return bottom,
      function(v) return left = v,
      function(v) return bottom = v
    );

  public function bottomRight() : Point
    return Point.linked(
      function() return right,
      function() return bottom,
      function(v) return right = v,
      function(v) return bottom = v
    );

  inline function get_area()
    return this.size.area;

  inline function get_perimeter()
    return this.size.perimeter;

  function get_left()
    return x + (width < 0 ? width : 0);

  function get_right()
    return x + (width > 0 ? width : 0);

  function get_top()
    return y + (height > 0 ? height : 0);

  function get_bottom()
    return y + (height < 0 ? height : 0);

  function set_left(v : Float) {
    var r = right;
    x = v;
    width = r - v;
    return v;
  }

  function set_right(v : Float) {
    var l = left;
    x = l;
    width = v - l;
    return v;
  }

  function set_top(v : Float) {
    var b = bottom;
    y = b;
    height = v - b;
    return v;
  }

  function set_bottom(v : Float) {
    var t = top;
    y = v;
    height = t - v;
    return v;
  }

  inline function get_width()
    return this.size.width;

  inline function set_width(v : Float)
    return this.size.width = v;

  inline function get_height()
    return this.size.height;

  inline function set_height(v : Float)
    return this.size.height = v;

  inline function get_x()
    return this.position.x;

  inline function set_x(v : Float)
    return this.position.x = v;

  inline function get_y()
    return this.position.y;

  inline function set_y(v : Float)
    return this.position.y = v;

  public function equals(other : Rect)
    return
      left   == other.left   &&
      right  == other.right  &&
      top    == other.top    &&
      bottom == other.bottom;

  inline public function toString()
    return 'Rect(${x},${y},${width},${height})';
}
