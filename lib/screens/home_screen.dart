import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../widgets/need_attention_item.dart';
import '../widgets/summary_item.dart';
import '../widgets/unit_item.dart';
import '../widgets/project_card.dart';
import '../utils/responsive.dart';

class HomeScreen extends StatelessWidget {
  final HomeController _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good Morning...!',
              style: TextStyle(
                fontSize: Responsive.getFontSize(screenWidth, 16),
              ),),
            Text(
              'Vishal',
              style: TextStyle(
                fontSize: Responsive.getFontSize(screenWidth, 20),
                fontWeight: FontWeight.bold,
              ),)
          ],
        ),
      ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(Responsive.getPadding(screenWidth).horizontal*0.3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSummarySection(screenWidth),
              SizedBox(height: screenHeight * 0.03),
              _buildNeedsAttentionSection(screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.01),
              _buildMyUnitsSection(screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.03),
              _buildUpcomingProjectsSection(screenWidth, screenHeight),
            ],
          ),
        ),
      
    );
  }

  Widget _buildSummarySection(double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SUMMARY ACROSS UNIT',
          style: TextStyle(
            fontSize: Responsive.getFontSize(screenWidth, 18),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: screenWidth * 0.02),
        Row(
          children: _controller.summaryData.map((item) => Expanded(
            child: SummaryItem(
              value: item['value']!,
              label: item['label']!,
              screenWidth: screenWidth,
            ),
          )).toList(),
        ),
      ],
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

  Widget _buildMyUnitsSection(double screenWidth, double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(
          'MY UNITS',
          style: TextStyle(
            fontSize: Responsive.getFontSize(screenWidth, 18),
            fontWeight: FontWeight.bold,
          ),
          
        ),
        TextButton(
              onPressed: () => Get.toNamed('/project-detail'),
              child: Row(
                children: [
                  Text('View More'),
                  // Icon(Icons.arrow_forward, size: 16),
                ],
              ),
            ),],),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _controller.myUnits.length,
          itemBuilder: (context, index) => UnitItem(
            unit: _controller.myUnits[index],
            // _controller.screenWidth: screenWidth,
          ),
        ),
      ],
    );
  }

  Widget _buildUpcomingProjectsSection(double screenWidth, double screenHeight) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'UPCOMING PROJECTS',
        style: TextStyle(
          fontSize: Responsive.getFontSize(screenWidth, 18),
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: screenHeight * 0.02),
      SizedBox(
        height: screenHeight * 0.5,
        child: PageView.builder(
          controller: PageController(viewportFraction: 1.0), // Full width, no extra space
          itemCount: _controller.projects.length,
          itemBuilder: (context, index) => ProjectCard(
            project: _controller.projects[index],
          ),
        ),
      ),
    ],
  );
}

}