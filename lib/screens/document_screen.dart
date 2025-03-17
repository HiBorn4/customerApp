import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DocumentsScreen extends StatelessWidget {
  final DocumentsController controller = Get.put(DocumentsController());

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Column(
          children: [
            Text(
              'Documents',
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Shuba Ecostone - 131',
              style: TextStyle(
                fontSize: screenWidth * 0.03,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUploadSection(context),
            SizedBox(height: screenHeight * 0.04),
            _buildRecentUploadsSection(context),
            SizedBox(height: screenHeight * 0.04),
            _buildDocumentsSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Upload your Documents Effortlessly',
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenWidth * 0.02),
                Text(
                  'Secure, fast, and hassle-free Document uploads',
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: screenWidth * 0.04),
          ElevatedButton(
            onPressed: controller.uploadDocument,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenWidth * 0.03,
              ),
            ),
            child: Text(
              'Upload',
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.035,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentUploadsSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'RECENT UPLOADS',
          style: TextStyle(
            fontSize: screenWidth * 0.035,
            fontWeight: FontWeight.w600,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: screenWidth * 0.03),
        SizedBox(
          height: screenWidth * 0.4,
          child: Obx(() => ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: controller.recentUploads.length,
            separatorBuilder: (_, __) => SizedBox(width: screenWidth * 0.04),
            itemBuilder: (context, index) {
              final upload = controller.recentUploads[index];
              return _RecentUploadItem(upload: upload);
            },
          )),
        ),
      ],
    );
  }

  Widget _buildDocumentsSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'DOCUMENTS',
              style: TextStyle(
                fontSize: screenWidth * 0.035,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
            Obx(() => DropdownButton<String>(
              value: controller.sortValue.value,
              items: ['Latest', 'Oldest'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) => controller.sortDocuments(value!),
            )),
          ],
        ),
        SizedBox(height: screenWidth * 0.03),
        Obx(() => ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.documents.length,
          separatorBuilder: (_, __) => SizedBox(height: screenWidth * 0.04),
          itemBuilder: (context, index) {
            final document = controller.documents[index];
            return _DocumentItem(document: document);
          },
        )),
      ],
    );
  }
}

class _RecentUploadItem extends StatelessWidget {
  final DocumentUpload upload;

  const _RecentUploadItem({required this.upload});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.35,
      height: screenWidth*0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              upload.thumbnailPath,
              width: screenWidth * 0.35,
              height: screenWidth * 0.25,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: screenWidth * 0.02),
          Text(
            upload.name,
            style: TextStyle(
              fontSize: screenWidth * 0.035,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: screenWidth * 0.01),
          Text(
            upload.date,
            style: TextStyle(
              fontSize: screenWidth * 0.03,
              color: Colors.grey[600],
            ),
          ),
          Text(
            upload.size,
            style: TextStyle(
              fontSize: screenWidth * 0.03,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

class _DocumentItem extends StatelessWidget {
  final Document document;
  // final DocumentsController controller = Get.find<DocumentsController>();

  const _DocumentItem({required this.document});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Row(
      children: [
        SvgPicture.asset(
          document.iconPath,
          width: screenWidth * 0.06,
        ),
        SizedBox(width: screenWidth * 0.04),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                document.name,
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: screenWidth * 0.01),
              Text(
                '${document.date} • ${document.size}',
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        // IconButton(
          // icon: Icon(Icons.more_vert, size: screenWidth * 0.06),
          // onPressed: () => controller.showDocumentOptions(document),
        // ),
      ],
    );
  }
}

class DocumentUpload {
  final String name;
  final String date;
  final String size;
  final String thumbnailPath;

  DocumentUpload({
    required this.name,
    required this.date,
    required this.size,
    required this.thumbnailPath,
  });
}

class Document {
  final String name;
  final String date;
  final String size;
  final String iconPath;

  Document({
    required this.name,
    required this.date,
    required this.size,
    required this.iconPath,
  });
}

class DocumentsController extends GetxController {
  final recentUploads = <DocumentUpload>[].obs;
  final documents = <Document>[].obs;
  final sortValue = 'Latest'.obs;

  @override
  void onInit() {
    super.onInit();
    _loadInitialData();
  }

  void _loadInitialData() {
    recentUploads.assignAll([
      DocumentUpload(
        name: 'Land Agreement',
        date: '12/12/2025',
        size: '0.300 kb',
        thumbnailPath: 'assets/land_agreement.png',
      ),
    ]);

    documents.assignAll([
      Document(
        name: 'Agreement',
        date: '28/12/2025',
        size: '0.3 mb',
        iconPath: 'assets/land_agreement.png',
      ),
    ]);
  }

  void uploadDocument() async {
    Get.snackbar(
      'Upload Document',
      'File picker implementation needed',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void sortDocuments(String value) {
    sortValue.value = value;
    // Add actual sorting logic here
  }

  void showDocumentOptions(Document document) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.download),
              title: const Text('Download'),
              onTap: () {
                Get.back();
                downloadDocument(document);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Delete'),
              onTap: () {
                Get.back();
                deleteDocument(document);
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  void downloadDocument(Document document) {
    Get.snackbar(
      'Download',
      'Downloading ${document.name}...',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void deleteDocument(Document document) {
    documents.remove(document);
  }
}