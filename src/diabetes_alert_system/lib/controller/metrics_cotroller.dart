import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../core/class/statusrequest.dart';
import '../core/constant/imageasset.dart';
import '../core/functions/handingdatacontroller.dart';
import '../core/services/services.dart';
import '../data/datasource/model/MetricsModel.dart';
import '../data/datasource/remote/metrics_data.dart';
import '../core/constant/routes.dart';

abstract class MetricsController extends GetxController {
  getMetrics();
}
class MetricsControllerImp extends MetricsController {
  String? users_id;


  late TextEditingController metric_type;
  late TextEditingController value1;
  late TextEditingController value2;


  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  MetricsData metricsData = MetricsData(Get.find());

  List<MetricsModel> data = [];
  late StatusRequest statusRequest;
  MyServices myServices = Get.find();
  @override
  void onInit() {
    super.onInit();
    metric_type = TextEditingController() ;
    value1 = TextEditingController() ;
    value2 = TextEditingController() ;



    users_id = myServices.sharedPreferences.getString("id");
    print("Retrieved users_id: $users_id");
    if (users_id != null) {
      getMetrics();
    } else {
      print("users_id is null. Redirecting to login.");
      Get.offNamed(AppRoute.login);
      statusRequest = StatusRequest.failure;
      update();
    }
  }
  @override
  getMetrics() async {
    data.clear();
    statusRequest = StatusRequest.loading;
    update();
    try {
      var response = await metricsData.postdata(users_id!);
      print("=============================== Controller Raw Response: $response ");
      statusRequest = handlingData(response);
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == "success") {
          if (response['data'] is List) {
            data.addAll(response['data'].map<MetricsModel>((e) => MetricsModel.fromJson(e)).toList());
            print("Metrics Data: $data");
          } else {
            print("Data is not a list.");
            statusRequest = StatusRequest.failure;
          }
        } else {
          statusRequest = StatusRequest.failure;
          print("API returned failure status.");
        }
      } else if (statusRequest == StatusRequest.serverfailure) {
        // Handle server failure specifically
        print("Server failure encountered.");
        // Optionally, you can show a snackbar or dialog to inform the user
      } else if (statusRequest == StatusRequest.failure) {
        // Handle other failures
        print("General failure encountered.");
        // Optionally, inform the user
      }
    } catch (e, stacktrace) {
      print("Error in getMetrics: $e");
      print("Stacktrace: $stacktrace");
      statusRequest = StatusRequest.serverfailure;
    }
    update();
  }

  @override
  AddMetric() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      // Log user inputs
      print("=============================== users_id: $users_id ");
      print("=============================== metric_type: ${metric_type.text} ");
      print("=============================== value1: ${value1.text} ");
      print("=============================== value2: ${value2.text} ");

      try {
        var response = await metricsData.addmetricsdata(
          users_id!,
          metric_type.text,
          value1.text,
          value2.text,
        );
        print("=============================== Controller Response: $response ");

        statusRequest = handlingData(response);
        if (statusRequest == StatusRequest.success) {
          if (response['status'] == "success") {
            _navigateTobackScreen(
              "Success",
              "The Metric has been added successfully.",
            );

            // Clear the controllers instead of disposing them
            metric_type.clear();
            value1.clear();
            value2.clear();

            await getMetrics();
          } else {
            _navigateTobackScreen(
              "Notification",
              "Sorry, your Metric could not be added.",
            );
            statusRequest = StatusRequest.failure;
          }
        }
      } catch (e) {
        print("Error while adding Metric: $e");
        statusRequest = StatusRequest.serverfailure;
      }

      update();
    }
  }



  String getImageByMetricType(String metricType) {
    switch (metricType.toLowerCase()) {
      case "blood pressure":
        return AppImageAsset.BloodPressure;
      case "heart rate":
        return AppImageAsset.HeartRate;
      case "blood sugar":
        return AppImageAsset.BloodSugar;
      default:
        return AppImageAsset.DefaultImage;
    }
  }
  String getMetricStatus(String metricType, String value1, String? value2) {
    if (metricType.toLowerCase() == "blood pressure") {
      int systolic = int.tryParse(value1) ?? 0;
      int diastolic = int.tryParse(value2 ?? '0') ?? 0;
      if (systolic < 90 || diastolic < 60) return 'Low';
      if (systolic > 120 || diastolic > 80) return 'High';
      return 'Normal';
    } else if (metricType.toLowerCase() == "heart rate") {
      int bpm = int.tryParse(value1) ?? 0;
      if (bpm < 60) return 'Low';
      if (bpm > 100) return 'High';
      return 'Normal';
    } else if (metricType.toLowerCase() == "blood sugar") {
      int glucose = int.tryParse(value1) ?? 0;
      return glucose < 70 ? 'Low' : glucose > 140 ? 'High' : 'Normal';
    }
    return 'Unknown';
  }
  @override
  remove(String id) async {
    print("=============================== id $id ");
    print(id);
    statusRequest = StatusRequest.loading;
    var response = await metricsData.removedata(id);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        getMetrics();
        _navigateTobackScreen("Success" ,"The Metric was Deleted successfully" );
        update();
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }
  Future<void> _navigateTobackScreen(String title, String middleText) async {
    Get.defaultDialog(
      title: title,
      middleText:  middleText,
    );
    await Future.delayed(Duration(seconds: 3));
    Get.back();
    Get.back();
  }
  @override
  void dispose() {
    metric_type.dispose();
    value1.dispose();
    value2.dispose();

    super.dispose();

  }

}