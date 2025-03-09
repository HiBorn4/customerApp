import 'package:flutter/material.dart';
import '../models/document_model.dart';

class DocumentItem extends StatelessWidget {
  final DocumentModel document;
  final double screenWidth;

  const DocumentItem({
    required this.document,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero), // Sharp Corners
      // margin: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.03),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Column 1: Icon
            Icon(
              document.icon,
              size: screenWidth * 0.06,
              color: Colors.blueAccent,
            ),
            SizedBox(width: screenWidth * 0.04),

            // Column 2: Name, Date, File Size
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    document.name,
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.005),
                  Text(
                    document.date,
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.005),
                  Text(
                    document.fileSize,
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),

            // Column 3: 3-Dot Menu
            PopupMenuButton<String>(
              onSelected: (value) {
                // Handle actions
              },
              itemBuilder: (context) => [
                PopupMenuItem(value: "Open", child: Text("Open")),
                PopupMenuItem(value: "Download", child: Text("Download")),
                PopupMenuItem(value: "Delete", child: Text("Delete")),
              ],
              child: Icon(Icons.more_vert),
            ),
          ],
        ),
      ),
    );
  }
}
