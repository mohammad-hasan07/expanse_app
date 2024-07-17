
import 'package:expanse_app/theme/colors.dart';
import 'package:expanse_app/view/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:hive_flutter/hive_flutter.dart';
import 'controller/notification_controller.dart';
import 'data/model/response/expense_model.dart';
import 'helper/get_di.dart';

Future<void> main() async {
  await init();
  await Hive.initFlutter();
  Hive.registerAdapter(ExpenseAdapter());
  await Hive.openBox<Expense>('expenses');
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));
  requestAndroidPermissions();// Use the full time zone identifier
  NotificationService.initialize();
  NotificationService.showDailyNotification();
  runApp(const MyApp());
}

Future<void> requestAndroidPermissions() async {
  if (await Permission.notification.isGranted) {
    // Permission already granted
  } else {
    // Request permission
    await Permission.notification.request();
  }
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Expanse management app',
debugShowCheckedModeBanner: false,
      theme: themeData,
      home:  const SplashScreen()
      
    );
  }
}

