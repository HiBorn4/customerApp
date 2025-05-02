import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/responsive.dart';
import '../controllers/password_controller.dart';

class PasswordChangeScreen extends StatelessWidget {
  final PasswordController controller = Get.put(PasswordController());

  PasswordChangeScreen({super.key});

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
            SizedBox(height: screenWidth * 0.03),

            // Main content
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProfileSection(screenWidth, screenHeight),
                    SizedBox(height: screenWidth * 0.02),
                    Center(
                      child: Container(
                        width: screenHeight * 0.4,
                        height: 1,
                        decoration: BoxDecoration(color: Colors.grey.shade300),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    _buildPasswordField(
                      context: context,
                      hintText: 'Old Password',
                      controller: controller,
                      textController: controller.oldPasswordController,
                      isHidden: controller.isOldPasswordHidden,
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    _buildPasswordField(
                      context: context,
                      hintText: 'New Password',
                      controller: controller,
                      textController: controller.newPasswordController,
                      isHidden: controller.isNewPasswordHidden,
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    _buildPasswordField(
                      context: context,
                      hintText: 'Confirm Password',
                      controller: controller,
                      textController: controller.confirmPasswordController,
                      isHidden: controller.isConfirmPasswordHidden,
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      validator: (value) {
                        if (value != controller.newPasswordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => Get.toNamed('/forgot-password'),
                        child: Text(
                          'FORGOT PASSWORD?',
                          style: GoogleFonts.outfit(
                            color: Colors.black,
                            fontSize: Responsive.getFontSize(screenWidth, 15),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    Center(
                      child: ElevatedButton(
                        onPressed: controller.saveChanges,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFEDE9FE),
                          minimumSize: Size(
                            screenWidth * 0.9,
                            screenHeight * 0.06,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        child: Text(
                          'Save Changes',
                          style: GoogleFonts.outfit(
                            color: Colors.black,
                            fontSize: Responsive.getFontSize(screenWidth, 22),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }

  PreferredSizeWidget _buildAppBar(double screenWidth, double screenHeight) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Get.back(),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Password',
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

  Widget _buildProfileSection(double screenWidth, double screenHeight) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(screenHeight * 0.02),
      child: Row(
        children: [
          CircleAvatar(
            radius: screenHeight * 0.035,
            backgroundImage: AssetImage('assets/profile.jpeg'),
          ),
          SizedBox(width: screenWidth * 0.04),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'VISHAL KUMAR',
                      style: GoogleFonts.outfit(
                        color: Colors.black,
                        fontSize: Responsive.getFontSize(screenWidth, 20),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Joined on 29, Nov 2050',
                      style: GoogleFonts.outfit(
                        fontSize: Responsive.getFontSize(screenWidth, 14),
                        color: Color(0xff656567),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.edit, size: screenHeight * 0.025),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField({
    required BuildContext context,
    required String hintText,
    required PasswordController controller,
    required TextEditingController textController,
    required RxBool isHidden,
    required double screenWidth,
    required double screenHeight,
    FormFieldValidator<String>? validator,
  }) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
      child: Obx(
        () => TextFormField(
          controller: textController,
          obscureText: isHidden.value,
          style: GoogleFonts.outfit(
            fontSize: Responsive.getFontSize(screenWidth, 16),
            color: Color(0xff616162),
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.outfit(
              fontSize: Responsive.getFontSize(screenWidth, 16),
              color: Color(0xff616162),
              fontWeight: FontWeight.w400,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: Colors.black, width: 0.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: Colors.black, width: 0.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: Colors.black, width: 0.5),
            ),
            contentPadding: EdgeInsets.all(screenWidth * 0.03),
            suffixIcon: IconButton(
              icon: Icon(
                isHidden.value ? Icons.visibility_off : Icons.visibility,
                color: Color(0xff191B1C),
                size: screenHeight * 0.02,
              ),
              onPressed: () {
                isHidden.toggle();
              },
            ),
          ),
          validator:
              validator ??
              (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
        ),
      ),
    );
  }
}
