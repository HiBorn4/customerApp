import 'package:customerapp/controllers/project_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/payment_schedule_controller.dart';
import '../models/payment_entry_model.dart';
import '../models/quick_action_model.dart';
import '../utils/app_colors.dart';

class PaymentScheduleScreen extends StatelessWidget {

  final ProjectController projectController=Get.find<ProjectController>();

  final PaymentScheduleController _controller = Get.put(
    PaymentScheduleController(),
  );

  PaymentScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: _buildAppBar(screenWidth, screenHeight),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenHeight * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildTotalBalance(screenWidth, screenHeight),
            SizedBox(height: screenHeight * 0.03),
            _buildPaymentList(screenWidth, screenHeight),
            _buildQuickActionsSection(screenWidth, screenHeight),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(double screenWidth, double screenHeight) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back, size: screenHeight * 0.025),
        onPressed: () => Get.back(),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Schedule',
            style: GoogleFonts.outfit(
              color: Color(0xff191B1C),
              fontSize: screenHeight * 0.021,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: screenWidth * 0.01),
          Text(
            'Shuba Ecostone - 131',
            style: GoogleFonts.outfit(
              fontSize: screenHeight * 0.016,
              color: Color(0xff656567),
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: screenWidth * 0.02),
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
        ],
      ),
    );
  }

  Widget _buildTotalBalance(double screenWidth, double screenHeight) {
    return Column(
      children: [
        Text(
          'TOTAL BALANCE',
          style: GoogleFonts.outfit(
            fontSize: screenHeight * 0.015,
            color: Color(0xff656567),
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        Text(
          '₹ ${projectController.totalAmount.value.round()}',
          style: GoogleFonts.outfit(
            color: Color(0xff191B1C),
            fontSize: screenHeight * 0.035,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentList(double screenWidth, double screenHeight) {
    return Obx(
      () => ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: projectController.payments.length,
        itemBuilder:
            (context, index) => _buildPaymentItem(
              screenWidth,
              screenHeight,
              projectController.payments[index],
            ),
      ),
    );
  }

  Widget _buildPaymentItem(
    double screenWidth,
    double screenHeight,
    PaymentEntry payment,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
      padding: EdgeInsets.all(screenHeight * 0.015),
      decoration: BoxDecoration(
        color: Colors.white,
        // borderRadius: BorderRadius.circular(screenHeight * 0.01),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: screenHeight * 0.002,
            blurRadius: screenHeight * 0.01,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: screenHeight * 0.03,
                    height: screenHeight * 0.03,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xff656567),
                    ),
                    child: Center(
                      child: Text(
                        payment.number,
                        style: GoogleFonts.outfit(
                          fontSize: screenHeight * 0.015,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Text(
                    payment.date,
                    style: GoogleFonts.outfit(
                      fontSize: screenHeight * 0.014,
                      color: Color(0xff656567),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Text(
                payment.status,
                style: GoogleFonts.outfit(
                  fontSize: screenHeight * 0.015,
                  color: payment.statusColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.01),
          Text(
            payment.description,
            style: GoogleFonts.outfit(
              color: Color(0xff656567),
              fontSize: screenHeight * 0.017,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: screenHeight * 0.008),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  text: payment.amount,
                  style: GoogleFonts.outfit(
                    fontSize: screenHeight * 0.018,
                    color: Color(0xff656567),
                    fontWeight: FontWeight.w600,
                    decoration:
                        payment.status == 'RECEIVED'
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                  ),
                  children: [
                    TextSpan(
                      text: ' Inc GST',
                      style: GoogleFonts.outfit(
                        fontSize: screenHeight * 0.012,
                        color: Color(0xff656567),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              if (payment.status == 'RECEIVED')
                Container(
                  width: screenWidth * 0.28,
                  height: screenHeight * 0.04,
                  decoration: BoxDecoration(
                    color: Color(0xffDFF6E0),
                    // borderRadius: BorderRadius.circular(screenHeight * 0.005),
                  ),
                  child: Center(
                    child: Text(
                      'Paid',
                      style: GoogleFonts.outfit(
                        fontSize: screenHeight * 0.016,
                        color: Color(0xff1B6600),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              else if (payment.status == 'DUE TODAY')
                Container(
                  width: screenWidth * 0.28,
                  height: screenHeight * 0.04,
                  decoration: BoxDecoration(color: Color(0xFFEDE9FE)),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Pay Now',
                      style: GoogleFonts.outfit(
                        fontSize: screenHeight * 0.016,
                        color: Color(0xff191B1C),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              else
                Container(
                  width: screenWidth * 0.28,
                  height: screenHeight * 0.04,
                  decoration: BoxDecoration(
                    color: Color(0xFFEDE9FE),
                    // borderRadius: BorderRadius.circular(screenHeight * 0.005),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Pay in Adv',
                      style: GoogleFonts.outfit(
                        fontSize: screenHeight * 0.016,
                        color: Color(0xff191B1C),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsSection(double screenWidth, double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
          child: Text(
            'QUICK ACTIONS',
            style: GoogleFonts.outfit(
              color: Color(0xff585A5C),
              fontSize: screenHeight * 0.015,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Obx(
          () => ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _controller.quickActions.length,
            itemBuilder:
                (context, index) => _buildQuickActionItem(
                  screenWidth,
                  screenHeight,
                  _controller.quickActions[index],
                ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionItem(
    double screenWidth,
    double screenHeight,
    QuickActionModel action,
  ) {
    return Container(
      height: screenWidth * 0.18,
      margin: EdgeInsets.all(screenWidth * 0.01),
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: ListTile(
        title: Text(
          action.title,
          style: GoogleFonts.outfit(
            color: Color(0xff191B1C),
            fontSize: screenHeight * 0.018,
            fontWeight: FontWeight.w400,
          ),
        ),
        subtitle: Text(
          action.description,
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w400,
            fontSize: screenHeight * 0.015,
            color: Color(0xff9FA0A1),
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: screenHeight * 0.02),
        onTap: () => _handleQuickAction(action.title),
      ),
    );
  }

  void _handleQuickAction(String action) {
    // Implement navigation logic
  }
}
