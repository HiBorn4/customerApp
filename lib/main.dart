import 'package:customerapp/screens/activity_log_screen.dart';
import 'package:customerapp/screens/cost_sheet_screen.dart';
import 'package:customerapp/screens/login_screen.dart';
import 'package:customerapp/screens/modification_screen.dart';
import 'package:customerapp/screens/otp_screen.dart';
import 'package:customerapp/screens/profile_screen.dart';
import 'package:customerapp/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/home_screen.dart';
import 'screens/payment_schedule_screen.dart';
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
      home: SignupScreen(),
      initialRoute: "/",
      getPages: [
        GetPage(name: '/', page: () => SignupScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/project-detail', page: () => ProjectDetailScreen()),
        GetPage(name: '/payment-schedule', page: () => PaymentScheduleScreen()),
        GetPage(name: '/cost-sheet', page: () => CostSheetScreen()),
        GetPage(name: '/activity-log', page: () => ActivityLogScreen()),
        GetPage(name: '/modification', page: () => ModificationScreen()),
        GetPage(name: '/profile', page: () => ProfileScreen()),
      ],
    );
  }
}