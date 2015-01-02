import utest.Runner;
import utest.ui.Report;
import utest.Assert;

import thx.geom.bool.Polygon;

class TestAll {
  public static function main() {
    var runner = new Runner();
    runner.addCase(new TestAll());

    runner.addCase(new thx.geom.TestMatrix());
    runner.addCase(new thx.geom.d2.TestLine());
    runner.addCase(new thx.geom.d2.TestPoint());
    runner.addCase(new thx.geom.d2.TestEdgeLinear());
    runner.addCase(new thx.geom.d2.TestEdgeCubic());
    runner.addCase(new thx.geom.d2.TestPath());
    runner.addCase(new thx.geom.d2.TestSpline());

    runner.addCase(new thx.geom.d3.TestPoint());

    Report.create(runner);
    runner.run();
  }

  public function new() {}
}