package thx.geom.d2;

using thx.Arrays;

class Path {
  var segments : Array<ISegment>;
  public function new() {
    segments = [];
  }

  public function toString()
    return 'Path(segments=${segments.length})';
}
