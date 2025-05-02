import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/cost_item_model.dart';
import '../models/payment_entry_model.dart';
import '../models/quick_action_model.dart';

// Controller
class CostSheetController extends GetxController {
  final List<CostItem> plcItems = [
    CostItem('Unit cost', '1,32,000 sqft', '₹ 1,32,000'),
    CostItem('PLC', '0 sqft', '₹ 0'),
  ];


  final List<PaymentEntry> paymentEntries = [
    PaymentEntry(
      number: '01', // Added number field
      date: '23, Apr, 2025',
      description: 'On execution of Sale Deed',
      amount: '₹ 1,32,000',
      status: 'DUE TODAY',
      statusColor: Colors.red,
    ),
  ];

  final List<QuickActionModel> quickActions = [
    QuickActionModel(
      title: 'Payment Schedule',
      description: 'View payment timeline',
    ),
    QuickActionModel(
      title: 'Make a Payment',
      description: 'Initiate new payment',
    ),
  ];






}