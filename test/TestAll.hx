import utest.Runner;
import utest.ui.Report;
import utest.Assert;

class TestAll {
  public static function main() {
    var runner = new Runner();
    runner.addCase(new TestAll());

    runner.addCase(new thx.geom.d2.TestPoint());
    runner.addCase(new thx.geom.d2.TestVector());

    Report.create(runner);
    runner.run();
  }

  public function new() {}
}
