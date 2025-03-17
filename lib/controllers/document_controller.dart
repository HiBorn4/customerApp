// import 'package:get/get.dart';

// class DocumentUpload {
//   final String name;
//   final String date;
//   final String size;
//   final String thumbnailPath;

//   DocumentUpload({
//     required this.name,
//     required this.date,
//     required this.size,
//     required this.thumbnailPath,
//   });
// }

// class Document {
//   final String name;
//   final String date;
//   final String size;
//   final String iconPath;

//   Document({
//     required this.name,
//     required this.date,
//     required this.size,
//     required this.iconPath,
//   });
// }

// class DocumentsController extends GetxController {
//   final recentUploads = <DocumentUpload>[].obs;
//   final documents = <Document>[].obs;
//   final sortValue = 'Latest'.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     _loadInitialData();
//   }

//   void _loadInitialData() {
//     recentUploads.assignAll([
//       DocumentUpload(
//         name: 'Land Agreement',
//         date: '12/12/2025',
//         size: '0.300 kb',
//         thumbnailPath: 'assets/images/doc_thumbnail1.jpg',
//       ),
//     ]);

//     documents.assignAll([
//       Document(
//         name: 'Agreement',
//         date: '28/12/2025',
//         size: '0.3 mb',
//         iconPath: 'assets/icons/document.svg',
//       ),
//     ]);
//   }

//   void uploadDocument() async {
//     Get.snackbar(
//       'Upload Document',
//       'File picker implementation needed',
//       snackPosition: SnackPosition.BOTTOM,
//     );
//   }

//   void sortDocuments(String value) {
//     sortValue.value = value;
//     // Add actual sorting logic here
//   }

//   void showDocumentOptions(Document document) {
//     Get.bottomSheet(
//       Container(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ListTile(
//               leading: Icon(Icons.download),
//               title: Text('Download'),
//               onTap: () {
//                 Get.back();
//                 downloadDocument(document);
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.delete),
//               title: Text('Delete'),
//               onTap: () {
//                 Get.back();
//                 deleteDocument(document);
//               },
//             ),
//           ],
//         ),
//       ),
//       backgroundColor: Colors.white,
//     );
//   }

//   void downloadDocument(Document document) {
//     Get.snackbar(
//       'Download',
//       'Downloading ${document.name}...',
//       snackPosition: SnackPosition.BOTTOM,
//     );
//   }

//   void deleteDocument(Document document) {
//     documents.remove(document);
//   }
// }