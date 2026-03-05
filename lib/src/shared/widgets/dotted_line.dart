import 'package:flutter/material.dart';

class DottedLine extends StatelessWidget {
  final Color color;
  final double dotSize;
  final double spacing;
  final Axis direction;

  const DottedLine({
    super.key,
    this.color = Colors.grey,
    this.dotSize = 3,
    this.spacing = 3,
    this.direction = Axis.horizontal,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: direction == Axis.horizontal ? double.infinity : dotSize,
      height: direction == Axis.vertical ? double.infinity : dotSize,
      child: CustomPaint(
        painter: _DottedLinePainter(
          color: color,
          dotSize: dotSize,
          spacing: spacing,
          direction: direction,
        ),
      ),
    );
  }
}

class _DottedLinePainter extends CustomPainter {
  final Color color;
  final double dotSize;
  final double spacing;
  final Axis direction;

  _DottedLinePainter({
    required this.color,
    required this.dotSize,
    required this.spacing,
    required this.direction,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final total = direction == Axis.horizontal ? size.width : size.height;
    final step = dotSize + spacing;
    final count = (total / step).floor();

    for (int i = 0; i < count; i++) {
      final start = i * step;

      final rect = direction == Axis.horizontal
          ? Rect.fromLTWH(start, 0, dotSize, dotSize)
          : Rect.fromLTWH(0, start, dotSize, dotSize);

      canvas.drawRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(_DottedLinePainter old) =>
      old.color != color ||
          old.dotSize != dotSize ||
          old.spacing != spacing;
}