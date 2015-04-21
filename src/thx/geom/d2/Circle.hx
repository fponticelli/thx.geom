package thx.geom.d2;

import thx.geom.core.*;
import thx.math.Const;

class Circle {
  public static function fromPoints(a : Point, b : Point) {
    var c = Point.linked(
          function() return (a.x + b.x) / 2,
          function() return (a.y + b.y) / 2,
          function(x) {
            var dx = x - (a.x + b.x) / 2;
            a.x += dx;
            return x;
          },
          function(y) {
            var dy = y - (a.y + b.y) / 2;
            a.y += dy;
            return y;
          }
        ),
        r = Radius.linked(
          function() return c.distanceTo(a),
          function(v) {
            var d = (b - c).asVector();
            d.length = v;
            b.set(c.x + d.x, c.y + d.y);
            a.set(c.x - d.x, c.y - d.y);
            return v;
          }
        );
    return new Circle(c, r);
  }

  public static inline function create(x : Float, y : Float, r : Radius)
    return new Circle(Point.create(x, y), r);

  public var center : Point;
  public var radius : Radius;
  public var x(get, set) : Float;
  public var y(get, set) : Float;
  public var left(get, set) : Float;
  public var right(get, set) : Float;
  public var top(get, set) : Float;
  public var bottom(get, set) : Float;
  public var area(get, set) : Float;
  public var circumference(get, set) : Float;
  public function new(center : Point, radius : Radius) {
    this.center = center;
    this.radius = radius;
  }

  inline function get_area()
    return this.radius.area;

  inline function set_area(v : Float)
    return this.radius.area = v;

  inline function get_circumference()
    return this.radius.circumference;

  inline function set_circumference(v : Float)
    return this.radius.circumference = v;

  inline function get_x()
    return this.center.x;

  inline function get_y()
    return this.center.y;

  inline function set_x(v : Float)
    return this.center.x = v;

  inline function set_y(v : Float)
    return this.center.y = v;

  inline function get_left()
    return x - (this.radius : Float);

  inline function get_right()
    return x + (this.radius : Float);

  inline function get_top()
    return y - (this.radius : Float);

  inline function get_bottom()
    return y + (this.radius : Float);

  inline function set_left(v : Float)
    return this.center.x = v + (this.radius : Float);

  inline function set_right(v : Float)
    return this.center.x = v - (this.radius : Float);

  inline function set_top(v : Float)
    return this.center.y = v - (this.radius : Float);

  inline function set_bottom(v : Float)
    return this.center.y = v + (this.radius : Float);

  inline public function equals(other : Circle)
    return this.center == other.center && this.radius == other.radius;

  inline public function toString()
    return 'Circle(${this.center.x},${this.center.y},${this.radius})';
}
