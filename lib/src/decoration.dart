import 'dart:ui';

import 'package:flutter/material.dart';

import '../arrow_decoration.dart';

class ArrowDecoration extends Decoration {
  const ArrowDecoration({
    this.lineColor = Colors.white,
    this.bgColor = Colors.white,
    this.lineWidth = 1,
    this.borderRadius = BorderRadius.zero,
    this.extra = 0,
    this.arrowPosition = ArrowPosition.right,
    required this.arrowSize,
    this.boxShadow,
  });

  final Color lineColor;
  final Color bgColor;

  final double lineWidth;
  final BorderRadiusGeometry borderRadius;

  final double extra;
  final Size arrowSize;
  final ArrowPosition arrowPosition;

  final List<BoxShadow>? boxShadow;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomPainter(
      lineColor: lineColor,
      bgColor: bgColor,
      lineWidth: lineWidth,
      borderRadius: borderRadius,
      arrowPosition: arrowPosition,
      arrowSize: arrowSize,
      extra: extra,
      boxShadow: boxShadow,
    );
  }

  ArrowDecoration scale(double factor) {
    return ArrowDecoration(
      lineColor: Color.lerp(null, lineColor, factor)!,
      bgColor: Color.lerp(null, bgColor, factor)!,
      lineWidth: lerpDouble(null, lineWidth, factor)!,
      borderRadius: BorderRadiusGeometry.lerp(null, borderRadius, factor)!,
      arrowPosition: arrowPosition,
      extra: lerpDouble(null, extra, factor)!,
      arrowSize: Size.lerp(null, arrowSize, factor)!,
      boxShadow: BoxShadow.lerpList(null, boxShadow, factor),
    );
  }

  @override
  ArrowDecoration? lerpFrom(Decoration? a, double t) {
    if (a == null) {
      return scale(t);
    }
    if (a is ArrowDecoration) {
      return ArrowDecoration.lerp(a, this, t);
    }
    return super.lerpFrom(a, t) as ArrowDecoration?;
  }

  @override
  ArrowDecoration? lerpTo(Decoration? b, double t) {
    if (b == null) {
      return scale(1.0 - t);
    }
    if (b is ArrowDecoration) {
      return ArrowDecoration.lerp(this, b, t);
    }
    return super.lerpTo(b, t) as ArrowDecoration?;
  }

  static ArrowDecoration? lerp(ArrowDecoration? a, ArrowDecoration? b, double t) {
    if (identical(a, b)) {
      return a;
    }
    if (a == null) {
      return b!.scale(t);
    }
    if (b == null) {
      return a.scale(1.0 - t);
    }
    if (t == 0.0) {
      return a;
    }
    if (t == 1.0) {
      return b;
    }
    Size size;
    if (a.arrowPosition != b.arrowPosition) {
      if (t < 0.5) {
        size = Size(a.arrowSize.width, lerpDouble(a.arrowSize.height, 0, t * 2) ?? 0);
      } else {
        size = Size(b.arrowSize.width, lerpDouble(0, b.arrowSize.height, t * 2 - 1) ?? 0);
      }
    } else {
      size = Size.lerp(a.arrowSize, b.arrowSize, t)!;
    }
    return ArrowDecoration(
      lineColor: Color.lerp(a.lineColor, b.lineColor, t)!,
      bgColor: Color.lerp(a.bgColor, b.bgColor, t)!,
      lineWidth: lerpDouble(a.lineWidth, b.lineWidth, t)!,
      borderRadius: BorderRadiusGeometry.lerp(a.borderRadius, b.borderRadius, t)!,
      extra: lerpDouble(a.extra, b.extra, t)!,
      arrowPosition: t < 0.5 ? a.arrowPosition : b.arrowPosition,
      arrowSize: size,
      boxShadow: BoxShadow.lerpList(a.boxShadow, b.boxShadow, t),
    );
  }
}

class _CustomPainter extends BoxPainter {
  _CustomPainter({
    required this.lineColor,
    required this.bgColor,
    required this.lineWidth,
    required this.borderRadius,
    required this.arrowPosition,
    required this.arrowSize,
    required this.extra,
    required this.boxShadow,
  });

  Paint? linePainter;
  Paint? bgPainter;

  final Color lineColor;
  final Color bgColor;
  final double lineWidth;
  final BorderRadiusGeometry borderRadius;
  final Size arrowSize;
  final double extra;
  final ArrowPosition arrowPosition;
  final List<BoxShadow>? boxShadow;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    _paintShadows(canvas, offset & configuration.size!);
    linePainter = Paint()
      ..color = lineColor
      ..strokeWidth = lineWidth
      ..style = PaintingStyle.stroke;

    bgPainter = Paint()
      ..color = bgColor
      ..style = PaintingStyle.fill;

    final Path path = arrowPath(
      size: configuration.size!,
      offset: offset,
      textDirection: configuration.textDirection,
      borderRadius: borderRadius,
      arrowPosition: arrowPosition,
      arrowSize: arrowSize,
      extra: extra,
    );

    canvas
      ..drawPath(path, linePainter!)
      ..drawPath(path, bgPainter!);
  }

  void _paintShadows(Canvas canvas, Rect rect) {
    if (boxShadow == null) {
      return;
    }
    for (final BoxShadow boxShadow in boxShadow!) {
      final Paint paint = boxShadow.toPaint();
      final Rect bounds =
      rect.shift(boxShadow.offset).inflate(boxShadow.spreadRadius);
      canvas.drawRect(bounds, paint);
    }
  }
}