package thx.geom.d2;

import thx.geom.d2.xy.*;
using thx.core.Arrays;
using thx.core.Floats;

abstract Size(XY) from XY to XY {
  @:from public static function fromFloats(arr : Array<Float>) {
    arr.resize(2, 0);
    return create(arr[0], arr[1]);
  }

  @:from static inline function fromObject(o : { width : Float, height : Float })
    return create(o.width, o.height);

  inline public static function create(width : Float, height : Float) : Size
    return new MutableXY(width, height);

  inline public static function linked(getWidth : Void -> Float, getHeight : Void -> Float, setWidth : Float -> Float, setHeight : Float -> Float) : Size
    return new LinkedXY(getWidth, getHeight, setWidth, setHeight);

  inline public static function immutable(width : Float, height : Float) : Size
    return new ImmutableXY(width, height);

  public var width(get, set) : Float;
  public var height(get, set) : Float;
  public var area(get, never) : Float;
  public var perimeter(get, never) : Float;

  inline public function new(xy : XY)
    this = xy;

  inline public function asPoint()
    return new Point(this);

  inline public function asSize()
    return new Size(this);

  @:op(A==B)
  inline public function equals(p : Size)
    return (width == p.width) && (height == p.height);

  @:op(A!=B)
  inline public function notEquals(p : Size)
    return !equals(p);

  inline public function copyTo(other : Size)
    return other.set(width, height);

  public function nearEquals(p : Size)
    return Math.abs(width - p.width) <= Floats.EPSILON && Math.abs(height - p.height) <= Floats.EPSILON;

  inline public function notNearEquals(p : Size)
    return !nearEquals(p);

  inline public function clone() : Size
    return this.clone();

  inline public function min(p : Size)
    return Size.create(
      Math.min(width, p.width),
      Math.min(height, p.height)
    );

  inline public function minWidth(p : Size)
    return Size.create(
      Math.min(width, p.width),
      height
    );

  inline public function minHeight(p : Size)
    return Size.create(
      width,
      Math.min(height, p.height)
    );

  inline public function max(p : Size)
    return Size.create(
      Math.max(width, p.width),
      Math.max(height, p.height)
    );

  inline public function maxWidth(p : Size)
    return Size.create(
      Math.max(width, p.width),
      height
    );

  inline public function maxHeight(p : Size)
    return Size.create(
      width,
      Math.max(height, p.height)
    );

  public function set(nwidth : Float, nheight : Float) : Size {
    width = nwidth;
    height = nheight;
    return this;
  }

  @:to inline function toArray() : Array<Float>
    return [width, height];

  @:to inline function toObject() : { width : Float, height : Float }
    return { width : width, height : height };

  @:to inline public function toString()
    return 'Size($width,$height)';

  public function transform(matrix : Matrix23) : Size {
    return create(
      matrix.a * width + matrix.c * height,
      matrix.b * width + matrix.d * height
    );
  }

  public function apply(matrix : Matrix23) : Size {
    return set(
      matrix.a * width + matrix.c * height,
      matrix.b * width + matrix.d * height
    );
  }

  inline function get_width() return this.x;
  inline function get_height() return this.y;
  inline function set_width(v : Float) return this.x = v;
  inline function set_height(v : Float) return this.y = v;
  inline function get_area() return Math.abs(width * height);
  inline function get_perimeter() return (Math.abs(width) + Math.abs(height)) * 2;
}
