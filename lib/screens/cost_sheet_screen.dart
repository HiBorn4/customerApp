// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/cost_sheet_controller.dart';
// import '../widgets/total_unit_cost_widget.dart';
// import '../widgets/section_widget.dart';
// import '../widgets/payment_entry_widget.dart';
// import '../widgets/quick_action_item.dart';

// class CostSheetScreen extends StatelessWidget {
//   final CostSheetController _controller = Get.put(CostSheetController());

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final padding = screenWidth * 0.04;

//     return Scaffold(
//       appBar: _buildAppBar(screenWidth),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(padding),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TotalUnitCostWidget(screenWidth: screenWidth),
//             SizedBox(height: padding),
//             SectionWidget(
//               title: 'PLC',
//               items: _controller.plcItems,
//               screenWidth: screenWidth,
//             ),
//             SectionWidget(
//               title: 'ADDITIONAL CHARGES',
//               items: _controller.additionalCharges,
//               screenWidth: screenWidth,
//             ),
//             SectionWidget(
//               title: 'CONSTRUCTION CHARGES',
//               items: _controller.constructionCharges,
//               screenWidth: screenWidth,
//             ),
//             SectionWidget(
//               title: 'CONSTRUCTION ADDITIONAL CHARGES',
//               items: _controller.constructionAdditional,
//               screenWidth: screenWidth,
//             ),
//             _buildPossessionSection(screenWidth),
//             _buildPaymentSchedule(screenWidth),
//             SizedBox(height: padding),
//             _buildQuickActions(screenWidth),
//           ],
//         ),
//       ),
//     );
//   }

//   AppBar _buildAppBar(double screenWidth) {
//     return AppBar(
//       leading: IconButton(
//         icon: Icon(Icons.arrow_back, size: screenWidth * 0.06),
//         onPressed: () => Get.back(),
//       ),
//       title: Column(
//         children: [
//           Text('Cost Sheet',
//               style: TextStyle(
//                 fontSize: screenWidth * 0.045,
//                 fontWeight: FontWeight.bold,
//               )),
//           Text('Shuba Ecostone - 131',
//               style: TextStyle(
//                 fontSize: screenWidth * 0.03,
//               )),
//         ],
//       ),
//       centerTitle: true,
//     );
//   }

//   Widget _buildPossessionSection(double screenWidth) {
//     return SectionWidget(
//       title: 'POSSESSION CHARGES',
//       items: _controller.possessionCharges,
//       screenWidth: screenWidth,
//     );
//   }

//   Widget _buildPaymentSchedule(double screenWidth) {
//     return Card(
//       margin: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
//       child: Padding(
//         padding: EdgeInsets.all(screenWidth * 0.04),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('PAYMENT SCHEDULE',
//                     style: TextStyle(
//                       fontSize: screenWidth * 0.04,
//                       fontWeight: FontWeight.bold,
//                     )),
//                 TextButton(
//                   onPressed: () => Get.toNamed('/payment-schedule'),
//                   child: Text('View all'),
//                 ),
//               ],
//             ),
//             ..._controller.paymentEntries.map(
//               (entry) => PaymentEntryWidget(entry: entry, screenWidth: screenWidth),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildQuickActions(double screenWidth) {
//     return Card(
//       margin: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
//       child: Padding(
//         padding: EdgeInsets.all(screenWidth * 0.04),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('QUICK ACTIONS',
//                 style: TextStyle(
//                   fontSize: screenWidth * 0.04,
//                   fontWeight: FontWeight.bold,
//                 )),
//             ..._controller.quickActions.map(
//               (action) => QuickActionWidget(action: action, screenWidth: screenWidth),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }