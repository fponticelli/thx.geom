import utest.Runner;
import utest.ui.Report;
import utest.Assert;

class TestAll {
  public static function main() {
    var runner = new Runner();
    runner.addCase(new TestAll());

    runner.addCase(new thx.geom.d2.TestCircle());
    runner.addCase(new thx.geom.d2.TestLineSegment());
    runner.addCase(new thx.geom.d2.TestPath());
    runner.addCase(new thx.geom.d2.TestPoint());
    runner.addCase(new thx.geom.d2.TestPolyline());
    runner.addCase(new thx.geom.d2.TestRadius());
    runner.addCase(new thx.geom.d2.TestRect());
    runner.addCase(new thx.geom.d2.TestSize());
    runner.addCase(new thx.geom.d2.TestVector());

    Report.create(runner);
    runner.run();
  }

  public function new() {}
}
