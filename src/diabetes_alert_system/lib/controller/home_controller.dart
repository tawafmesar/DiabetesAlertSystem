import 'dart:async';
import 'package:get/get.dart';
import '../core/class/statusrequest.dart';
import '../core/functions/handingdatacontroller.dart';
import '../core/services/services.dart';
import '../data/datasource/model/home_statics_model.dart';
import '../core/constant/routes.dart';
import '../data/datasource/remote/home_statics_data.dart';

abstract class HomeController extends GetxController {
  getHomeStatics();
}

class HomeControllerImp extends HomeController {
  String? users_id;
  String? users_name;
  String? users_email;




  // Data source
  HomeStaticsData homeStaticsData = HomeStaticsData(Get.find());

  // State
  late StatusRequest statusRequest;
  MyServices myServices = Get.find();

  HomeStatics? data;


  @override
  void onInit() {
    super.onInit();
    users_id = myServices.sharedPreferences.getString("id");

    users_name = myServices.sharedPreferences.getString("username");
    users_email = myServices.sharedPreferences.getString("email");

    if (users_id != null) {
      getHomeStatics();
    } else {
      Get.offNamed(AppRoute.login);
      statusRequest = StatusRequest.failure;
      update();
    }
  }




 Future<void> _navigateTobackScreen(String title, String middleText) async {
    Get.defaultDialog(
      title: title,
      middleText: middleText,
    );
    await Future.delayed(const Duration(seconds: 3));
    // close dialog and bottom sheet
    if (Get.isDialogOpen ?? false) Get.back();
    if (Get.isBottomSheetOpen ?? false) Get.back();
  }


  @override
  getHomeStatics() async {
    statusRequest = StatusRequest.loading;
    update();

    try {
      var response = await homeStaticsData.postdata(users_id!);
      print("=============================== Controller Raw Response: $response ");

      statusRequest = handlingData(response);
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == "success") {
          data = HomeStatics.fromJson(response['data']);
          print("Statistics Data: $data");

        } else {
          statusRequest = StatusRequest.failure;
          print("API returned failure status.");
        }
      } else if (statusRequest == StatusRequest.serverfailure) {
        print("Server failure encountered.");
      } else if (statusRequest == StatusRequest.failure) {
        print("General failure encountered.");
      }
    } catch (e, stacktrace) {
      print("Error in getMedications: $e");
      print("Stacktrace: $stacktrace");
      statusRequest = StatusRequest.serverfailure;
    }


    update();
  }

  @override
  void dispose() {

    super.dispose();
  }
}