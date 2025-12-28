import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/activity_controller.dart';
import '../../core/class/handlingdataview.dart';
import '../../core/class/statusrequest.dart';
import '../../core/constant/color.dart';
import '../../core/constant/imageasset.dart';
import '../widget/add_activity_bottom_sheet.dart';
import '../widget/custom_app_bar.dart';
import '../widget/custom_drawer.dart';
import '../widget/custom_fab.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  String getImageByActivityType(String type) {
    final normalized = (type ?? '').toLowerCase().trim();

    if (normalized.isEmpty) return AppImageAsset.walking;

    // Specific / multi-word checks first
    if (normalized.contains('squat jump') ||
        normalized.contains('squat-jump') ||
        normalized.contains('squat jumps')) {
      return AppImageAsset.squat_jumps;
    }
    if (normalized.contains('clap') || normalized.contains('clapping')) {
      return AppImageAsset.clapping_pushups;
    }
    if (normalized.contains('bicycle') ||
        normalized.contains('bicycle crunch') ||
        normalized.contains('crunch')) {
      return AppImageAsset.bicycle_crunch;
    }
    if (normalized.contains('leg raise') ||
        normalized.contains('leg raises') ||
        normalized.contains('leg-raise')) {
      return AppImageAsset.leg_raises;
    }
    if (normalized.contains('mountain')) {
      return AppImageAsset.mountain_climbers;
    }
    if (normalized.contains('russian') || normalized.contains('twist')) {
      return AppImageAsset.russian_twists;
    }
    if (normalized.contains('side plank') ||
        (normalized.contains('side') && normalized.contains('plank'))) {
      return AppImageAsset.side_plank;
    }

    // Single-word / shorter checks
    if (normalized.contains('walking')) return AppImageAsset.walking;
    if (normalized.contains('running')) return AppImageAsset.running;
    if (normalized.contains('cycling') ||
        normalized.contains('bike') ||
        normalized.contains('biking')) {
      return AppImageAsset.cycling;
    }
    if (normalized.contains('swimming')) return AppImageAsset.swimming;
    if (normalized.contains('jump')) return AppImageAsset.jump_rope;
    if (normalized.contains('push') || normalized.contains('pushup')) {
      return AppImageAsset.pushups;
    }
    if (normalized.contains('sit')) return AppImageAsset.situps;
    if (normalized.contains('squat')) return AppImageAsset.squats;
    if (normalized.contains('lunge')) return AppImageAsset.lunges;
    if (normalized.contains('plank')) return AppImageAsset.plank;
    if (normalized.contains('burpee')) return AppImageAsset.burpees;
    if (normalized.contains('dip')) return AppImageAsset.benchdips;
    if (normalized.contains('other')) return AppImageAsset.other_activity;

    // Fallback
    return AppImageAsset.other_activity;
  }

  @override
  Widget build(BuildContext context) {
    final ActivityControllerImp controller = Get.put(ActivityControllerImp());

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Activity',
        icon: Icons.fitness_center,
        actions: [
          IconButton(
            icon: const Icon(Icons.update, color: Colors.white),
            onPressed: () async {
              await controller.getActivity();
            },
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: Container(
        padding: const EdgeInsets.all(5),
        child: ListView(
          children: [
            const SizedBox(height: 30),
            GetBuilder<ActivityControllerImp>(
              builder: (controller) => HandlingDataView(
                statusRequest: controller.statusRequest,
                widget: controller.statusRequest == StatusRequest.success
                    ? ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.data.length,
                  itemBuilder: (context, index) {
                    final activity = controller.data[index];
                    final imagePath =
                    getImageByActivityType(activity.activityType ?? '');

                    return Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: AppColor.backgroundcolor,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                      confirmDismiss: (direction) async {
                        return await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Confirm Deletion"),
                              content: const Text(
                                "Are you sure you want to delete this activity?",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: const Text(
                                    "Cancel",
                                    style: TextStyle(
                                      color: AppColor.primaryColor,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  child: const Text(
                                    "Delete",
                                    style: TextStyle(
                                      color: AppColor.primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      onDismissed: (direction) {
                        controller.remove(activity.activityId.toString());
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
                                color:
                                AppColor.primaryColor.withOpacity(0.8),
                                width: 1.5,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 70),
                                ListTile(
                                  title: Text(
                                    "${activity.activityType ?? 'Unknown'}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: AppColor.primaryColor,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 5),
                                      Text(
                                        "Category: ${activity.category ?? 'N/A'}",
                                        style:
                                        const TextStyle(fontSize: 18),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        "Calories: ${activity.caloriesBurned?.toStringAsFixed(1) ?? '0'} kcal",
                                        style:
                                        const TextStyle(fontSize: 18),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        "Weight: ${activity.userWeight ?? 0} kg",
                                        style:
                                        const TextStyle(fontSize: 18),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        "Date: ${activity.activityDate ?? ''}",
                                        style:
                                        const TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 15),
                              ],
                            ),
                          ),
                          Positioned(
                            top: -15,
                            left: 30,
                            right: 30,
                            child: Center(
                              child: ActivityBadge(
                                imagePath: imagePath,
                                size: 120,
                                borderRadius: 16,
                                borderWidth: 3.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
                    : const Center(
                  child: Text(
                    "No Activities Found",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          customFAB(
            icon: Icons.add_box,
            onPressed: () {
              AddActivityBottomSheet(context);
            },
          ),
        ],
      ),
    );
  }
}

class ActivityBadge extends StatelessWidget {
  final String imagePath;
  final double size;
  final double borderRadius;
  final double borderWidth;

  const ActivityBadge({
    Key? key,
    required this.imagePath,
    this.size = 100,
    this.borderRadius = 12,
    this.borderWidth = 2.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColor.backgroundcolor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: AppColor.primaryColor,
          width: borderWidth,
        ),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 12,
            spreadRadius: 2,
            offset: const Offset(0, 6),
          ),
        ],
      ),
    );
  }
}
