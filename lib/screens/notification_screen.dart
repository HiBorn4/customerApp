import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/responsive.dart';

class NotificationsScreen extends StatelessWidget {
  final RxBool paymentDueSelected = false.obs;
  final RxBool offersAndDiscountsSelected = false.obs;

  NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(screenWidth, screenHeight),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: screenHeight * 0.35,
                height: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.transparent,
                      Colors.grey.shade400,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: screenWidth * 0.04),
            // Main content
            Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPermissionSection(screenWidth, screenHeight),
                  SizedBox(height: screenHeight * 0.02),
                  _buildNotificationOption(
                    title: 'Payment Due',
                    description: 'Never miss a payment',
                    isSelected: paymentDueSelected,
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  _buildNotificationOption(
                    title: 'Offers and Discounts',
                    description: 'Save more with special offers and discounts',
                    isSelected: offersAndDiscountsSelected,
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  // Add more notification options here as needed
                  SizedBox(height: screenHeight * 0.03),
                ],
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: 2,
      //   selectedItemColor: Colors.black,
      //   unselectedItemColor: Colors.black,
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.list),
      //       label: 'Units',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: 'Profile',
      //     ),
      //   ],
      //   onTap: (index) {
      //     if (index == 0) Get.offAllNamed('/home');
      //     if (index == 1) Get.offAllNamed('/project-detail');
      //   },
      // ),
    );
  }

  PreferredSizeWidget _buildAppBar(double screenWidth, double screenHeight) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Get.back(),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Notifications',
            style: GoogleFonts.outfit(
              color: Colors.black,
              fontSize: Responsive.getFontSize(screenWidth, 24),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionSection(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: screenHeight * 0.02,
      ),
      child: Text(
        'PERMISSION',
        style: GoogleFonts.outfit(
          fontSize: Responsive.getFontSize(screenWidth, 16),
          fontWeight: FontWeight.w500,
          color: Color(0xff606062),
        ),
      ),
    );
  }

  Widget _buildNotificationOption({
    required String title,
    required String description,
    required RxBool isSelected,
    required double screenWidth,
    required double screenHeight,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenHeight * 0.02,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.outfit(
                    fontSize: Responsive.getFontSize(screenWidth, 20),
                    fontWeight: FontWeight.w500,
                    color: Color(0xff191B1C),
                  ),
                ),
                SizedBox(height: screenHeight * 0.005),
                Text(
                  description,
                  style: GoogleFonts.outfit(
                    fontSize: Responsive.getFontSize(screenWidth, 16),
                    color: Color(0xff606062),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => GestureDetector(
              onTap: () {
                isSelected.toggle();
              },
              child: Container(
                height: screenHeight * 0.03,
                width: screenHeight * 0.03,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child:
                    isSelected.value
                        ? Icon(
                          Icons.check,
                          size: screenHeight * 0.02,
                          color: Colors.black,
                        )
                        : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
