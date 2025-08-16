import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/metrics_cotroller.dart';
import '../../core/class/handlingdataview.dart';
import '../../core/class/statusrequest.dart';
import '../../core/constant/color.dart';
import '../widget/add_metrics_bottom_sheet.dart';
import '../widget/custom_app_bar.dart';
import '../widget/custom_fab.dart';
import '../widget/showInfoPopup.dart';

class MetricsScreen extends StatelessWidget {
  const MetricsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MetricsControllerImp controller = Get.put(MetricsControllerImp());

    return Scaffold(
      appBar:
      CustomAppBar(
        title: 'Health Metrics',
        icon: Icons.show_chart,
        actions: [
          IconButton(
            icon: const Icon(Icons.update, color: Colors.white),
            onPressed: () async{
              await controller.getMetrics();
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(5),
        child: ListView(
          children: [
            const SizedBox(height: 15),
            GetBuilder<MetricsControllerImp>(
              builder: (controller) => HandlingDataView(
                statusRequest: controller.statusRequest,
                widget: controller.statusRequest == StatusRequest.success
                    ? ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.data.length,
                  itemBuilder: (context, index) {
                    final metric = controller.data[index];
                    final status = controller.getMetricStatus(
                      metric.metricType!,
                      metric.metricValue1!,
                      metric.metricValue2,
                    );

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
                                "Are you sure you want to delete this metric?",
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
                        controller.remove(metric.metricId.toString());
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
                                const SizedBox(height: 58),

                                ListTile(
                                  title:  Text(
                                    "Value: ${metric.metricValue1}   ${metric.metricValue2 ?? ''}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ), subtitle: Text(
                                  "Time: ${metric.metricTimestamp}",
                                  style: const TextStyle(fontSize: 18),
                                ),
                                ),
                                Container(
                                  color: status == 'Normal'
                                      ? AppColor.primaryColor3
                                      : status == 'High'
                                      ? Colors.red
                                      : Colors.orange ,
                                  child: Align(
                                    heightFactor: 1.2,
                                    alignment: Alignment.center,
                                    child:Text(
                                      "Status: $status",
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: status == 'Normal'
                                            ? Colors.white
                                            : status == 'High'
                                            ? AppColor.text
                                            : AppColor.text,
                                      ),
                                    ) ,
                                  ),
                                ),
                                const SizedBox(height: 15),
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
                                    color: AppColor.backgroundcolor,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColor.primaryColor,
                                      width: 3.0,
                                    ),
                                    image: DecorationImage(
                                      image: AssetImage(
                                        controller.getImageByMetricType(
                                            metric.metricType ?? "Unknown"),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  metric.metricType ?? "Unknown Type",
                                  style: const TextStyle(
                                    fontSize: 16,
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
                    : const Center(
                  child: Text(
                    "No Metrics Found",
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
      ),floatingActionButton: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        customFAB(
          icon: Icons.info,
          onPressed: () {
            showInfoPopup(context);
          },
        ),
        const SizedBox(height: 10),
        customFAB(
          icon: Icons.add_box,
          onPressed: () {
            AddMetricsBottomSheet(context);
          },
        ),
      ],
    ),

    );
  }
}