package thx.geom;

import thx.geom.d3.Point;
import thx.geom.Matrix4x4;

class Vertex3D {
  inline public function new(position : Point, normal : Point) {
    this.position = position;
    this.normal = normal;
  }

  @:isVar public var position(default, null) : Point;
  @:isVar public var normal(default, null) : Point;

  inline public function flip()
    return new Vertex3D(position, normal.negate());

  inline public function interpolate(other : Vertex3D, t : Float)
    return new Vertex3D(
      position.interpolate(other.position, t),
      normal.interpolate(other.normal, t)
    );

  inline public function transform(matrix : Matrix4x4)
    return new Vertex3D(position.transform(matrix), normal.transform(matrix));


  public function toString()
    return 'Vertex3D $position, $normal';
}