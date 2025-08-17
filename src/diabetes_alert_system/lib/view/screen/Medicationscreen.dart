import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/medication_controller.dart';
import '../../core/class/handlingdataview.dart';
import '../../core/class/statusrequest.dart';
import '../../core/constant/color.dart';
import '../../core/constant/imageasset.dart';
import '../../data/datasource/model/MedicationModel.dart';
import '../widget/add_medication_bottom_sheet.dart';
import '../widget/custom_app_bar.dart';
import '../widget/custom_drawer.dart';
import '../widget/custom_fab.dart';

class MedicationScreen extends StatelessWidget {
  const MedicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MedicationControllerImp controller = Get.put(MedicationControllerImp());

    return Scaffold(
        appBar:
        CustomAppBar(
          title: 'Medications',
          icon: Icons.medication,
          actions: [
            IconButton(
              icon: const Icon(Icons.update, color: Colors.white),
              onPressed: () {
                controller.updatedata();
              },
            ),
          ],
        ),
        drawer: CustomDrawer(),
        body: Container(
          padding: const EdgeInsets.all(5),
          child: ListView(
            children: [
              const SizedBox(height: 15),
              GetBuilder<MedicationControllerImp>(
                builder: (controller) => HandlingDataView(
                  statusRequest: controller.statusRequest,
                  widget: controller.statusRequest == StatusRequest.success
                      ? ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.data.length,
                    itemBuilder: (context, index) {
                      MedicationModel medication = controller.data[index];

                      String getImageByType(String type) {
                        switch (type.toLowerCase()) {
                          case "tablet":
                            return AppImageAsset.Tablet;
                          case "capsule":
                            return AppImageAsset.Capsule;
                          case "syrup":
                            return AppImageAsset.Syrup;
                          case "injection":
                            return AppImageAsset.Injection;
                          case "cream":
                            return AppImageAsset.Cream;
                          case "ointment":
                            return AppImageAsset.Ointment;
                          case "gel":
                            return AppImageAsset.Gel;
                          case "drops":
                            return AppImageAsset.Drops;
                          case "suspension":
                            return AppImageAsset.Suspension;
                          default:
                            return AppImageAsset.DefaultImage;
                        }
                      }

                      return Dismissible(
                        key: UniqueKey(),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: AppColor.backgroundcolor,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          child: const Icon(
                            Icons.delete,
                            color:Colors.red,
                            size: 40,
                          ),
                        ),
                        confirmDismiss: (direction) async {
                          // Show confirmation dialog
                          return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Confirm Deletion"),
                                content: const Text(
                                  "Are you sure you want to delete this medication?",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: const Text("Cancel",style: TextStyle(
                                      color: AppColor.primaryColor,
                                    )
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    },
                                    child: const Text("Delete",style: TextStyle(
                                      color: AppColor.primaryColor,
                                    )
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        onDismissed: (direction) {
                          controller.remove(medication.medicationId.toString()!);
                        },
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Card(
                              elevation: 10,
                              margin: const EdgeInsets.all(30),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide(
                                  color: AppColor.primaryColor.withOpacity(0.8),
                                  width: 1.5,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 50),
                                  ListTile(
                                    title: Text(
                                      medication.medicationName ?? 'Unknown medicationName',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    subtitle: Text(
                                      medication.medicationDosage ?? 'Unknown medicationDosage',
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      medication.medicationClass ?? 'Unknown medicationClass',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    subtitle: Text(
                                      medication.medicationFrequency ?? 'Unknown medication Frequency',
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: -10,
                              left: MediaQuery.of(context).size.width / 2 - 40,
                              child: Column(
                                children: [
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AppColor.primaryColor,
                                        width: 3.0,
                                      ),
                                      image: DecorationImage(
                                        image: AssetImage(
                                          getImageByType(medication.medicationType ?? "default"),
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    medication.medicationType ?? "Unknown Type",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                      :  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Animated Icon
                        AnimatedScale(
                          duration: const Duration(milliseconds: 500),
                          scale: 1.0,
                          child: Icon(
                            Icons.medication_outlined,
                            size: 80,
                            color: Colors.grey.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const AnimatedOpacity(
                          duration:  Duration(milliseconds: 500),
                          opacity: 1.0,
                          child:  Text(
                            "No Medication Found",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),    floatingActionButton:
    customFAB(
      icon: Icons.medication,
      onPressed: () {
        AddMedicationBottomSheet(context);
      },
    )
    );
  }
}