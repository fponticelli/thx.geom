package thx.geom.d3;

import thx.geom.d3.Point;
import thx.geom.Matrix44;

class Vertex {
  inline public function new(position : Point, normal : Point) {
    this.position = position;
    this.normal = normal;
  }

  @:isVar public var position(default, null) : Point;
  @:isVar public var normal(default, null) : Point;

  inline public function flip()
    return new Vertex(position, normal.negate());

  inline public function interpolate(other : Vertex, t : Float)
    return new Vertex(
      position.interpolate(other.position, t),
      normal.interpolate(other.normal, t)
    );

  inline public function transform(matrix : Matrix44)
    return new Vertex(position.transform(matrix), normal.transform(matrix));


  public function toString()
    return 'Vertex $position, $normal';
}