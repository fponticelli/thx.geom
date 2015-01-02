package thx.geom;

interface ITransformable44<T> extends ICloneable<T> {
  public function apply44(matrix : Matrix44) : Void;
}