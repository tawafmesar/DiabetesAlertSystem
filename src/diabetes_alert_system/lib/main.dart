import 'package:diabetes_alert_system/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:is_first_run/is_first_run.dart';
import 'bindings/intialbindings.dart';
import 'controller/alarm/alarm.dart';
import 'controller/alarm/notification.dart';
import 'core/constant/routes.dart';
import 'core/localization/changelocal.dart';
import 'core/localization/translation.dart';
import 'core/services/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();

  initializeNotifications();// Initialize notifications

  bool firstCall = await IsFirstRun.isFirstCall();
  if (firstCall) {
    // Initialize the app by creating default alarms etc.
    listOfSavedAlarms = await initAlarms();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    LocaleController controller = Get.put(LocaleController());

    return GetMaterialApp(
      title: 'Diabetes Alert System',
      translations: MyTranslation(),
      debugShowCheckedModeBanner: false,
      locale: controller.language,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialBinding: initialBindings(),
      initialRoute: AppRoute.splash,
      getPages: routes,

    );
  }
}
