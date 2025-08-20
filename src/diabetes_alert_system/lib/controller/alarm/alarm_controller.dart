import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../core/class/statusrequest.dart';
import '../../core/constant/routes.dart';
import '../../core/functions/handingdatacontroller.dart';
import '../../core/services/services.dart';
import '../../data/datasource/model/MedicationModel.dart';
import '../../data/datasource/remote/alarms_data.dart';
import '../../data/datasource/remote/medication_data.dart';


abstract class AlarmController extends GetxController {
}

class AlarmControllerImp extends AlarmController {
  String? users_id;
  String? alarm_id;

  MedicationData medicationData = MedicationData(Get.find());
  late TextEditingController Medication_id;



  GlobalKey<FormState> formstate = GlobalKey<FormState>();


  List<MedicationModel> data = [];
  List<String> Medicationdata = [];

  late StatusRequest statusRequest;

  MyServices myServices = Get.find();

  @override
  void onInit() {
    super.onInit();

    Medication_id = TextEditingController();



    users_id = myServices.sharedPreferences.getString("id");
    print("Retrieved users_id: $users_id");

    if (users_id != null) {
      getMedications();

    } else {
      print("users_id is null. Redirecting to login.");
      Get.offNamed(AppRoute.login);
      statusRequest = StatusRequest.failure;
      update();
    }


  }





  @override
  void dispose() {

    Medication_id.dispose();

    super.dispose();

  }


  AlarmsData alarmsData = AlarmsData(Get.find());


  Future<String?> AddAlarms(
      String isActive,
      String isRinging,
      String nameOfAlarm,
      String alarmTimeHour,
      String alarmTimeMinute,
      String alarmDate,
      String isRecurrent,
      String weekdayRecurrence,
      String challengeMode,
      ) async {
    statusRequest = StatusRequest.loading;
    update();

    try {
      if (alarmsData == null) {
        print("alarmsData is not initialized!");
        statusRequest = StatusRequest.failure;
        update();
        return null;
      }

      // Print statements for debugging
      print("isActive: $isActive");
      print("isRinging: $isRinging");
      print("nameOfAlarm: $nameOfAlarm");
      print("alarmDate: $alarmDate");
      print("isRecurrent: $isRecurrent");
      print("weekdayRecurrence: $weekdayRecurrence");
      print("challengeMode: $challengeMode");
      print("alarmTimeHour: $alarmTimeHour");
      print("alarmTimeMinute: $alarmTimeMinute");

      var response = await alarmsData.addAlarmsData(
        isActive: isActive,
        isRinging: isRinging,
        nameOfAlarm: nameOfAlarm,
        alarmTimeHour: alarmTimeHour,
        alarmTimeMinute: alarmTimeMinute,
        alarmDate: alarmDate,
        isRecurrent: isRecurrent,
        weekdayRecurrence: weekdayRecurrence,
        challengeMode: challengeMode,
        usersId: users_id!,
        medicationsId: Medication_id.text,
      );
      print("Controller Response: $response");

      if (response == null || response['status'] == null) {
        print("Invalid response structure");
        statusRequest = StatusRequest.failure;
        update();
        return null;
      }

      statusRequest = handlingData(response);
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == "success") {
          alarm_id = response['alarm_id'];
          print("Alarm ID: $alarm_id");

          _navigateTobackScreen(
            "Success",
            "The Alarm has been added successfully.",
          );
          return alarm_id; // Return the alarm_id
        } else {
          _navigateTobackScreen(
            "Notification",
            "Sorry, your alarm could not be added.",
          );
          statusRequest = StatusRequest.failure;
          return null;
        }
      }
    } catch (e) {
      print("Error while adding alarm: $e");
      statusRequest = StatusRequest.serverfailure;
      return null;
    }

    update();
    return null;
  }





  Map<String, String> MedicationsMap = {};


  @override
  getMedications() async {
    MedicationsMap.clear();
    Medicationdata.clear();

    statusRequest = StatusRequest.loading;
    update();

    try {
      var response = await medicationData.postdata(users_id!);
      print("=============================== Controller Raw Response: $response ");

      statusRequest = handlingData(response);
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == "success") {
          if (response['data'] is List) {
            data.addAll(response['data'].map<MedicationModel>((e) => MedicationModel.fromJson(e)).toList());
            print("Medications Data: $data");
            List<dynamic> responsedata = response['data'];

            for (var item in responsedata) {
              String medication_id = item['medication_id']?.toString() ?? 'Unknown ID';
              String medication_name = item['medication_name'] ?? 'Unknown Name';

              Medicationdata.add(medication_name);

              if (medication_id != 'Unknown ID') {
                MedicationsMap[medication_name] = medication_id;
              }

            }
            print("data......................................");
            print(Medicationdata);

          } else {
            print("Data is not a list.");
            statusRequest = StatusRequest.failure;
          }
        } else {
          statusRequest = StatusRequest.failure;
          print("API returned failure status.");
        }
      } else if (statusRequest == StatusRequest.serverfailure) {
        print("Server failure encountered.");

      } else if (statusRequest == StatusRequest.failure) {
        // Handle other failures
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
  remove(String id) async {
    print("=============================== id $id ");
    print(id);
    statusRequest = StatusRequest.loading;
    var response = await alarmsData.removedata(id);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        _navigateTobackScreen("Success" ,"The Alarm was Deleted successfully" );
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

}
