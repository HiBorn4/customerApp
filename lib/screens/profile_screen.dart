// import 'package:customerapp/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/responsive.dart';

class ProfileController extends GetxController {
  final socialMediaLinks =
      [
        SocialMedia(icon: Icons.call, url: 'https://wa.me/919123456780'),
        SocialMedia(icon: Icons.camera, url: 'https://instagram.com'),
        SocialMedia(icon: Icons.book, url: 'https://facebook.com'),
        SocialMedia(
          icon: Icons.one_x_mobiledata_outlined,
          url: 'https://twitter.com',
        ),
      ].obs;
}

class ProfileScreen extends StatelessWidget {
  final ProfileController _controller = Get.put(ProfileController());
  final String address = "#1, HSR Sector 1, Bangalore, Karnataka-560049";

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
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

            // Main content
            Container(
              color: Colors.grey[100],
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileSection(screenWidth, screenHeight),
                  _buildSectionTitle('ACCOUNT', screenHeight),
                  _buildAccountOptions(screenWidth, screenHeight),
                ],
              ),
            ),

            _buildFooterSection(screenWidth),
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
        onPressed: () {},
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Profile',
            style: GoogleFonts.outfit(
              color: Colors.black,
              fontSize: Responsive.getFontSize(screenWidth, 24),
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'Shuba Ecostone - 131',
            style: GoogleFonts.outfit(
              color: Color(0xff606062),
              fontSize: Responsive.getFontSize(screenWidth, 16),
              fontWeight: FontWeight.w400,
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
                        fontSize: Responsive.getFontSize(screenWidth, 18),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Joined on 29, Nov 2050',
                      style: GoogleFonts.outfit(
                        fontSize: Responsive.getFontSize(screenWidth, 14),
                        color: Colors.grey,
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

  Widget _buildSectionTitle(String title, double screenHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
      child: Text(
        title,
        style: GoogleFonts.outfit(
          fontSize: Responsive.getFontSize(
            MediaQuery.of(Get.context!).size.width,
            14,
          ),
          fontWeight: FontWeight.w500,
          color: Color(0xff656567),
        ),
      ),
    );
  }

  Widget _buildAccountOptions(double screenWidth, double screenHeight) {
    final options = [
      {'title': 'Change Password', 'desc': 'Update your account password'},
      {'title': 'Refer', 'desc': 'Invite friends and earn rewards'},
      {'title': 'Report', 'desc': 'Submit issues or feedback'},
      {'title': 'Logout', 'desc': 'Sign out from your account'},
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: options.length,
      itemBuilder:
          (context, index) => Card(
            child: ListTile(
              title: Text(
                options[index]['title']!,
                style: GoogleFonts.outfit(
                  fontSize: Responsive.getFontSize(screenWidth, 16),
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                options[index]['desc']!,
                style: GoogleFonts.outfit(
                  fontSize: Responsive.getFontSize(screenWidth, 14),
                  color: Colors.grey,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: screenHeight * 0.02,
              ),
              onTap: () => _handleAccountOption(options[index]['title']!),
            ),
          ),
    );
  }

  Widget _buildFooterSection(double screenWidth) {
    double fontSize = Responsive.getFontSize(screenWidth, 16);
    double iconSize = screenWidth * 0.075;
    double titleSize = Responsive.getFontSize(screenWidth, 20);
    double shubaFontSize = Responsive.getFontSize(screenWidth, 28);

    return Container(
      color: Color(0xff191B1C),
      padding: EdgeInsets.symmetric(
        vertical: screenWidth * 0.05,
        horizontal: screenWidth * 0.08,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // "Shuba" Logo
          Center(
            child: Image.asset(
              'assets/shubha.png',
              width: shubaFontSize * 6,
              fit: BoxFit.contain,
            ),
          ),

          SizedBox(height: screenWidth * 0.03),
          Text(
            "address",
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontSize: titleSize,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 6),

          // Address
          Text(
            "#1,HSR Sector 1, Bangalore, Karnataka-560049",
            style: GoogleFonts.outfit(
              color: Color(0xff737576),
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: screenWidth * 0.03),

          // "View in Map" Button
          GestureDetector(
            onTap: () => _openMap(address),
            child: Text(
              "View in Map",
              style: GoogleFonts.outfit(
                color: Color(0xff737576),
                fontSize: fontSize,
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.underline,
              ),
            ),
          ),

          SizedBox(height: screenWidth * 0.06),

          // Contact Info
          Text(
            "Contact Us",
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontSize: titleSize,
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(height: screenWidth * 0.015),

          Text(
            "+91 1234567890 || www.shubaexample.com",
            style: GoogleFonts.outfit(
              color: Color(0xff737576),
              fontSize: fontSize,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: screenWidth * 0.07),

          Text(
            "our website",
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontSize: titleSize,
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(height: screenWidth * 0.07),

          // Report
          Text(
            "Report",
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontSize: titleSize,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: screenWidth * 0.07),

          Center(
            child: Text(
              "connect with us",
              style: GoogleFonts.outfit(
                color: Color(0xff737576),
                fontSize: titleSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          SizedBox(height: screenWidth * 0.05),

          // Social Media Icons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialIcon('assets/whatsapp.png', iconSize, () {
                _launchURL('https://wa.me/919123456780');
              }),
              _buildSocialIcon('assets/insta.png', iconSize, () {
                _launchURL('https://instagram.com');
              }),
              _buildSocialIcon('assets/x.png', iconSize, () {
                _launchURL('https://twitter.com');
              }),
              _buildSocialIcon('assets/fb.png', iconSize, () {
                _launchURL('https://facebook.com');
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(String assetPath, double size, VoidCallback onTap) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: onTap,
        child: Image.asset(
          assetPath,
          width: size,
          height: size,
          fit: BoxFit.contain,
          color: Colors.white,
        ),
      ),
    );
  }

  void _handleAccountOption(String option) {
    switch (option) {
      case 'Change Password':
        Get.toNamed('/change-password');
        break;
      case 'Logout':
        _confirmLogout();
        break;
      // Add other cases
    }
  }

  void _confirmLogout() {
    Get.defaultDialog(
      title: 'Logout',
      content: Text('Are you sure you want to logout?'),
      confirm: TextButton(
        onPressed: () => Get.offAllNamed('/login'),
        child: Text('Yes'),
      ),
      cancel: TextButton(onPressed: () => Get.back(), child: Text('No')),
    );
  }

  Future<void> _openMap(String address) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$address';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}

class SocialMedia {
  final IconData icon;
  final String url;

  SocialMedia({required this.icon, required this.url});
}
