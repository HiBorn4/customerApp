// File: screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  final bool isSignup;
  
  const LoginScreen({Key? key, this.isSignup = false}) : super(key: key);
  
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;
  bool _isChecked = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  // Get the auth service
  final AuthService _authService = Get.find<AuthService>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _validateEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool _validatePassword(String password) {
    // Require at least 6 characters
    return password.length >= 6;
  }

  void _handleContinue() async {
    // Reset local error message
    String localError = '';
    
    String email = _emailController.text.trim();
    String password = _passwordController.text;
    
    // Input validation
    if (email.isEmpty) {
      setState(() {
        localError = 'Email is required';
      });
      return;
    }
    
    if (!_validateEmail(email)) {
      setState(() {
        localError = 'Please enter a valid email address';
      });
      return;
    }
    
    if (password.isEmpty) {
      setState(() {
        localError = 'Password is required';
      });
      return;
    }
    
    if (!_validatePassword(password)) {
      setState(() {
        localError = 'Password must be at least 6 characters';
      });
      return;
    }
    
    try {
      // Check if this is signup or login mode
      if (widget.isSignup) {
        // SIGNUP FLOW: Create new user
        final user = await _authService.signUp(email, password);
        
        if (user != null) {
          // Navigate to OTP verification screen
          Get.toNamed('/otp', arguments: {'email': email});
        }
      } else {
        // LOGIN FLOW: Sign in existing user
        final user = await _authService.signIn(email, password);
        
        if (user != null) {
          // Check if email is verified
          if (!user.emailVerified) {
            // Email not verified, send to OTP screen
            await _authService.sendOTP();
            Get.toNamed('/otp', arguments: {'email': email});
          } else {
            // Email verified, go to home
            Get.offAllNamed('/home');
          }
        }
      }
    } catch (e) {
      // Handle any unexpected errors
      setState(() {
        localError = 'An unexpected error occurred';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      // Black Header (40% of screen)
                      Container(
                        height: screenHeight * 0.4,
                        width: double.infinity,
                        color: Colors.black,
                        padding: EdgeInsets.only(left: 20, bottom: 30),
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          widget.isSignup
                              ? "Create Account\nPlease enter\nyour details."
                              : "Sales Team Only\nTell us your login\ndetails.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.06,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // White Section
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: screenHeight * 0.03),

                              // Email Field
                              TextField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: "Email",
                                  border: OutlineInputBorder(),
                                  suffixIcon: _emailController.text.isNotEmpty && _validateEmail(_emailController.text)
                                      ? Icon(Icons.check_circle, color: Colors.green)
                                      : null,
                                ),
                                onChanged: (value) {
                                  setState(() {});
                                },
                              ),

                              SizedBox(height: screenHeight * 0.02),

                              // Password Field
                              TextField(
                                controller: _passwordController,
                                obscureText: !_isPasswordVisible,
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  border: OutlineInputBorder(),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isPasswordVisible = !_isPasswordVisible;
                                      });
                                    },
                                  ),
                                ),
                              ),

                              // Error message from auth service
                              Obx(() {
                                if (_authService.errorMessage.value.isNotEmpty) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                                    child: Text(
                                      _authService.errorMessage.value,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: screenWidth * 0.035,
                                      ),
                                    ),
                                  );
                                }
                                return SizedBox.shrink();
                              }),

                              SizedBox(height: screenHeight * 0.02),

                              // Checkbox for Call & Activity Logs
                              Row(
                                children: [
                                  Checkbox(
                                    value: _isChecked,
                                    onChanged: (value) {
                                      setState(() {
                                        _isChecked = value!;
                                      });
                                    },
                                  ),
                                  Expanded(
                                    child: Text("Allow to capture call and other activity logs"),
                                  ),
                                ],
                              ),

                              SizedBox(height: screenHeight * 0.03),

                              // Agree & Continue Button
                              SizedBox(
                                width: double.infinity,
                                child: Obx(() => ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.purple,
                                    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: _authService.isLoading.value ? null : _handleContinue,
                                  child: _authService.isLoading.value
                                      ? SizedBox(
                                          height: screenWidth * 0.05, 
                                          width: screenWidth * 0.05,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 3,
                                          ),
                                        )
                                      : Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              widget.isSignup ? "Continue" : "Agree & Continue",
                                              style: TextStyle(
                                                fontSize: screenWidth * 0.05,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(width: screenWidth * 0.02),
                                            Icon(Icons.arrow_forward, color: Colors.white),
                                          ],
                                        ),
                                )),
                              ),

                              SizedBox(height: screenHeight * 0.03),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}