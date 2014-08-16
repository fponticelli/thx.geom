import utest.Runner;
import utest.ui.Report;
import utest.Assert;

class TestAll {
	public static function main() {
		var runner = new Runner();
		runner.addCase(new TestAll());
		runner.addCase(new thx.geom.TestEdge());
		runner.addCase(new thx.geom.TestLine());
		runner.addCase(new thx.geom.TestPoint());
		runner.addCase(new thx.geom.TestPoint3D());
		runner.addCase(new thx.geom.TestSpline());
		Report.create(runner);
		runner.run();
	}

	public function new() {}
}