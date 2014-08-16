package thx.geom;

class Path {
	var splines : Array<Spline>;
	public function new(splines : Arrat<Spline>)
		this.splines = splines;

	public function contains(p : Point) {
		throw 'not implemented';
	}
}