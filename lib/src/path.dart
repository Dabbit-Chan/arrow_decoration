import 'package:flutter/material.dart';

import '../arrow_decoration.dart';

Path arrowPath({
  required Size size,
  Offset? offset,
  TextDirection? textDirection,
  required BorderRadiusGeometry borderRadius,
  required ArrowPosition arrowPosition,
  required double extra,
  required Size arrowSize,
}) {
  final BorderRadius radius = borderRadius.resolve(textDirection);
  final Offset leftTop = offset ?? Offset.zero;
  final Offset rightTop = leftTop.translate(size.width, 0);
  final Offset leftBottom = leftTop.translate(0, size.height);
  final Offset rightBottom = leftTop.translate(size.width, size.height);

  final Offset p1 = leftTop.translate(radius.topLeft.x, 0);
  final Offset p2 = leftTop.translate(0, radius.topLeft.y);

  final Offset p3 = leftBottom.translate(0, -radius.bottomLeft.y);
  final Offset p4 = leftBottom.translate(radius.bottomLeft.x, 0);

  final Offset p5 = rightBottom.translate(-radius.bottomRight.x, 0);
  final Offset p6 = rightBottom.translate(0, -radius.bottomRight.y);

  final Offset p7 = rightTop.translate(0, radius.topRight.y);
  final Offset p8 = rightTop.translate(-radius.topRight.x, 0);

  Offset arrowStartPoint = Offset.zero;
  Offset arrowApexPoint = Offset.zero;
  Offset arrowEndPoint = Offset.zero;
  double arrowWidth = arrowSize.width;
  double arrowHeight = arrowSize.height;
  double arrowStartOffset = 0;

  switch (arrowPosition) {
    case ArrowPosition.top:
      arrowStartOffset = (p8.dx - p1.dx - arrowWidth) / 2 + extra;
      arrowStartPoint = p8.translate(-arrowStartOffset, 0);
      arrowApexPoint = arrowStartPoint.translate(-arrowWidth / 2, -arrowHeight);
      arrowEndPoint = arrowApexPoint.translate(-arrowWidth / 2, arrowHeight);
      break;
    case ArrowPosition.bottom:
      arrowStartOffset = (p5.dx - p4.dx - arrowWidth) / 2 + extra;
      arrowStartPoint = p4.translate(arrowStartOffset, 0);
      arrowApexPoint = arrowStartPoint.translate(arrowWidth / 2, arrowHeight);
      arrowEndPoint = arrowApexPoint.translate(arrowWidth / 2, -arrowHeight);
      break;
    case ArrowPosition.left:
      arrowStartOffset = (p3.dy - p2.dy - arrowWidth) / 2 + extra;
      arrowStartPoint = p2.translate(0, arrowStartOffset);
      arrowApexPoint = arrowStartPoint.translate(-arrowHeight, arrowWidth / 2);
      arrowEndPoint = arrowApexPoint.translate(arrowHeight, arrowWidth / 2);
      break;
    case ArrowPosition.right:
      arrowStartOffset = (p6.dy - p7.dy - arrowWidth) / 2 + extra;
      arrowStartPoint = p6.translate(0, -arrowStartOffset);
      arrowApexPoint = arrowStartPoint.translate(arrowHeight, -arrowWidth / 2);
      arrowEndPoint = arrowApexPoint.translate(-arrowHeight, -arrowWidth / 2);
      break;
  }

  final Path path = Path();

  path.moveTo(p1.dx, p1.dy);
  path.arcToPoint(p2, radius: radius.topLeft, clockwise: false);

  if (arrowPosition == ArrowPosition.left) {
    path.lineTo(arrowStartPoint.dx, arrowStartPoint.dy);
    path.lineTo(arrowApexPoint.dx, arrowApexPoint.dy);
    path.lineTo(arrowEndPoint.dx, arrowEndPoint.dy);
  }

  path.lineTo(p3.dx, p3.dy);
  path.arcToPoint(p4, radius: radius.bottomLeft, clockwise: false);

  if (arrowPosition == ArrowPosition.bottom) {
    path.lineTo(arrowStartPoint.dx, arrowStartPoint.dy);
    path.lineTo(arrowApexPoint.dx, arrowApexPoint.dy);
    path.lineTo(arrowEndPoint.dx, arrowEndPoint.dy);
  }

  path.lineTo(p5.dx, p5.dy);
  path.arcToPoint(p6, radius: radius.bottomRight, clockwise: false);

  if (arrowPosition == ArrowPosition.right) {
    path.lineTo(arrowStartPoint.dx, arrowStartPoint.dy);
    path.lineTo(arrowApexPoint.dx, arrowApexPoint.dy);
    path.lineTo(arrowEndPoint.dx, arrowEndPoint.dy);
  }

  path.lineTo(p7.dx, p7.dy);
  path.arcToPoint(p8, radius: radius.topRight, clockwise: false);

  if (arrowPosition == ArrowPosition.top) {
    path.lineTo(arrowStartPoint.dx, arrowStartPoint.dy);
    path.lineTo(arrowApexPoint.dx, arrowApexPoint.dy);
    path.lineTo(arrowEndPoint.dx, arrowEndPoint.dy);
  }

  path.lineTo(p1.dx, p1.dy);
  return path;
}