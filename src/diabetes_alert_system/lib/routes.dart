import 'package:diabetes_alert_system/view/screen/Metricsscreen.dart';
import 'package:diabetes_alert_system/view/screen/alarm/homepage_alarm_overview.dart';
import 'package:diabetes_alert_system/view/screen/auth/login.dart';
import 'package:diabetes_alert_system/view/screen/auth/forgetpassword/forgetpassword.dart';
import 'package:diabetes_alert_system/view/screen/auth/forgetpassword/resetpassword.dart';
import 'package:diabetes_alert_system/view/screen/auth/forgetpassword/success_resetpassword.dart';
import 'package:diabetes_alert_system/view/screen/auth/forgetpassword/verifycode.dart';
import 'package:diabetes_alert_system/view/screen/auth/signup.dart';
import 'package:diabetes_alert_system/view/screen/auth/success_signup.dart';
import 'package:diabetes_alert_system/view/screen/auth/verifycodesignup.dart';
import 'package:diabetes_alert_system/view/screen/home.dart';
import 'package:diabetes_alert_system/view/screen/spalsh_screen.dart';
import 'package:diabetes_alert_system/view/screen/test_screen.dart';

import 'core/constant/routes.dart';
import 'package:get/get.dart';
import 'core/middleware/mymiddleware.dart';


List<GetPage<dynamic>>? routes = [
  // Changed initial route to go to Home via Middleware which now forces Home
  GetPage(name: "/",
      page: () =>  const Home() , middlewares: [
        MyMiddleWare()
      ]),
  GetPage(name: AppRoute.splash, page: () =>  const SplashScreen()),
  // Keep login pages but they won't be used
  GetPage(name: AppRoute.login, page: () => const Login()),
  GetPage(name: AppRoute.signUp, page: () => const SignUp()),
  GetPage(name: AppRoute.forgetPassword, page: () => const ForgetPassword()),
  GetPage(name: AppRoute.verfiyCode, page: () => const VerfiyCode()),
  GetPage(name: AppRoute.resetPassword, page: () => const ResetPassword()),
  GetPage(name: AppRoute.successResetpassword, page: () => const SuccessResetPassword()),
  GetPage(name: AppRoute.successSignUp, page: () => const SuccessSignUp()),
  GetPage(name: AppRoute.verfiyCodeSignUp, page: () => const VerfiyCodeSignUp()),
  GetPage(name: AppRoute.test, page: () => const Test()),
  GetPage(name: AppRoute.home, page: () => const Home()),
  GetPage(name: AppRoute.metricsscreen, page: () => const MetricsScreen()),
  GetPage(name: AppRoute.Alarmscreen, page: () => const HomePageAlarmOverview(title: 'Alarm',) ),

];