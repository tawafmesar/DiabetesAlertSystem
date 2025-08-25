import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/activity_controller.dart';
import '../../core/constant/color.dart';
import '../../core/constant/imageasset.dart';
import 'custom_elevated_button.dart';
import 'custom_elevated_button_muted.dart';

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

void AddActivityBottomSheet(BuildContext context) {
  Get.bottomSheet(
    backgroundColor: AppColor.white,
    Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: GetBuilder<ActivityControllerImp>(
        builder: (controller) => SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            child: Form(
              key: controller.formstate,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [AppColor.primaryColor, AppColor.primaryColor.withOpacity(0.8)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.primaryColor.withOpacity(0.25),
                                  blurRadius: 8,
                                  offset: const Offset(0, 6),
                                )
                              ],
                            ),
                            child: const Icon(Icons.fitness_center, color: Colors.white),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Add Activity',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColor.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Weight slider (always visible)
                  const Text("Your weight (kg)", style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    decoration: BoxDecoration(
                      color: AppColor.backgroundcolor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColor.primaryColor.withOpacity(0.12)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${controller.userWeight.toStringAsFixed(1)} kg",
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Slider(
                          value: controller.userWeight,
                          min: 20.0,
                          max: 200.0,
                          divisions: 180,
                          activeColor: AppColor.primaryColor,
                          onChanged: (newVal) {
                            controller.persistWeight(newVal);
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text("20 kg", style: TextStyle(fontSize: 12)),
                            Text("200 kg", style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Activity type (always visible)
                  const Text("Activity Type", style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 150,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildActivityCard(controller, "Walking", AppImageAsset.walking),
                        _buildActivityCard(controller, "Running", AppImageAsset.running),
                        _buildActivityCard(controller, "Cycling", AppImageAsset.cycling),
                        _buildActivityCard(controller, "Swimming", AppImageAsset.swimming),
                        _buildActivityCard(controller, "Jump Rope", AppImageAsset.jump_rope),
                        _buildActivityCard(controller, "Pushups", AppImageAsset.pushups),
                        _buildActivityCard(controller, "Situps", AppImageAsset.situps),
                        _buildActivityCard(controller, "Squats", AppImageAsset.squats),
                        _buildActivityCard(controller, "Squat jumps", AppImageAsset.squat_jumps),
                        _buildActivityCard(controller, "Lunges", AppImageAsset.lunges),
                        _buildActivityCard(controller, "Plank", AppImageAsset.plank),
                        _buildActivityCard(controller, "Burpees", AppImageAsset.burpees),
                        _buildActivityCard(controller, "Dips", AppImageAsset.benchdips),
                        _buildActivityCard(controller, "Clapping Pushups", AppImageAsset.clapping_pushups),
                        _buildActivityCard(controller, "Bicycle Crunch", AppImageAsset.bicycle_crunch),
                        _buildActivityCard(controller, "Leg Raises", AppImageAsset.leg_raises),
                        _buildActivityCard(controller, "Mountain Climbers", AppImageAsset.mountain_climbers),
                        _buildActivityCard(controller, "Russian Twists", AppImageAsset.russian_twists),
                        _buildActivityCard(controller, "Side Plank", AppImageAsset.side_plank),
                        _buildActivityCard(controller, "Other", AppImageAsset.other_activity),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Animated details: Category, Duration, Calories, Save & Reset buttons
                  Builder(builder: (_) {
                    final showDetails = controller.selectedActivityType.isNotEmpty;
                    return AnimatedCrossFade(
                      firstChild: const SizedBox.shrink(),
                      secondChild: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Category (smaller/shorter)
                          const Text("Category", style: TextStyle(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 44,
                            child: TextFormField(
                              controller: controller.categoryController,
                              readOnly: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColor.backgroundcolor,
                                hintText: "Category (auto-filled)",
                                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                                prefixIcon: const Icon(Icons.category, size: 20),
                              ),
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Duration (condensed)
                          const Text("Duration", style: TextStyle(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                            decoration: BoxDecoration(
                              color: AppColor.backgroundcolor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    controller.durationSeconds == 0
                                        ? "No duration recorded"
                                        : controller.formattedDuration(controller.durationSeconds),
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                  child: CustomElevatedButton(
                                    text: controller.durationSeconds == 0 ? "Open Stopwatch" : "Edit Stopwatch",
                                    icon: Icons.timer,
                                    radius: 10,
                                    onPressed: () {
                                      _openStopwatchDialog(context, controller);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Calories (condensed)
                          const Text("Calories Burned", style: TextStyle(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 44,
                            child: TextFormField(
                              controller: controller.caloriesController,
                              readOnly: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColor.backgroundcolor,
                                hintText: "Calories will be calculated automatically",
                                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                                prefixIcon: const Icon(Icons.local_fire_department, size: 20),
                              ),
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          const SizedBox(height: 18),

                          // Row with Reset and Save buttons
                          Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Reset button (uses the copy-styled CustomResetButton)
                                CustomResetButton(
                                  text: "Reset",
                                  icon: Icons.refresh,
                                  radius: 12,
                                  onPressed: () {
                                    // Reset the relevant fields in controller
                                    try {
                                      // Clear selected activity
                                      controller.selectedActivityType = '';
                                      // Clear category & calories text fields
                                      controller.categoryController.clear();
                                      controller.caloriesController.clear();
                                      // Reset duration
                                      controller.setDurationSeconds(0);
                                      // Reset form state if exists
                                      controller.formstate.currentState?.reset();
                                    } catch (e) {
                                      // If controller doesn't expose any of those members, ignore error but print for dev
                                      debugPrint('Reset action: $e');
                                    }
                                    // Notify UI to update
                                    controller.update();
                                  },
                                ),
                                const SizedBox(width: 12),

                                // Save button (uses your spirited CustomElevatedButton style)
                                CustomElevatedButton(
                                  text: "Save Activity",
                                  icon: Icons.save,
                                  radius: 12,
                                  onPressed: () {
                                      if (controller.durationSeconds == 0) {
                                        Get.defaultDialog(
                                          title: 'Notification',
                                          middleText: 'Please set a duration before saving the activity.'
                                        );
                                        return;
                                      }

                                    controller.AddActivity();
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                      crossFadeState: showDetails ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 300),
                      firstCurve: Curves.easeInOut,
                      secondCurve: Curves.easeInOut,
                      sizeCurve: Curves.easeInOut,
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
    isScrollControlled: true,
    elevation: 12,
    shape: const RoundedRectangleBorder(
      side: BorderSide(color: AppColor.primaryColor, width: 2.5),
      borderRadius: BorderRadius.only(topLeft: Radius.circular(28), topRight: Radius.circular(28)),
    ),
  );
}

/// Activity card now uses ActivityBadge
Widget _buildActivityCard(ActivityControllerImp controller, String name, String imageAsset) {
  final selected = controller.selectedActivityType == name;
  return GestureDetector(
    onTap: () {
      controller.selectActivity(name, imageAsset);
    },
    child: Container(
      width: 120,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ActivityBadge(
            imagePath: imageAsset,
            size: 125,
            borderRadius: 14,
            borderWidth: selected ? 3.0 : 1.5,
          ),
          const SizedBox(height: 6),
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: selected ? AppColor.primaryColor : Colors.black87,
              fontSize: 13,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
  );
}

/// Stopwatch dialog remains same
void _openStopwatchDialog(BuildContext context, ActivityControllerImp controller) {
  int tempSeconds = controller.durationSeconds;
  bool running = false;
  Timer? timer;

  void startTimer(void Function(void Function()) setStateSB) {
    running = true;
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      tempSeconds += 1;
      setStateSB(() {});
    });
  }

  void stopTimer() {
    running = false;
    timer?.cancel();
    timer = null;
  }

  Get.dialog(
    StatefulBuilder(builder: (context, setStateSB) {
      String formatted(int s) {
        final h = s ~/ 3600;
        final m = (s % 3600) ~/ 60;
        final sec = s % 60;
        return "${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}";
      }

      return AlertDialog(
        title: const Text("Stopwatch"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(formatted(tempSeconds), style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 44,
                  child: CustomElevatedButton(
                    text: running ? "Stop" : "Start",
                    icon: running ? Icons.pause : Icons.play_arrow,
                    radius: 30,
                    onPressed: () {
                      if (!running) {
                        startTimer(setStateSB);
                      } else {
                        stopTimer();
                      }
                      setStateSB(() {});
                    },
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  height: 44,
                  child: CustomResetButton(
                    text: "Reset",
                    icon: Icons.refresh,
                    radius: 30,
                    onPressed: () {
                      stopTimer();
                      tempSeconds = 0;
                      setStateSB(() {});
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              stopTimer();
              Get.back();
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              stopTimer();
              controller.setDurationSeconds(tempSeconds);
              Get.back();
            },
            child: const Text("Save"),
          ),
        ],
      );
    }),
    barrierDismissible: false,
  );
}