import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/unit_model.dart';

class NeedsAttentionItem extends StatelessWidget {
  final UnitModel unit;
  final int index;

  const NeedsAttentionItem({
    required this.unit,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.18,
      width: screenWidth,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero), // Sharp edges
        margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // First row: Unit number and digit in one row
              Row(
                children: [
                  Container(
  width: screenWidth * 0.08,
  height: screenWidth * 0.08,
  alignment: Alignment.center,
  decoration: BoxDecoration(
    color: Colors.grey[300],
    shape: BoxShape.circle, // Makes it circular
    border: Border.all(color: Colors.black),
  ),
  child: Text('${index + 1}'.padLeft(2, '0'),
      style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.bold)),
),

                  SizedBox(width: screenWidth * 0.03),
                  Text(
                    'UNIT NO: ${unit.unitNo}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenWidth * 0.045),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.005),

              // Second row: Description
              Text(
                'Clear your Outstanding amount for Legal charges of',
                style: TextStyle(fontSize: screenWidth * 0.035),
              ),
              SizedBox(height: screenHeight * 0.008),

              // Third row: Price on left, Due date & Pay Now button on right
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        '₹${unit.amount}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.045,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.015),
                      Text(
                        'Due in ${unit.daysLeft} days',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: screenHeight * 0.05,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero), // Sharp corners
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                      ),
                      onPressed: () => Get.toNamed('/payment'),
                      child: Text(
                        'Pay Now',
                        style: TextStyle(fontSize: screenWidth * 0.035),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
