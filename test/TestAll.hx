import utest.Runner;
import utest.ui.Report;
import utest.Assert;

import thx.geom.bool.Polygon;

class TestAll {
	public static function main() {
		var runner = new Runner();
		runner.addCase(new TestAll());
		runner.addCase(new thx.geom.TestEdgeLinear());
		runner.addCase(new thx.geom.TestEdgeCubic());
		runner.addCase(new thx.geom.TestLine());
		runner.addCase(new thx.geom.TestPath());
		runner.addCase(new thx.geom.TestPoint());
		runner.addCase(new thx.geom.TestPoint3D());
		runner.addCase(new thx.geom.TestSpline());
		Report.create(runner);
		runner.run();
	}

	public function new() {}
}