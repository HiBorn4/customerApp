import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/unit_model.dart';

class UnitItem extends StatelessWidget {
  final UnitModel unit;

  const UnitItem({required this.unit});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.all(screenWidth * 0.03),
      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
      height: screenHeight*0.2,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Column 1
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                Column(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                 Text(
                  'Shuba Eco Stone',
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.005),

                Text(
                  'UNIT NO: ${unit.unitNo}',
                  style: TextStyle(fontSize: screenWidth * 0.035),
                ),
                SizedBox(height: screenHeight * 0.005),],),

                Column(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                  Container(
  width: screenWidth * 0.1,
  height: screenWidth * 0.1,
  decoration: BoxDecoration(
    shape: BoxShape.circle, // Changed to circular shape
    border: Border.all(color: Colors.black),
    image: DecorationImage(
      image: AssetImage('assets/profile.jpeg'), // Placeholder image
      fit: BoxFit.cover,
    ),
  ),
),

                SizedBox(height: screenHeight * 0.005),

                Text(
                  unit.user,
                  style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),
                ),],)
              ],
            ),
          ),
          SizedBox(width: screenWidth*0.2,),

          // Column 2
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Registered Label
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.005,
                    horizontal: screenWidth * 0.03,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.2),
                    border: Border.all(color: Colors.green),
                  ),
                  child: Text(
                    'REGISTERED',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.035,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),

                Text(
                  'Total Due',
                  style: TextStyle(fontSize: screenWidth * 0.035),
                ),
                SizedBox(height: screenHeight * 0.005),

                Text(
                  '₹${unit.due}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.045,
                  ),
                ),
                SizedBox(height: screenHeight * 0.005),

                // "Know More" Button with Circular Arrow
                InkWell(
                  onTap: () => Get.toNamed('/project-detail'),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Know More',
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Container(
                        width: screenWidth * 0.08,
                        height: screenWidth * 0.08,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black),
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          size: screenWidth * 0.04,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
