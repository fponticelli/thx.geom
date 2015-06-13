package thx.geom.d2;

import thx.geom.core.*;
using thx.Iterables;
using thx.Functions;

class Rect implements IShape {
  public static inline function create(x : Float, y : Float, width : Float, height : Float)
    return new Rect(Point.create(x, y), Size.create(width, height));

  public static function fromPoints(points : Iterable<Point>) {
    var min = Point.linkedMin(points),
        max = Point.linkedMax(points),
        v   = Vector.linkedPoints(min, max);
    return new Rect(min, v.asSize());
  }

  public static function fromRects(rects : Iterable<Rect>) {
    var min = Point.linkedMin(rects.map.fn(_.minLeft)),
        max = Point.linkedMax(rects.map.fn(_.maxRight));
    return fromPoints([min, max]);
  }

  public var position : Point;
  public var size : Size;
  public var x(get, set) : Float;
  public var y(get, set) : Float;
  public var width(get, set) : Float;
  public var height(get, set) : Float;
  public var left(get, set) : Float;
  public var right(get, set) : Float;
  public var max(get, set) : Float;
  public var min(get, set) : Float;
  public var area(get, never) : Float;
  public var perimeter(get, never) : Float;
  public var box(default, null) : Rect;
  @:isVar public var center(get, null) : Point;
  @:isVar public var centerLeft(get, null) : Point;
  @:isVar public var centerRight(get, null) : Point;
  @:isVar public var centerMax(get, null) : Point;
  @:isVar public var centerMin(get, null) : Point;
  @:isVar public var maxLeft(get, null) : Point;
  @:isVar public var maxRight(get, null) : Point;
  @:isVar public var minLeft(get, null) : Point;
  @:isVar public var minRight(get, null) : Point;
  @:isVar public var corners(get, null) : Iterable<Point>;

  public function new(position : Point, size : Size) {
    this.position = position;
    this.size = size;
    this.box = this;
  }

  function get_center() : Point {
    if(null == center) {
      center = Point.linked(
        function() return x + width / 2,
        function() return y + height / 2,
        function(v) return x = v - width / 2,
        function(v) return y = v - height / 2
      );
    }
    return center;
  }

  function get_centerLeft() : Point {
    if(null == centerLeft) {
      centerLeft = Point.linked(
        function() return left,
        function() return y + height / 2,
        function(v) return left = v,
        function(v) return y = v - height / 2
      );
    }
    return centerLeft;
  }

  function get_centerRight() : Point {
    if(null == centerRight) {
      centerRight = Point.linked(
        function() return right,
        function() return y + height / 2,
        function(v) return right = v,
        function(v) return y = v - height / 2
      );
    }
    return centerRight;
  }

  function get_centerMax() : Point {
    if(null == centerMax) {
      centerMax = Point.linked(
        function() return x + width / 2,
        function() return max,
        function(v) return x = v - width / 2,
        function(v) return max = v
      );
    }
    return centerMax;
  }

  function get_centerMin() : Point {
    if(null == centerMin) {
      centerMin = Point.linked(
        function() return x + width / 2,
        function() return min,
        function(v) return x = v - width / 2,
        function(v) return min = v
      );
    }
    return centerMin;
  }

  function get_maxLeft() : Point {
    if(null == maxLeft) {
      maxLeft = Point.linked(
        function() return left,
        function() return max,
        function(v) return left = v,
        function(v) return max = v
      );
    }
    return maxLeft;
  }

  function get_maxRight() : Point {
    if(null == maxRight) {
      maxRight = Point.linked(
        function() return right,
        function() return max,
        function(v) return right = v,
        function(v) return max = v
      );
    }
    return maxRight;
  }

  function get_minLeft() : Point {
    if(null == minLeft) {
      minLeft = Point.linked(
        function() return left,
        function() return min,
        function(v) return left = v,
        function(v) return min = v
      );

    }
    return minLeft;
  }

  function get_minRight() : Point {
    if(null == minRight) {
      minRight = Point.linked(
        function() return right,
        function() return min,
        function(v) return right = v,
        function(v) return min = v
      );
    }
    return minRight;
  }

  inline function get_area()
    return this.size.area;

  inline function get_perimeter()
    return this.size.perimeter;

  function get_left()
    return x + (width < 0 ? width : 0);

  function get_right()
    return x + (width > 0 ? width : 0);

  function get_max()
    return y + (height > 0 ? height : 0);

  function get_min()
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

  function set_max(v : Float) {
    var b = min;
    y = b;
    height = v - b;
    return v;
  }

  function set_min(v : Float) {
    var t = max;
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

  function get_corners() {
    if(null == corners) {
      corners = [minLeft, maxLeft, maxRight, minRight];
    }
    return corners;
  }

  public function equals(other : Rect)
    return
      left   == other.left   &&
      right  == other.right  &&
      max    == other.max    &&
      min    == other.min;

  inline public function toString()
    return 'Rect(${x},${y},${width},${height})';
}
