import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/project_controller.dart';
import '../widgets/dimension_graph_chart.dart';
import '../widgets/donut_chart.dart';
// import '../widgets/dimension_diagram.dart';
import '../widgets/document_item.dart';
import '../widgets/need_attention_item.dart';
import '../widgets/transaction_item.dart';
import '../widgets/quick_action_item.dart';
import '../utils/responsive.dart';

class ProjectDetailScreen extends StatelessWidget {
  final ProjectController _controller = Get.put(ProjectController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: _buildAppBar(screenWidth),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Responsive.getPadding(screenWidth).horizontal*0.3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUnitSummary(screenWidth),
            SizedBox(height: screenHeight * 0.03),

              _buildNeedsAttentionSection(screenWidth, screenHeight),
            SizedBox(height: screenHeight * 0.03),

            _buildUnitDimensions(screenWidth),
            SizedBox(height: screenHeight * 0.03),
            _buildModificationSection(screenWidth),
            SizedBox(height: screenHeight * 0.03),
            _buildHelpRepairSection(screenWidth),
            SizedBox(height: screenHeight * 0.03),
            _buildDocumentsSection(screenWidth),
            SizedBox(height: screenHeight * 0.03),
            _buildTransactionsSection(screenWidth),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(double screenWidth) {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Shuba Ecostone',
              style: TextStyle(
                fontSize: Responsive.getFontSize(screenWidth, 20),
              )),
          Text('Shuba Ecostone - 131',
              style: TextStyle(
                fontSize: Responsive.getFontSize(screenWidth, 14),
              )),
        ],
      ),
    );
  }

  Widget _buildUnitSummary(double screenWidth) {
  RxInt selectedTab = 0.obs; // 0 = Stage Balance, 1 = Unit Cost
  final ProjectController _controller = Get.find<ProjectController>(); 

  return Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading
          Text(
            'UNIT SUMMARY',
            style: TextStyle(
              fontSize: Responsive.getFontSize(screenWidth, 18),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: screenWidth * 0.03),

          // Tab Switcher
          Row(
            children: [
              _buildTab('Stage Balance', 0, selectedTab, screenWidth),
              _buildTab('Unit Cost', 1, selectedTab, screenWidth),
            ],
          ),
          SizedBox(height: screenWidth * 0.04),

          // Card with switchable content
          Container(
            padding: EdgeInsets.all(screenWidth * 0.04),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(15),
            ),
            child: selectedTab.value == 0
                ? _buildStageBalance(screenWidth, _controller)
                : _buildUnitCost(screenWidth, _controller),
          ),
        ],
      ));
}

// Widget for Stage Balance
Widget _buildStageBalance(double screenWidth, ProjectController _controller) {
  return Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Aligns donut and amounts properly
        children: [
          // Donut Chart (Eligible = Grey, Paid = Light Lavender)
          SizedBox(width: screenWidth * 0.08),  
          Expanded(
            flex: 2,
            child: Column(
              children: [
                DonutChart(
                  paid: _controller.paidAmount.value,
                  total: _controller.totalAmount.value,
                  size: screenWidth * 0.35,
                  paidColor: Colors.purple[300]!, // Paid section color
                  eligibleColor: Colors.grey[400]!, // Remaining section color
                ),
                SizedBox(height: screenWidth * 0.05), // Space below donut
              ],
            ),
          ),

          // Added space between Donut Chart and Amount Details
          SizedBox(width: screenWidth * 0.2),  

          // Amount Details
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAmountRow('Eligible Cost', '₹${_controller.totalAmount.value}', Colors.grey[700]!),
                SizedBox(height: screenWidth * 0.02), // Space between rows
                _buildAmountRow('Paid Cost', '₹${_controller.paidAmount.value}', Colors.purple[300]!),
              ],
            ),
          ),
        ],
      ),


      // Legend (Color Indication) - Now Below the Donut
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildLegendItem(Colors.grey[400]!, 'Eligible Cost'),
          SizedBox(width: screenWidth * 0.06),
          _buildLegendItem(Colors.purple[300]!, 'Paid Cost'),
        ],
      ),
    ],
  );
}


// Legend Item Widget
Widget _buildLegendItem(Color color, String label) {
  return Row(
    children: [
      Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
      SizedBox(width: 8),
      Text(
        label,
        style: TextStyle(fontSize: 14),
      ),
    ],
  );
}

// Placeholder for Unit Cost section
Widget _buildUnitCost(double screenWidth, ProjectController _controller) {
  return Center(
    child: Text(
      'Unit Cost Details Coming Soon!',
      style: TextStyle(fontSize: Responsive.getFontSize(screenWidth, 16)),
    ),
  );
}

// Tab Widget
Widget _buildTab(String title, int index, RxInt selectedTab, double screenWidth) {
  return Expanded(
    child: GestureDetector(
      onTap: () => selectedTab.value = index,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: screenWidth * 0.03),
        decoration: BoxDecoration(
          color: selectedTab.value == index ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(index == 0 ? 10 : 0),
            topRight: Radius.circular(index == 1 ? 10 : 0),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            fontSize: Responsive.getFontSize(screenWidth, 14),
            fontWeight: FontWeight.bold,
            color: selectedTab.value == index ? Colors.white : Colors.black,
          ),
        ),
      ),
    ),
  );
}

// Amount Row (Stacked Layout: Label above, Value below)
Widget _buildAmountRow(String label, String value, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // Container(
            //   width: 12,
            //   height: 12,
            //   decoration: BoxDecoration(
            //     color: color,
            //     shape: BoxShape.circle,
            //   ),
            // ),
            // SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500, // Slightly bold for emphasis
              ),
            ),
          ],
        ),
        SizedBox(height: 4), // Small spacing between label and value
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget _buildNeedsAttentionSection(double screenWidth, double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'NEEDS ATTENTION',
              style: TextStyle(
                fontSize: Responsive.getFontSize(screenWidth, 22),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: screenHeight * 0.01),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _controller.attentionItems.length,
          itemBuilder: (context, index) => NeedsAttentionItem(
            unit: _controller.attentionItems[index],
            index: index,
            // _controller.screenWidth: screenWidth,
          ),
        ),
      ],
    );
  }

  Widget _buildUnitDimensions(double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('UNIT DETAILS AND DIMENSIONS',
            style: TextStyle(
              fontSize: Responsive.getFontSize(screenWidth, 18),
              fontWeight: FontWeight.bold,
            )),
        SizedBox(height: screenWidth * 0.03),
        Container(
          height: screenWidth * 0.8,
          padding: EdgeInsets.all(screenWidth * 0.04),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(15),
          ),
          child: DimensionDiagram(screenWidth: screenWidth),
        ),
      ],
    );
  }

  Widget _buildModificationSection(double screenWidth) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Heading
      Text(
        'Modification',
        style: TextStyle(
          fontSize: Responsive.getFontSize(screenWidth, 18),
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: screenWidth * 0.03),

      // Modification Card
      Container(
        padding: EdgeInsets.all(screenWidth * 0.04),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          border: Border.all(color: Colors.black), // Optional border
        ),
        child: Row(
          children: [
            // Modification Icon
            Icon(
              Icons.build, // Change to any relevant modification icon
              size: screenWidth * 0.08,
              color: Colors.blueAccent,
            ),
            SizedBox(width: screenWidth * 0.04),

            // Text Column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Need to modify your home?',
                    style: TextStyle(
                      fontSize: Responsive.getFontSize(screenWidth, 16),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Modify home's layout, interiors or features effortlessly.",
                    style: TextStyle(
                      fontSize: Responsive.getFontSize(screenWidth, 14),
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),

            // Right Arrow
            Icon(
              Icons.arrow_forward_ios,
              size: screenWidth * 0.06,
              color: Colors.black,
            ),
          ],
        ),
      ),
    ],
  );
}


  Widget _buildHelpRepairSection(double screenWidth) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Heading
      Text(
        'Help & Repair',
        style: TextStyle(
          fontSize: Responsive.getFontSize(screenWidth, 18),
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: screenWidth * 0.03),

      // Profile Card
      Container(
        padding: EdgeInsets.all(screenWidth * 0.04),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.black), // Optional border
        ),
        child: Row(
          children: [
            // Profile Image
            CircleAvatar(
              radius: screenWidth * 0.08,
              backgroundImage: AssetImage('assets/profile.jpeg'),
            ),
            SizedBox(width: screenWidth * 0.04),

            // Name, Position, and Number
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hanif',
                    style: TextStyle(
                      fontSize: Responsive.getFontSize(screenWidth, 16),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'CRM Management',
                    style: TextStyle(
                      fontSize: Responsive.getFontSize(screenWidth, 14),
                      color: Colors.grey[700],
                    ),
                  ),
                  Text(
                    '191 19145 56789',
                    style: TextStyle(
                      fontSize: Responsive.getFontSize(screenWidth, 14),
                    ),
                  ),
                ],
              ),
            ),

            // Contact Button
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: TextButton(
                onPressed: () => Get.toNamed('/contact'),
                child: Text(
                  'Contact',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}


  Widget _buildDocumentsSection(double screenWidth) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'DOCUMENTS',
            style: TextStyle(
              fontSize: Responsive.getFontSize(screenWidth, 18),
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: () => Get.toNamed('/documents'),
            child: Text('View all'),
          ),
        ],
      ),
      Obx(() => ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _controller.documents.length,
            itemBuilder: (context, index) => DocumentItem(
              document: _controller.documents[index],
              screenWidth: screenWidth,
            ),
          )),
    ],
  );
}


  Widget _buildTransactionsSection(double screenWidth) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Title: RECENT TRANSACTIONS
      Text(
        'RECENT TRANSACTIONS',
        style: TextStyle(
          fontSize: Responsive.getFontSize(screenWidth, 18),
          fontWeight: FontWeight.bold,
        ),
      ),

      SizedBox(height: 8),

      // Transactions List
      Obx(() => ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _controller.transactions.length,
            itemBuilder: (context, index) => TransactionItem(
              transaction: _controller.transactions[index],
              screenWidth: screenWidth,
            ),
          )),

      SizedBox(height: 8),

      // "View all" Button with Lines Below
      Align(
        alignment: Alignment.bottomRight,
        child: Column(
          children: [
            TextButton(
              onPressed: () => Get.toNamed('/transactions'),
              child: Text('View all'),
            ),
          ],
        ),
      ),
    ],
  );
}


  
}