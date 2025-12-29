import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/activity_controller.dart';
import '../../controller/alarm/alarm_controller.dart';

import '../../controller/home_controller.dart';
import '../../controller/medication_controller.dart';
import '../../controller/metrics_cotroller.dart';
import '../../core/class/statusrequest.dart';
import '../../core/constant/imageasset.dart';
import '../../core/constant/routes.dart';
import '../../core/constant/color.dart';
import '../../data/datasource/model/home_statics_model.dart';
import '../widget/add_activity_bottom_sheet.dart';
import '../widget/add_medication_bottom_sheet.dart';
import '../widget/add_metrics_bottom_sheet.dart';
import '../widget/customExtendedFAB.dart';
import '../widget/custom_app_bar.dart';
import '../widget/custom_drawer.dart';
import 'alarm/add_alarm_page.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  Color _statusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'high':
        return Colors.redAccent;
      case 'low':
        return Colors.orangeAccent;
      case 'normal':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _formatTimestamp(String? raw) {
    if (raw == null) return '-';
    try {
      final dt = DateTime.parse(raw);
      return "${dt.year.toString().padLeft(4, '0')}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
    } catch (_) {
      return raw;
    }
  }

  Widget _buildStatCard(String title, String value, {IconData? icon, Color? color}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(6),
        child: Row(
          children: [
            if (icon != null)
              CircleAvatar(
                radius: 18,
                backgroundColor: (color ?? Colors.blue).withOpacity(0.12),
                child: Icon(icon, color: color ?? Colors.blue),
              ),
            const SizedBox(width: 4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(fontSize: 12, color: Colors.black54)),
                  const SizedBox(height: 6),
                  Text(value,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _averageMetricTile(AverageMetrics m) {
    final valueDisplay =
    (m.value == null) ? '-' : m.value!.toStringAsFixed(1).replaceAll('.0', '');
    final percent = (m.value ?? 0) / ((m.value ?? 1) + 60);
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(m.label ?? '',
                  style: const TextStyle(
                      fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Text(valueDisplay,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black)),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: percent.clamp(0.0, 1.0),
                minHeight: 6,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation(Colors.blueAccent),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _metricItemTile({
    required String title,
    required String subtitle,
    required String status,
    required Widget trailing,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.black54)),
      trailing: trailing,
      leading: CircleAvatar(
        backgroundColor: _statusColor(status).withOpacity(0.18),
        child: Icon(Icons.favorite, color: _statusColor(status)),
      ),
    );
  }

  Widget _buildMetricGroupCard(String title, List<dynamic>? readings) {
    if (readings == null || readings.isEmpty) {
      return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text("No readings available",
                  style: TextStyle(color: Colors.black54)),
            ],
          ),
        ),
      );
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Text(title,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Text("${readings.length} readings",
                      style: const TextStyle(color: Colors.black54, fontSize: 12)),
                ],
              ),
            ),
            const Divider(height: 1),
            ...readings.map((r) {
              String mainValue = '-';
              String subValue = '';
              if (r is BloodPressure) {
                mainValue = "${r.value1 ?? '-'} / ${r.value2 ?? '-'}";
                subValue = _formatTimestamp(r.timestamp);
              } else if (r is HeartRate) {
                mainValue = "${r.value1 ?? '-'} bpm";
                subValue = _formatTimestamp(r.timestamp);
              } else if (r is BloodSugar) {
                mainValue = "${r.value1 ?? '-'} mg/dL";
                subValue = _formatTimestamp(r.timestamp);
              } else if (r is Map) {
                final v1 = r['value1']?.toString() ?? '-';
                final v2 = r['value2']?.toString() ?? '';
                mainValue = v2.isNotEmpty ? "$v1 / $v2" : v1;
                subValue = _formatTimestamp(r['timestamp']?.toString());
              }

              final status = (r is BloodPressure)
                  ? r.status
                  : (r is HeartRate)
                  ? r.status
                  : (r is BloodSugar)
                  ? r.status
                  : (r is Map ? r['status']?.toString() : null);

              return Column(
                children: [
                  _metricItemTile(
                    title: mainValue,
                    subtitle: subValue,
                    status: status ?? 'unknown',
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: _statusColor(status).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(status ?? 'Unknown',
                          style: TextStyle(
                              color: _statusColor(status),
                              fontWeight: FontWeight.w600,
                              fontSize: 12)),
                    ),
                  ),
                  const Divider(indent: 68),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _activitiesSection(Activities? activities) {
    if (activities == null) {
      return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
            padding: const EdgeInsets.all(12),
            child: const Text("No activity data available",
                style: TextStyle(color: Colors.black54))),
      );
    }

    final byType = activities.byType ?? [];
    final recent = activities.recent ?? [];
    final last7 = activities.last7Days ?? [];

    final double last7Max = last7
        .map((x) => (x.caloriesSum ?? 0.0))
        .fold<double>(0.0, (prev, e) => e > prev ? e : prev);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              const Text("Activities",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const Spacer(),
              Text(activities.lastActivityDate ?? '-',
                  style: const TextStyle(color: Colors.black54)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                  child: _buildStatCard("Total", "${activities.totalActivities ?? 0}",
                      icon: Icons.fitness_center, color: Colors.purple)),
              const SizedBox(width: 5),
              Expanded(
                  child: _buildStatCard("Calories",
                      "${(activities.totalCalories ?? 0).toStringAsFixed(0)}",
                      icon: Icons.local_fire_department, color: Colors.deepOrange)),
              const SizedBox(width: 5),
              Expanded(
                  child: _buildStatCard("Duration",
                      "${_secondsToReadable(activities.totalDurationSeconds ?? 0)}",
                      icon: Icons.timer, color: Colors.teal)),
            ],
          ),
          const SizedBox(height: 12),
          if (byType.isNotEmpty) ...[
            const Text("By type", style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: byType.map((b) {
                return Chip(
                  label: Text("${b.activityType ?? b.activityType} • ${b.count ?? 0}"),
                  backgroundColor: Colors.blueGrey.shade50,
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
          ],
          const Text("Recent", style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          ...recent.map((r) {
            return ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const CircleAvatar(child: Icon(Icons.directions_run)),
              title: Text("${r.activityType ?? r.activityType ?? 'Activity'}"),
              subtitle: Text(
                  "${_secondsToReadable(r.durationSeconds ?? 0)} • ${(r.caloriesBurned ?? 0).toStringAsFixed(0)} kcal"),
              trailing: Text(_formatTimestamp(r.activityDate)),
            );
          }).toList(),
          const SizedBox(height: 8),
          const Text("Last 7 days", style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          SizedBox(
            height: 80,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: last7.map((d) {
                final double factor = (last7Max > 0.0) ? ((d.caloriesSum ?? 0.0) / last7Max) : 0.0;
                final double displayFactor = factor.clamp(0.06, 1.0);

                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: FractionallySizedBox(
                            heightFactor: displayFactor,
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 6),
                              decoration: BoxDecoration(
                                color: Colors.lightBlueAccent,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(d.date?.split('-').last ?? '',
                          style: const TextStyle(fontSize: 10, color: Colors.black54))
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ]),
      ),
    );
  }

  static String _secondsToReadable(int seconds) {
    if (seconds <= 0) return "0m";
    final h = seconds ~/ 3600;
    final m = (seconds % 3600) ~/ 60;
    if (h > 0) return "${h}h ${m}m";
    return "${m}m";
  }

  @override
  Widget build(BuildContext context) {
    final HomeControllerImp controller = Get.put(HomeControllerImp());

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Home',
        icon: Icons.home,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {
              // TODO Open notifications

            },
          ),
        ],
      ),
      drawer: CustomDrawer(),
      backgroundColor: Colors.grey.shade100,

      body:

      GetBuilder<HomeControllerImp>(
        builder: (ctl) {
          final data = ctl.data;
          final loading = (ctl.statusRequest == StatusRequest.loading);
          if (loading && data == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: () async {
              await ctl.getHomeStatics();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Greeting & quick summary
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Overview",
                                    style: TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                          "Last generated: ${data?.generatedAt ?? '-'}",
                                          style: const TextStyle(color: Colors.black54),
                                        )),
                                    const SizedBox(width: 8),
                                    ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10))),
                                      onPressed: () {
                                        ctl.getHomeStatics();
                                      },
                                      icon: const Icon(Icons.sync, size: 18),
                                      label: const Text("Refresh"),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                        child: _buildStatCard(
                                            "Alarms",
                                            "${data?.alarmsCount ?? 0}",
                                            icon: Icons.alarm,
                                            color: Colors.redAccent)),
                                    const SizedBox(width: 8),
                                    Expanded(
                                        child: _buildStatCard(
                                            "Medications",
                                            "${data?.medicationCount ?? 0}",
                                            icon: Icons.medication,
                                            color: Colors.teal)),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Average metrics horizontal list
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 6),
                    child: Text("Average Metrics",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: 140,
                    child: data?.averageMetrics != null && data!.averageMetrics!.isNotEmpty
                        ? ListView.builder(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      scrollDirection: Axis.horizontal,
                      itemCount: data.averageMetrics!.length,
                      itemBuilder: (context, index) {
                        return _averageMetricTile(data.averageMetrics![index]);
                      },
                    )
                        : const Center(child: Text("No average metrics available")),
                  ),

                  const SizedBox(height: 10),

                  // Place 'Blood Sugar' group FIRST for diabetes focus
                  _buildMetricGroupCard("Blood Sugar", data?.metricsGrouped?.bloodSugar),
                  const SizedBox(height: 10),
                  _buildMetricGroupCard("Blood Pressure", data?.metricsGrouped?.bloodPressure),
                  const SizedBox(height: 10),
                  _buildMetricGroupCard("Heart Rate", data?.metricsGrouped?.heartRate),

                  const SizedBox(height: 10),

                  // Activities
                  _activitiesSection(data?.activities),


                ],
              ),
            ),
          );
        },
      ),

      floatingActionButton: customExtendedFAB(
        icon: Icons.add,
        label: 'Quick',
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (_) => _quickActionsSheet(context),
          );
        },
      ),

    );
  }



  Widget _quickActionsSheet(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildQuickActionTile(
              context,
              icon: Icons.bloodtype,
              title: "Log glucose or Other Metrics",
              onTap: () {
                Get.back();
                AddMetricsBottomSheet(context);
              },
            ),
            const SizedBox(height: 14),
            _buildQuickActionTile(
              context,
              icon: Icons.medication,
              title: "Add medication",
              onTap: () {
                Get.back();
                AddMedicationBottomSheet(context);
              },
            ),
            const SizedBox(height: 14),
            _buildQuickActionTile(
              context,
              icon: Icons.alarm_add,
              title: "Create alarm",
              onTap: () {
                Get.back();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddAlarmPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 14),
            _buildQuickActionTile(
              context,
              icon: Icons.run_circle,
              title: "Log activity",
              onTap: () {
                Get.back();
                AddActivityBottomSheet(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionTile(
      BuildContext context, {
        required IconData icon,
        required String title,
        required VoidCallback onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: AppColor.backgroundcolor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColor.primaryColor.withOpacity(0.4),
            width: 1.8,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColor.primaryColor,
                    AppColor.primaryColor.withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.primaryColor.withOpacity(0.25),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 26),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.black45),
          ],
        ),
      ),
    );
  }

}
