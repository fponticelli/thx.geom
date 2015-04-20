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

  inline public static function create(width : Float, height : Float) : Vector
    return new MutableXY(width, height);

  inline public static function linked(getWidth : Void -> Float, getHeight : Void -> Float, setWidth : Float -> Float, setHeight : Float -> Float) : Vector
    return new LinkedXY(getWidth, getHeight, setWidth, setHeight);

  inline public static function immutable(width : Float, height : Float) : Vector
    return new ImmutableXY(width, height);

  public var width(get, set) : Float;
  public var height(get, set) : Float;

  inline public function new(xy : XY)
    this = xy;

  inline public function asPoint()
    return new Point(this);

  inline public function asVector()
    return new Vector(this);

  @:op(A==B)
  inline public function equals(p : Vector)
    return (width == p.width) && (height == p.height);

  @:op(A!=B)
  inline public function notEquals(p : Vector)
    return !equals(p);

  inline public function copyTo(other : Vector)
    return other.set(width, height);

  public function nearEquals(p : Vector)
    return Math.abs(width - p.width) <= Floats.EPSILON && Math.abs(height - p.height) <= Floats.EPSILON;

  inline public function notNearEquals(p : Vector)
    return !nearEquals(p);

  inline public function clone() : Vector
    return this.clone();

  inline public function min(p : Vector)
    return Vector.create(
      Math.min(width, p.width),
      Math.min(height, p.height)
    );

  inline public function minWidth(p : Vector)
    return Vector.create(
      Math.min(width, p.width),
      height
    );

  inline public function minHeight(p : Vector)
    return Vector.create(
      width,
      Math.min(height, p.height)
    );

  inline public function max(p : Vector)
    return Vector.create(
      Math.max(width, p.width),
      Math.max(height, p.height)
    );

  inline public function maxWidth(p : Vector)
    return Vector.create(
      Math.max(width, p.width),
      height
    );

  inline public function maxHeight(p : Vector)
    return Vector.create(
      width,
      Math.max(height, p.height)
    );

  public function set(nwidth : Float, nheight : Float) : Vector {
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

  public function transform(matrix : Matrix23) : Vector {
    return create(
      matrix.a * this.width + matrix.c * this.height,
      matrix.b * this.width + matrix.d * this.height
    );
  }

  public function apply(matrix : Matrix23) : Vector {
    return set(
      matrix.a * this.width + matrix.c * this.height,
      matrix.b * this.width + matrix.d * this.height
    );
  }

  inline function get_width() return this.width;
  inline function get_height() return this.height;
  inline function set_width(v : Float) return this.width = v;
  inline function set_height(v : Float) return this.height = v;
}
