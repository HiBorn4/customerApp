import 'package:flutter/material.dart';

class DimensionDiagram extends StatelessWidget {
  final double screenWidth;

  const DimensionDiagram({required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main rectangle
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
        ),

        // Room labels
        Positioned(
          left: screenWidth * 0.1,
          top: screenWidth * 0.1,
          child: _buildRoomLabel('Living', '14.15 ft'),
        ),
        Positioned(
          right: screenWidth * 0.1,
          top: screenWidth * 0.1,
          child: _buildRoomLabel('Bed 1', '12.15 ft'),
        ),

        // Dimension lines
        CustomPaint(
          painter: _DimensionLinePainter(screenWidth: screenWidth),
        ),
      ],
    );
  }

  Widget _buildRoomLabel(String name, String dimension) {
    return Column(
      children: [
        Text(name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.035,
            )),
        Text(dimension,
            style: TextStyle(
              fontSize: screenWidth * 0.03,
            )),
      ],
    );
  }
}

class _DimensionLinePainter extends CustomPainter {
  final double screenWidth;

  _DimensionLinePainter({required this.screenWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1;

    // Horizontal dimension line
    canvas.drawLine(
      Offset(screenWidth * 0.1, screenWidth * 0.2),
      Offset(screenWidth * 0.3, screenWidth * 0.2),
      paint,
    );

    // Vertical dimension line
    canvas.drawLine(
      Offset(screenWidth * 0.35, screenWidth * 0.25),
      Offset(screenWidth * 0.35, screenWidth * 0.4),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}