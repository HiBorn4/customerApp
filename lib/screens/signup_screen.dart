import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image Carousel
            SizedBox(
              height: 250,
              child: PageView(
                controller: _pageController,
                children: [
                  Image.asset('assets/project1.jpeg', fit: BoxFit.cover),
                  Image.asset('assets/project1.jpeg', fit: BoxFit.cover),
                  Image.asset('assets/project1.jpeg', fit: BoxFit.cover),
                ],
              ),
            ),

            // Dots Indicator
            SizedBox(height: 20),
            SmoothPageIndicator(
              controller: _pageController,
              count: 3,
              effect: ExpandingDotsEffect(
                activeDotColor: Colors.purple,
                dotColor: Colors.grey[400]!,
                dotHeight: 10,
                dotWidth: 10,
              ),
            ),

            SizedBox(height: 40),

            // Sign Up Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // Handle sign up
                  Get.toNamed('/login');
                },
                child: Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),

            SizedBox(height: 20),

            // Login Text Button
            TextButton(
              onPressed: () {
                // Navigate to login
                Get.toNamed('/login');
              },
              child: Text(
                "Have an account? Log In",
                style: TextStyle(fontSize: 16, color: Colors.purple),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
