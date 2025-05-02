import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/cost_item_model.dart';
import '../models/document_model.dart';
import '../models/quick_action_model.dart';
import '../models/transaction_model.dart';
import '../models/unit_model.dart';

class ProjectController extends GetxController {

  final String projectName;
  final  unit;
  ProjectController({required this.projectName, required this.unit});
  // Unit Summary
  final totalAmount = 0.0.obs;
  final paidAmount = 0.0.obs;
  final RxList<Map<String, dynamic>> paymentSchedule =
      <Map<String, dynamic>>[].obs;
  final RxList<Map<String, String>> costSheetItems =
      <Map<String, String>>[].obs;


  final RxList<CostItem> additionalCharges = <CostItem>[].obs;
  final RxList<CostItem> constructionCharges = <CostItem>[].obs;
  final RxList<CostItem> constructionAdditionalCharges = <CostItem>[].obs;
  final RxList<CostItem> possessionCharges = <CostItem>[].obs;




  final RxDouble tA = 0.0.obs;
  final RxDouble tB = 0.0.obs;
  final RxDouble tC = 0.0.obs;
  final RxDouble tD = 0.0.obs;
  final RxDouble tE = 0.0.obs;

  void _parseTValues() {
    // Fetch the values from projectData and set them, defaulting to 0.0 if not found
    tA.value = (unit["T_A"] ?? 0.0).toDouble();
    tB.value = (unit["T_B"] ?? 0.0).toDouble();
    tC.value = (unit["T_C"] ?? 0.0).toDouble();
    tD.value = (unit["T_D"] ?? 0.0).toDouble();
    tE.value = (unit["T_E"] ?? 0.0).toDouble();

    print("📊 T-Values:");
    print("T_A: ${tA.value}");
    print("T_B: ${tB.value}");
    print("T_C: ${tC.value}");
    print("T_D: ${tD.value}");
    print("T_E: ${tE.value}");
  }





  // Facilities (5 Dummy Data)
  final documents = <DocumentModel>[
  DocumentModel(icon: Icons.description, name: 'Agreement', date: '12/2/25', fileSize: '0.3 MB'),
  DocumentModel(icon: Icons.file_copy, name: 'Blueprint', date: '15/2/25', fileSize: '1.2 MB'),
  DocumentModel(icon: Icons.picture_as_pdf, name: 'Payment Receipt', date: '20/2/25', fileSize: '0.5 MB'),
  DocumentModel(icon: Icons.article, name: 'Project Plan', date: '22/2/25', fileSize: '2.0 MB'),
  DocumentModel(icon: Icons.folder, name: 'Legal Docs', date: '28/2/25', fileSize: '0.8 MB'),
].obs;

final attentionItems = [
    UnitModel(
      unit_no: '131',
      amount: '1,32,000',
      daysLeft: '3', name: '', user: '', due: '',
    ),
    UnitModel(
      unit_no: '152',
      amount: '2,50,000',
      daysLeft: '5', name: '', user: '', due: '',
    ),
  ];


  // Transactions (5 Dummy Data)
  final transactions = <TransactionModel>[
    TransactionModel(
      icon: Icons.construction,
      name: 'Plastering',
      amount: 100000,
      details: 'Agreement - Shuba Ecovillony',
      date: '02 Mar',
    ),
    TransactionModel(
      icon: Icons.build,
      name: 'Wiring',
      amount: 50000,
      details: 'Electrical - Tower B',
      date: '10 Mar',
    ),
    TransactionModel(
      icon: Icons.plumbing,
      name: 'Plumbing',
      amount: 75000,
      details: 'Pipelines - Basement A',
      date: '15 Mar',
    ),
    TransactionModel(
      icon: Icons.home_repair_service,
      name: 'Tiles Work',
      amount: 120000,
      details: 'Flooring - Phase 1',
      date: '18 Mar',
    ),
    TransactionModel(
      icon: Icons.roofing,
      name: 'Roof Work',
      amount: 95000,
      details: 'Roof Installation - Block C',
      date: '25 Mar',
    ),
  ].obs;

  // Quick Actions (5 Dummy Data)
  final quickActions = <QuickActionModel>[
    QuickActionModel(title: 'Civil Sliver', description: 'Modification Request'),
    QuickActionModel(title: 'Paint Work', description: 'Color Customization Request'),
    QuickActionModel(title: 'Security Update', description: 'Access Card Activation'),
    QuickActionModel(title: 'Water Supply', description: 'Request for Additional Connection'),
    QuickActionModel(title: 'Electrical', description: 'Power Backup Upgrade'),
  ].obs;


  @override
  void onInit() {
    super.onInit();
    _parseUnitSummaryData();
    _parseCostItems();
    _parseTValues();
  }



  void _parseUnitSummaryData() {
    double eligibleCost = 0;
    double paid = 0;
    double balance = 0;
    eligibleCost += (unit["T_elgible"] ?? 0).toDouble();
    paid += (unit["T_review"] ?? 0).toDouble();
    balance += (unit["T_elgible_balance"] ?? 0).toDouble();

    totalAmount.value = eligibleCost;
    paidAmount.value = paid;

    print("Eligible Cost: $eligibleCost");
    print("Paid: $paid");
    print("Balance: $balance");
  }




  List<CostItem> _extractCostItems(String key) {
    List<CostItem> items = [];

    print('🔍 Extracting cost items from key: $key');
    var unitData = unit.data() as Map<String, dynamic>;
    if (unitData.containsKey(key)) {
      var list = unitData[key];
      print('📦 Raw data for $key: $list');

      if (list is List) {
        for (int i = 0; i < list.length; i++) {
          var item = list[i];
          try {
            print('➡️ Parsing item $i: $item');

            String label = item["component"]?["label"]?.toString().trim() ?? "N/A";
            double price = double.tryParse(item["TotalNetSaleValueGsT"].toString()) ?? 0.0;
            String formattedPrice = "₹ ${_formatCurrency(price)}";

            print('✅ Parsed: Label = $label | Price = $formattedPrice');

            items.add(CostItem(label, '', formattedPrice));
          } catch (e) {
            print("❌ Error parsing item $i in $key: $e");
          }
        }
      } else {
        print('⚠️ Expected a List for $key, but got: ${list.runtimeType}');
      }
    }
    //else {
      //print('❌ projectData does not contain key: $key');
    //}

    return items;
  }



  void _parseCostItems() {
    additionalCharges.value = _extractCostItems("additionalChargesCS");
    constructionCharges.value = _extractCostItems("ConstructCS");
    constructionAdditionalCharges.value = _extractCostItems("constAdditionalChargesCS");
    possessionCharges.value = _extractCostItems("PossessionAdditionalCostCS");


    print("✅ Parsed Cost Items:");
    print("Additional Charges: ${additionalCharges.length}");
    print("Construction Charges: ${constructionCharges.length}");
    print("Construction Additional Charges: ${constructionAdditionalCharges.length}");
    print("Possession Charges: ${possessionCharges.length}");
  }

  String _formatCurrency(dynamic amount) {
    if (amount is num) {
      return amount
          .toStringAsFixed(2)
          .replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (Match m) => '${m[1]},',
      );
    }
    return '0.00';
  }





}
