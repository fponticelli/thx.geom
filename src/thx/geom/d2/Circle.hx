package thx.geom.d2;

import thx.geom.d2.xy.*;
import thx.math.Const;

@:forward(position, radius)
abstract Circle({ position : Point, radius : Float }) {
  public var x(get, set) : Float;
  public var y(get, set) : Float;
  public var left(get, set) : Float;
  public var right(get, set) : Float;
  public var top(get, set) : Float;
  public var bottom(get, set) : Float;
  public var area(get, never) : Float;
  public var perimeter(get, never) : Float;
  public function new(position : Point, radius : Float)
    this = { position : position, radius : radius };

  inline function get_area()
    return this.radius * this.radius * Const.PI;

  inline function get_perimeter()
    return this.radius * Const.TWO_PI;

  inline function get_x()
    return this.position.x;

  inline function get_y()
    return this.position.y;

  inline function set_x(v : Float)
    return this.position.x = v;

  inline function set_y(v : Float)
    return this.position.y = v;

  inline function get_left()
    return x - this.radius;

  inline function get_right()
    return x + this.radius;

  inline function get_top()
    return y - this.radius;

  inline function get_bottom()
    return y + this.radius;

  inline function set_left(v : Float)
    return this.position.x = v + this.radius;

  inline function set_right(v : Float)
    return this.position.x = v - this.radius;

  inline function set_top(v : Float)
    return this.position.y = v - this.radius;

  inline function set_bottom(v : Float)
    return this.position.y = v + this.radius;

  @:to inline public function toString()
    return 'Circle(${this.position.x},${this.position.y},${this.radius})';
}
