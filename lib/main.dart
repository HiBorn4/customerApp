import 'package:customerapp/screens/login_screen.dart';
import 'package:customerapp/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/home_screen.dart';
import 'screens/project_detail_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Home Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: HomeScreen(),
      // home: ProjectDetailScreen(),
      home: SignupScreen(),
      // initialRoute: "/",
      getPages: [
        // GetPage(name: '/', page: () => LoginScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
        // GetPage(name: '/payment', page: () => PaymentScreen()),
        // GetPage(name: '/attention', page: () => AttentionScreen()),
        GetPage(name: '/project-detail', page: () => ProjectDetailScreen()),
      ],
    );
  }
}