import 'dart:math' as math;
import 'package:flutter/material.dart';

class DonutChart extends StatelessWidget {
  final double paid;
  final double total;
  final double size;
  final Color paidColor;
  final Color eligibleColor;

  const DonutChart({
    required this.paid,
    required this.total,
    required this.size,
    required this.paidColor,
    required this.eligibleColor,
  });

  @override
  Widget build(BuildContext context) {
    double remainingBalance = total - paid;

    return SizedBox(
      width: size * 1.2, // Increase the total size of the donut
      height: size * 1.2, // Increase the total size of the donut
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size), // Increased outer radius
            painter: _DonutChartPainter(
              paid: paid,
              total: total,
              paidColor: paidColor,
              eligibleColor: eligibleColor,
            ),
          ),

          // Centered Balance Text (with better spacing)
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Balance",
                style: TextStyle(
                  fontSize: size * 0.12, // Slightly increased text size
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: size * 0.02), // Adds spacing between texts
              Text(
                "₹${remainingBalance.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: size * 0.12, // Increased balance font size
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DonutChartPainter extends CustomPainter {
  final double paid;
  final double total;
  final Color paidColor;
  final Color eligibleColor;

  _DonutChartPainter({
    required this.paid,
    required this.total,
    required this.paidColor,
    required this.eligibleColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double strokeWidth = size.width * 0.18; // Keeps thickness moderate
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt; // Keeps edges sharp

    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = (size.width/1.1) - (strokeWidth/1.1); // Increased radius

    // Draw eligible cost background
    paint.color = eligibleColor;
    canvas.drawCircle(center, radius, paint);

    // Draw paid arc
    if (paid > 0) {
      final double paidAngle = (paid / total) * 2 * math.pi; // Convert to radians
      paint.color = paidColor;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2, // Start from the top
        paidAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
