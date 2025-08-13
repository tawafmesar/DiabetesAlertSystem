import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../core/class/statusrequest.dart';
import '../core/functions/handingdatacontroller.dart';
import '../core/services/services.dart';
import '../data/datasource/model/MedicationModel.dart';
import '../data/datasource/remote/medication_data.dart';
import '../core/constant/routes.dart'; // Ensure AppRoute is defined
abstract class MedicationController extends GetxController {
  getMedications();
}
class MedicationControllerImp extends MedicationController {
  String? users_id;


  late TextEditingController name;
  late TextEditingController classs;
  late TextEditingController type;
  late TextEditingController dosage;
  late TextEditingController frequency;





  MedicationData medicationData = MedicationData(Get.find());

  List<MedicationModel> data = [];

  late StatusRequest statusRequest;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  MyServices myServices = Get.find();

  @override
  void onInit() {
    super.onInit();


    name = TextEditingController() ;
    classs = TextEditingController() ;
    type = TextEditingController() ;
    dosage = TextEditingController() ;
    frequency = TextEditingController() ;



    users_id = myServices.sharedPreferences.getString("id");
    print("Retrieved users_id: $users_id");

    if (users_id != null) {
      getMedications();
    } else {
      // Handle the scenario where users_id is null
      print("users_id is null. Redirecting to login.");
      Get.offNamed(AppRoute.login);
      // Optionally, set the status to failure
      statusRequest = StatusRequest.failure;
      update();
    }
  }
  @override
  getMedications() async {
    data.clear();
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
      print("Error in getMedications: $e");
      print("Stacktrace: $stacktrace");
      statusRequest = StatusRequest.serverfailure;
    }
    update();
  }

  @override
  AddMedicatio() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      // Log user inputs correctly
      print("=============================== users_id: $users_id ");
      print("=============================== name: ${name.text} ");
      print("=============================== classs: ${classs.text} ");
      print("=============================== type: ${type.text} ");
      print("=============================== dosage: ${dosage.text} ");
      print("=============================== frequency: ${frequency.text} ");

      try {
        var response = await medicationData.addmedicationdata(
          users_id!,
          name.text,
          classs.text,
          type.text,
          dosage.text,
          frequency.text,
        );
        print("=============================== Controller Response: $response ");

        statusRequest = handlingData(response);
        if (statusRequest == StatusRequest.success) {
          if (response['status'] == "success") {
            _navigateTobackScreen(
              "Success",
              "The Medication has been added successfully.",
            );

            name.clear();
            classs.clear();
            type.clear();
            dosage.clear();
            frequency.clear();
            await getMedications();

          } else {
            _navigateTobackScreen(
              "Notification",
              "Sorry, your medication could not be added.",
            );

            statusRequest = StatusRequest.failure;
          }
        }
      } catch (e) {
        print("Error while adding medication: $e");
        statusRequest = StatusRequest.serverfailure;
      }

      update();
    }
  }

  @override
  remove(String id) async {
    print("=============================== id $id ");
    print(id);
    statusRequest = StatusRequest.loading;
    var response = await medicationData.removedata(id);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        getMedications();
        _navigateTobackScreen("Success" ,"The Medication was Deleted successfully" );
        update();
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }
  Future<void> updatedata() async {
    getMedications();
    _navigateTobackScreen("Success" ,"The Medication list was updated successfully");
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



    name.dispose();
    classs.dispose();
    type.dispose();
    dosage.dispose();
    frequency.dispose();
    super.dispose();

  }
}