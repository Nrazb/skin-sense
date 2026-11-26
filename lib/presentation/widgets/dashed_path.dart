import 'dart:math' as math;
import 'dart:ui';

Path dashPath(Path source, {double dash = 5, double gap = 5}) {
  final out = Path();
  for (final metric in source.computeMetrics()) {
    var distance = 0.0;
    while (distance < metric.length) {
      out.addPath(
        metric.extractPath(distance, math.min(distance + dash, metric.length)),
        Offset.zero,
      );
      distance += dash + gap;
    }
  }
  return out;
}

/// Sudut bingkai bidik dengan ujung membulat.
Path cornerBracket(Offset corner, int dx, int dy, {double len = 30, double r = 12}) {
  return Path()
    ..moveTo(corner.dx + dx * len, corner.dy)
    ..lineTo(corner.dx + dx * r, corner.dy)
    ..quadraticBezierTo(corner.dx, corner.dy, corner.dx, corner.dy + dy * r)
    ..lineTo(corner.dx, corner.dy + dy * len);
}
