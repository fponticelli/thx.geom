package thx.geom.d2;

using thx.Arrays;

class Path {
  var segments : Array<Segment>;
  public function new() {
    segments = [];
  }

  public function toSVGPath() {
    var buf = [];

    return buf.join("");
  }

  public function toString()
    return 'Path(segments=${segments.length})';
}
