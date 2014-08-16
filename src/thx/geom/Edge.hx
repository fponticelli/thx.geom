package thx.geom;

class Edge {
	public var vertex0(default, null) : Vertex;
	public var vertex1(default, null) : Vertex;
	@:isVar public var length(get, null) : Float;
	@:isVar public var lengthSquared(get, null) : Float;
	public function new(vertex0 : Vertex, vertex1 : Vertex) {
		this.vertex0 = vertex0;
		this.vertex1 = vertex1;
	}

	public function intersects(other : Edge) {
		if(vertex0.equals(other.vertex1) || vertex1.equals(other.vertex0)) {
			if(other.vertex1.position
				.subtractPoint(other.vertex0.position).normalize()
				.addPoint(vertex1.position.subtractPoint(vertex0.position).normalize())
				.length < Const.EPSILON)
				return true;
		} else {
			var d0 = vertex1.position.subtractPoint(vertex0.position),
				d1 = other.vertex1.position.subtractPoint(other.vertex0.position);
			if(Math.abs(d0.cross(d1)) < 1e-9)
				return false; // lines are parallel
			var alphas = Point.solve2Linear(-d0.x, d1.x, -d0.y, d1.y, vertex0.position.x - other.vertex0.position.x, vertex0.position.y - other.vertex0.position.y);
			if((alphas[0] > 1e-6) &&
				(alphas[0] < 0.999999) &&
				(alphas[1] > 1e-5) &&
				(alphas[1] < 0.999999))
				return true;
		}
		return false;
	}

	public function isLinear() {
		return vertex0.normal.isNearZero() && vertex1.normal.isNearZero();
	}

/*
	// TODO add normals to Point and apply them here
	public function toPolygon(z0 : Float, z1 : Float)
		return new Polygon([
			new Point3D(vertex0.position.toVector3D(z0),
			new Point3D(vertex1.position.toVector3D(z0),
			new Point3D(vertex1.position.toVector3D(z1),
			new Point3D(vertex0.position.toVector3D(z1)
		]);
*/

	public function transform(matrix : Matrix4x4)
		return new Edge(
			vertex0.transform(matrix),
			vertex1.transform(matrix)
		);

	inline public function flip()
		return new Edge(vertex1, vertex0);

	inline public function direction()
		return vertex1.position.subtractPoint(vertex0.position);

	public function get_lengthSquared() {
		if(null == lengthSquared) {
			var w = vertex1.position.x - vertex0.position.x,
				h = vertex1.position.y - vertex0.position.y;
			lengthSquared = w * w + h * h;
		}
		return lengthSquared;
	}

	inline private function get_length() {
		// TODO is the caching worth it?
		if(null == length)
			length = Math.sqrt(lengthSquared);
		return length;
	}

	public function toString()
		return 'Edge (${vertex0.toString()} -> ${vertex1.toString()})';
}