import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/auth_controller.dart';
import '../controller/services_controller.dart';
import '../data/api/api_client.dart';
import '../data/repository/auth_repo.dart';
import '../data/repository/services_repo.dart';

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();


  Get.lazyPut(() => ServicesController());
}
