import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/metrics_cotroller.dart';
import '../../core/constant/color.dart';
import '../../core/constant/imageasset.dart';
import '../../core/functions/validinput.dart';
import 'auth/customtextformauth.dart';

void AddMetricsBottomSheet(BuildContext context) {
  Get.bottomSheet(
    backgroundColor: AppColor.white,
    Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
      ),
      child: GetBuilder<MetricsControllerImp>(
        builder: (controller) => SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Form(
              key: controller.formstate,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Add Health Metric',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColor.primaryColor,
                          shadows: [
                            Shadow(
                              blurRadius: 5.0,
                              color: Colors.black.withOpacity(0.3),
                              offset: const Offset(2.0, 2.0),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Horizontal Scrollable Metric Types
                  const Text(
                    "Select Metric Type",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: AppColor.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 120,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildMetricTypeCard(controller, "Blood Sugar", AppImageAsset.BloodSugar),
                        _buildMetricTypeCard(controller, "Blood Pressure", AppImageAsset.BloodPressure),
                        _buildMetricTypeCard(controller, "Heart Rate", AppImageAsset.HeartRate),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Dynamic Input Fields
                  if (controller.metric_type.text == "Blood Pressure") ...[
                    CustonTextFormAuth(
                      isNumber: true,
                      valid: (val) => validInput(val!, 1, 150, "number"),
                      mycontroller: controller.value1,
                      hinttext: "Enter Systolic (e.g., 120)",
                      iconData: Icons.bloodtype,
                      labeltext: "Systolic Value",
                    ),
                    const SizedBox(height: 10),
                    CustonTextFormAuth(
                      isNumber: true,
                      valid: (val) => validInput(val!, 1, 150, "number"),
                      mycontroller: controller.value2,
                      hinttext: "Enter Diastolic (e.g., 80)",
                      iconData: Icons.bloodtype,
                      labeltext: "Diastolic Value",
                    ),
                  ] else if (controller.metric_type.text == "Heart Rate") ...[
                    CustonTextFormAuth(
                      isNumber: true,
                      valid: (val) => validInput(val!, 1, 150, "number"),
                      mycontroller: controller.value1,
                      hinttext: "Enter BPM (e.g., 75)",
                      iconData: Icons.favorite,
                      labeltext: "Heart Rate",
                    ),
                  ] else if (controller.metric_type.text == "Blood Sugar") ...[
                    CustonTextFormAuth(
                      isNumber: true,
                      valid: (val) => validInput(val!, 1, 150, "number"),
                      mycontroller: controller.value1,
                      hinttext: "Enter Glucose Level (e.g., 95)",
                      iconData: Icons.star,
                      labeltext: "Blood Sugar Level",
                    ),
                  ],

                  const SizedBox(height: 20),

                  // Save Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        controller.AddMetric();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        elevation: 8,
                        backgroundColor: AppColor.primaryColor,
                      ),
                      child: const Text(
                        "Save Metric",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
    isScrollControlled: true,
    elevation: 10,
    shape: const RoundedRectangleBorder(
      side: BorderSide(
        color: AppColor.primaryColor,
        width: 3.0,
      ),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    ),
  );
}

Widget _buildMetricTypeCard(MetricsControllerImp controller, String type, String imageAsset) {
  return GestureDetector(
    onTap: () {
      controller.metric_type.text = type;
      controller.update();
    },
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: 115,
      decoration: BoxDecoration(
        color: controller.metric_type.text == type
            ? AppColor.primaryColor.withOpacity(0.2)
            : AppColor.backgroundcolor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: controller.metric_type.text == type ? AppColor.primaryColor : Colors.grey,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imageAsset, width: 80, height: 80),
          const SizedBox(height: 5),
          Text(
            type,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: controller.metric_type.text == type ? AppColor.primaryColor : Colors.black,
            ),
          ),
        ],
      ),
    ),
  );
}