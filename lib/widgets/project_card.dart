import 'package:flutter/material.dart';
import '../models/project_model.dart';

class ProjectCard extends StatelessWidget {
  final ProjectModel project;

  const ProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth*0.2, // Ensures full width
      height: screenHeight * 0.3, 
      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01, horizontal: screenWidth * 0.02),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      child: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              project.image,
              fit: BoxFit.cover, // Ensures the image covers the full width
            ),
          ),

          // Bottom Gradient Overlay with all text at bottom-left
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(screenWidth * 0.03),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black54, Colors.transparent],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // Ensures no extra space
                children: [
                  // Project Name
                  Text(
                    project.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  SizedBox(height: screenHeight * 0.005),

                  // Location with Icon
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.white, size: screenWidth * 0.05),
                      SizedBox(width: screenWidth * 0.01),
                      Expanded(
                        child: Text(
                          project.location,
                          style: TextStyle(color: Colors.white70, fontSize: screenWidth * 0.04),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: screenHeight * 0.005),

                  // Price
                  Text(
                    project.price,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.045,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
