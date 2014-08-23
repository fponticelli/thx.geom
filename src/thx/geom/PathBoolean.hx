package thx.geom;

class PathBoolean {
	var path1 : Path;
	var path2 : Path;
	public function new(path1 : Path, path2 : Path) {
		this.path1 = path1.reduce().asClockwise();
		this.path2 = path2.reduce().asClockwise();
	}

	public function unite()
		return compute(function(w) return w == 1 || w == 0, false);

	public function intersect()
		return compute(function(w) return w == 2, false);

	public function subtract()
		return compute(function(w) return w == 1, true);

/*
	public function exclude()
		//return new Group([this.subtract(path), path.subtract(this)]);

	public function divide()
		//return new Group([this.subtract(path), path.intersect(this)]);
*/

	function compute(operator : Int -> Bool, subtract : Bool) {
		var intersections = path1.intersections(path2);

	}

	function splitPath(intersections : Array<Point>) {
		
	}
}