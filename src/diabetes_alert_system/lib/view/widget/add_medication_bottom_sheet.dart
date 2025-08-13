import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/medication_controller.dart';
import '../../core/constant/color.dart';
import '../../core/constant/imageasset.dart';
import '../../core/functions/validinput.dart';
import '../widget/auth/customtextformauth.dart';

void AddMedicationBottomSheet(BuildContext context) {
  Get.bottomSheet(
    backgroundColor: AppColor.white,
    Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
      ),
      child: GetBuilder<MedicationControllerImp>(
        builder: (controller) => SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Form(
              key: controller.formstate,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Add New Medication',
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
                  CustonTextFormAuth(
                    isNumber: false,
                    valid: (val) => validInput(val!, 3, 150, "text"),
                    mycontroller: controller.name,
                    hinttext: "Enter Medication Name",
                    iconData: Icons.description,
                    labeltext: "Medication Name",
                  ),
                  const SizedBox(height: 10),

                  CustonTextFormAuth(
                    isNumber: false,
                    valid: (val) => validInput(val!, 1, 50, "text"),
                    mycontroller: controller.dosage,
                    hinttext: "Enter Dosage (e.g., 500mg)",
                    iconData: Icons.local_hospital,
                    labeltext: "Dosage",
                  ),
                  const SizedBox(height: 10),

                  CustonTextFormAuth(
                    isNumber: false,
                    valid: (val) => validInput(val!, 1, 50, "text"),
                    mycontroller: controller.frequency,
                    hinttext: "Enter Frequency (e.g., Twice a Day)",
                    iconData: Icons.repeat,
                    labeltext: "Frequency",
                  ),
                  const SizedBox(height: 10),

                  SizedBox(
                    height: 60,
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        hintText: 'Select Medication Class',
                        labelText: "Medication Class",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      value: controller.classs.text.isEmpty ? null : controller.classs.text,
                      onChanged: (value) {
                        controller.classs.text = value!;
                        controller.update();
                      },
                      items: [
                        "Antibiotic",
                        "Painkiller",
                        "Vitamin",
                        "Antiviral",
                        "Antifungal",
                        "Antihistamine",
                        "Cardiac",
                        "Gastrointestinal",
                        "Respiratory",
                        "Endocrine",
                        "Neurological",
                        "Dermatological",
                        "Psychiatric",
                        "Antidiabetic",
                        "Anti-inflammatory",
                        "Immunosuppressant",
                        "Anesthetic",
                        "Antimalarial",
                        "Ophthalmic",
                        "Other",
                      ].map((classItem) {
                        return DropdownMenuItem(
                          value: classItem,
                          child: Text(classItem),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Select Medication Type",
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
                        _buildTypeCard(controller, "Tablet", AppImageAsset.Tablet),
                        _buildTypeCard(controller, "Capsule", AppImageAsset.Capsule),
                        _buildTypeCard(controller, "Syrup", AppImageAsset.Syrup),
                        _buildTypeCard(controller, "Injection", AppImageAsset.Injection),
                        _buildTypeCard(controller, "Cream", AppImageAsset.Cream),
                        _buildTypeCard(controller, "Ointment", AppImageAsset.Ointment),
                        _buildTypeCard(controller, "Gel", AppImageAsset.Gel),
                        _buildTypeCard(controller, "Drops", AppImageAsset.Drops),
                        _buildTypeCard(controller, "Suspension", AppImageAsset.Suspension),
                        _buildTypeCard(controller, "Other", AppImageAsset.DefaultImage),

                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        controller.AddMedicatio();
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
                        "Save Medication",
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

Widget _buildTypeCard(MedicationControllerImp controller, String type, String imageAsset) {
  return GestureDetector(
    onTap: () {
      controller.type.text = type;
      controller.update();
    },
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: 115,
      decoration: BoxDecoration(
        color: controller.type.text == type
            ? AppColor.primaryColor.withOpacity(0.2)
            : AppColor.backgroundcolor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: controller.type.text == type ? AppColor.primaryColor : Colors.grey,
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
              color: controller.type.text == type ? AppColor.primaryColor : Colors.black,
            ),
          ),
        ],
      ),
    ),
  );
}