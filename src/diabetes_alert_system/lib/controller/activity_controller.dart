import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../core/class/statusrequest.dart';
import '../core/functions/handingdatacontroller.dart';
import '../core/services/services.dart';
import '../data/datasource/remote/activity_data.dart';
import '../data/datasource/model/activity_model.dart';
import '../core/constant/routes.dart';

abstract class ActivityController extends GetxController {
  getActivity();
}

class ActivityControllerImp extends ActivityController {
  String? users_id;

  // Form
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  // Controllers
  late TextEditingController categoryController;
  late TextEditingController caloriesController;

  // Data source
  ActivityData activityData = ActivityData(Get.find());

  // State
  late StatusRequest statusRequest;
  MyServices myServices = Get.find();
  List<ActivityModel> data = [];
  // Persisted weight
  double userWeight = 70.0;

  // Selected activity type
  String selectedActivityType = "";
  String selectedActivityImage = "";
  String selectedCategory = "";

  // Duration in seconds
  int durationSeconds = 0;

  // MET mapping (used to calculate calories)
  final Map<String, double> _metValues = {
    "Walking": 3.5,
    "Running": 9.8,
    "Cycling": 7.5,
    "Swimming": 8.0,
    "Jump Rope": 12.3,
    "Pushups": 8.0,
    "Situps": 6.0,
    "Squats": 5.0,
    "Squat jumps": 10.0,
    "Lunges": 6.0,
    "Plank": 3.0,
    "Burpees": 10.0,
    "Dips": 6.0,
    "clapping_pushups": 9.0,
    "Bicycle Crunch": 5.5,
    "Leg Raises": 4.5,
    "Mountain Climbers": 8.0,
    "Russian Twists": 4.5,
    "Side Plank": 3.5,
    "Other": 4.0,
  };

  ActivityControllerImp() {
    categoryController = TextEditingController();
    caloriesController = TextEditingController();
  }

  @override
  void onInit() {
    super.onInit();
    users_id = myServices.sharedPreferences.getString("id");
    // load persisted weight if any
    double? savedWeight = myServices.sharedPreferences.getDouble("last_activity_weight");
    if (savedWeight != null && savedWeight >= 20 && savedWeight <= 200) {
      userWeight = savedWeight;
    } else {
      // fallback default
      userWeight = 70.0;
    }

    if (users_id != null) {
      getActivity();
    } else {
      Get.offNamed(AppRoute.login);
      statusRequest = StatusRequest.failure;
      update();
    }
  }

  // helper to map activity name to category label per your list
  String _categoryForActivity(String activity) {
    final general = {
      "Walking",
      "Running",
      "Cycling",
      "Swimming",
      "Jump Rope",
    };
    final strength = {
      "Pushups",
      "Situps",
      "Squats",
      "Squat jumps",
      "Lunges",
      "Plank",
      "Burpees",
      "Dips",
      "clapping_pushups",
    };
    final core = {
      "Bicycle Crunch",
      "Leg Raises",
      "Mountain Climbers",
      "Russian Twists",
      "Side Plank",
    };
    if (general.contains(activity)) return "General activities & cardio";
    if (strength.contains(activity)) return "Strength & bodyweight";
    if (core.contains(activity)) return "Core exercises";
    return "Other";
  }

  // Converts seconds to h, m, s strings
  Map<String, String> _durationParts(int seconds) {
    final h = seconds ~/ 3600;
    final m = (seconds % 3600) ~/ 60;
    final s = seconds % 60;
    return {
      "hours": h.toString(),
      "minutes": m.toString(),
      "seconds": s.toString(),
    };
  }

  String formattedDuration(int seconds) {
    final parts = _durationParts(seconds);
    return "${parts['hours']!.padLeft(2, '0')}:${parts['minutes']!.padLeft(2, '0')}:${parts['seconds']!.padLeft(2, '0')}";
  }

  // Computes calories (MET * weightKg * durationHours)
  double computeCalories(String activity, double weightKg, int durationSec) {
    final met = _metValues[activity] ?? 4.0;
    final hours = durationSec / 3600.0;
    return met * weightKg * hours;
  }

  // call this whenever selection/weight/duration changes
  void recalcCalories() {
    if (selectedActivityType.isEmpty || durationSeconds == 0) {
      caloriesController.text = "0";
    } else {
      final cals = computeCalories(selectedActivityType, userWeight, durationSeconds);
      caloriesController.text = cals.toStringAsFixed(1);
    }
    update();
  }

  // Save last weight to shared preferences
  void persistWeight(double w) {
    userWeight = w;
    myServices.sharedPreferences.setDouble("last_activity_weight", w);
    recalcCalories();
    update();
  }

  // Called from bottom sheet when user taps Save Activity
  @override
  AddActivity() async {
    // Validate: require an activity type and a duration > 0
    if (users_id == null) {
      Get.defaultDialog(title: "Error", middleText: "User not authenticated.");
      return;
    }

    if (selectedActivityType.isEmpty) {
      Get.snackbar("Validation", "Please select an activity type.", snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (durationSeconds == 0) {
      Get.snackbar("Validation", "Please record the duration.", snackPosition: SnackPosition.BOTTOM);
      return;
    }

    statusRequest = StatusRequest.loading;
    update();

    final durationParts = _durationParts(durationSeconds);
    final caloriesText = caloriesController.text;

    try {
      var response = await activityData.addActivityData(
        users_id!,
        categoryController.text,
        selectedActivityType,
        durationParts['hours'] ?? "0",
        durationParts['minutes'] ?? "0",
        durationParts['seconds'] ?? "0",
        userWeight.toStringAsFixed(1),
        caloriesText,
      );

      statusRequest = handlingData(response);
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == "success") {
          _navigateTobackScreen("Success", "The activity has been added successfully.");
          // reset local form
          selectedActivityType = "";
          selectedActivityImage = "";
          selectedCategory = "";
          categoryController.clear();
          durationSeconds = 0;
          caloriesController.clear();
          // keep persisted weight
          await Future.delayed(const Duration(milliseconds: 300));
          getActivity();
        } else {
          _navigateTobackScreen("Notification", "Sorry, your activity could not be added.");
          statusRequest = StatusRequest.failure;
        }
      }
    } catch (e) {
      print("Error while adding Activity: $e");
      statusRequest = StatusRequest.serverfailure;
    }

    update();
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

  // helpers to update selection
  void selectActivity(String name, String image) {
    selectedActivityType = name;
    selectedActivityImage = image;
    selectedCategory = _categoryForActivity(name);
    categoryController.text = selectedCategory;
    recalcCalories();
    update();
  }

  void setDurationSeconds(int seconds) {
    durationSeconds = seconds;
    recalcCalories();
    update();
  }


  @override
  getActivity() async {
    data.clear();
    statusRequest = StatusRequest.loading;
    update();
    try {
      var response = await activityData.postdata(users_id!);
      print("=============================== Controller Raw Response: $response ");
      statusRequest = handlingData(response);
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == "success") {
          if (response['data'] is List) {
            data.addAll(response['data'].map<ActivityModel>((e) => ActivityModel.fromJson(e)).toList());
            print("Activity Data: $data");
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
      print("Error in get Activity: $e");
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
    var response = await activityData.removedata(id);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        getActivity();
        _navigateTobackScreen("Success" ,"The Activity was Deleted successfully" );
        update();
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void dispose() {
    categoryController.dispose();
    caloriesController.dispose();
    super.dispose();
  }
}