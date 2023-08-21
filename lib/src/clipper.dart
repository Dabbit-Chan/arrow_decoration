import 'package:flutter/material.dart';

import '../arrow_decoration.dart';

class ArrowClipper extends CustomClipper<Path> {
  const ArrowClipper({
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
  Path getClip(Size size) {
    return arrowPath(
      size: size,
      borderRadius: borderRadius,
      arrowPosition: arrowPosition,
      arrowSize: arrowSize,
      extra: extra,
    );
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}