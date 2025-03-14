import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../widgets/need_attention_item.dart';
import '../widgets/summary_item.dart';
import '../widgets/unit_item.dart';
import '../widgets/project_card.dart';
import '../utils/responsive.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController _controller = Get.put(HomeController());
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeContent(),
    Center(child: Text("Documents Page")), // Placeholder for Documents
    Center(child: Text("Applicants Page")), // Placeholder for Applicants
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Shows selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue, // Active tab color
        unselectedItemColor: Colors.grey, // Inactive tab color
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: "Documents",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: "Applicants",
          ),
        ],
      ),
    );
  }
}

// Separate Widget for Home Page Content
class HomeContent extends StatelessWidget {
  final HomeController _controller = Get.find<HomeController>();

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
              style: TextStyle(fontSize: Responsive.getFontSize(screenWidth, 20)),
            ),
            Text(
              'Vishal',
              style: TextStyle(
                fontSize: Responsive.getFontSize(screenWidth, 28),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: Responsive.getPadding(screenWidth).horizontal * 0.3),
            child: IconButton(
              icon: Icon(Icons.settings, size: Responsive.getFontSize(screenWidth, 40)),
              onPressed: () => Get.toNamed('/profile'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.grey[100],
            child: SingleChildScrollView(
              padding: EdgeInsets.all(Responsive.getPadding(screenWidth).horizontal * 0.3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSummarySection(screenWidth),
                  SizedBox(height: screenHeight * 0.03),
                  _buildNeedsAttentionSection(screenWidth, screenHeight),
                  _buildMyUnitsSection(screenWidth, screenHeight),
                  _buildUpcomingProjectsSection(screenWidth, screenHeight),
                ],
              ),
            ),
          ),
          
          // ✅ Footer now outside the padding
          _buildFooterSection(screenWidth),
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
          style: TextStyle(fontSize: Responsive.getFontSize(screenWidth, 14), fontWeight: FontWeight.bold),
        ),
        SizedBox(height: screenWidth * 0.02),
        Row(
          children: _controller.summaryData.map((item) => 
            Expanded(
              child: SummaryItem(value: item['value']!, label: item['label']!, screenWidth: screenWidth),
            ),
          ).toList(),
        ),
      ],
    );
  }

  Widget _buildNeedsAttentionSection(double screenWidth, double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'NEEDS ATTENTION',
          style: TextStyle(fontSize: Responsive.getFontSize(screenWidth, 14), fontWeight: FontWeight.bold),
        ),
        SizedBox(height: screenHeight * 0.01),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _controller.attentionItems.length,
          itemBuilder: (context, index) => NeedsAttentionItem(
            unit: _controller.attentionItems[index],
            index: index,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => Get.toNamed('/needs-attention'),
            child: Text(
              'View all',
              style: TextStyle(
                fontSize: Responsive.getFontSize(screenWidth, 16),
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMyUnitsSection(double screenWidth, double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'MY UNITS',
          style: TextStyle(fontSize: Responsive.getFontSize(screenWidth, 14), fontWeight: FontWeight.bold),
        ),
        SizedBox(height: screenHeight * 0.01),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _controller.myUnits.length,
          itemBuilder: (context, index) => UnitItem(unit: _controller.myUnits[index]),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => Get.toNamed('/my-units'),
            child: Text(
              'View all',
              style: TextStyle(
                fontSize: Responsive.getFontSize(screenWidth, 16),
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
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
        style: TextStyle(fontSize: Responsive.getFontSize(screenWidth, 14), fontWeight: FontWeight.bold),
      ),
      SizedBox(height: screenHeight * 0.02),

      // 🔥 Ensuring proper height for scrolling
      SizedBox(
        height: screenHeight * 0.45, // Adjust height dynamically to prevent overflow
        child: PageView.builder(
          controller: PageController(
            initialPage: 0,
            viewportFraction: 0.48, // Ensures 2 items fit properly
          ),
          itemCount: _controller.projects.length,
          physics: BouncingScrollPhysics(), // Smooth scrolling
          padEnds: false, // 🔥 THIS REMOVES SPACE AT THE START/END 🔥
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01), // Adjust spacing between items
              child: ProjectCard(project: _controller.projects[index]),
            );
          },
        ),
      ),
    ],
  );
}


Widget _buildFooterSection(double screenWidth) {
  double fontSize = Responsive.getFontSize(screenWidth, 16);
  double iconSize = screenWidth * 0.06; // Icons scale with screen width
  double titleSize = Responsive.getFontSize(screenWidth, 20);
  double shubaFontSize = Responsive.getFontSize(screenWidth, 28);
  double shubaHFontSize = Responsive.getFontSize(screenWidth, 36);

  return Container(
    color: Colors.black,
    padding: EdgeInsets.symmetric(
      vertical: screenWidth * 0.05, // Dynamic vertical padding
      horizontal: screenWidth * 0.08, // Adjusted for different screens
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // "Shuba" with Artistic Styled "H"
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: shubaFontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            children: [
              TextSpan(text: "S"),
              TextSpan(
                text: "H",
                style: TextStyle(
                  fontSize: shubaHFontSize,
                  fontWeight: FontWeight.w900,
                  color: Colors.redAccent, // Styled "H"
                ),
              ),
              TextSpan(text: "UBA"),
            ],
          ),
        ),

        SizedBox(height: screenWidth * 0.02),

        // Address
        Text(
          "1234, Random Street, City Name, Country",
          style: TextStyle(color: Colors.white, fontSize: fontSize),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: screenWidth * 0.015),

        // "View in Map" Button
        GestureDetector(
          onTap: () {
            // Handle map opening
          },
          child: Text(
            "View in Map",
            style: TextStyle(
              color: Colors.blueAccent,
              fontSize: fontSize,
              decoration: TextDecoration.underline,
            ),
          ),
        ),

        SizedBox(height: screenWidth * 0.03),

        // Contact Info
        Text(
          "Contact Us",
          style: TextStyle(
            color: Colors.white,
            fontSize: titleSize,
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(height: screenWidth * 0.015),

        Text(
          "+91 1234567890 || www.shubaexample.com",
          style: TextStyle(color: Colors.white, fontSize: fontSize),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: screenWidth * 0.02),

        // Report
        Text(
          "Report",
          style: TextStyle(
            color: Colors.white,
            fontSize: titleSize,
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(height: screenWidth * 0.03),

        // Social Media Icons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialIcon(Icons.call, Colors.green, iconSize, () {
              // Handle WhatsApp click
            }),
            _buildSocialIcon(Icons.camera_alt, Colors.pink, iconSize, () {
              // Handle Instagram click
            }),
            _buildSocialIcon(Icons.alternate_email, Colors.blue, iconSize, () {
              // Handle X (Twitter) click
            }),
            _buildSocialIcon(Icons.facebook, Colors.blueAccent, iconSize, () {
              // Handle Facebook click
            }),
          ],
        ),
      ],
    ),
  );
}

// Social Media Icon Widget
Widget _buildSocialIcon(IconData icon, Color color, double size, VoidCallback onTap) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10), // Even spacing
    child: GestureDetector(
      onTap: onTap,
      child: Icon(icon, color: color, size: size),
    ),
  );
}



}
