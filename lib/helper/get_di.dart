import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/services_controller.dart';

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut(() => ExpenseController());
}
