import 'package:flutter/material.dart';
import '../../core/constant/color.dart';

void showInfoPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(

        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: AppColor.primaryColor,
            width: 3.0,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Health Metric Guidance',
                      style: TextStyle(
                        fontSize: 22,
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
                const Divider(height: 20, color: Colors.grey),
                const Text(
                  "Blood Pressure Ranges",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColor,
                  ),
                ),
                const SizedBox(height: 10),
                Table(
                  border: TableBorder.all(color: Colors.grey),
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(1),
                  },
                  children:const [
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("Category", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("Range (mmHg)", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("Low"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("< 90/60"),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("Normal"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("90/60 to 120/80"),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("High"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("> 120/80"),
                      ),
                    ]),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "Blood Sugar Ranges",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColor,
                  ),
                ),
                const SizedBox(height: 10),
                Table(
                  border: TableBorder.all(color: Colors.grey),
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(1),
                  },
                  children: const [
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("Category", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("Range (mg/dL)", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("Low"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("< 70"),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("Normal"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("70 to 140"),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("High"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("> 140"),
                      ),
                    ]),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "Heart Rate Ranges",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColor,
                  ),
                ),
                const SizedBox(height: 10),
                Table(
                  border: TableBorder.all(color: Colors.grey),
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(1),
                  },
                  children:const [
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("Category", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("Range (BPM)", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("Low"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("< 60"),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("Normal"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("60 to 100"),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("High"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("> 100"),
                      ),
                    ]),
                  ],
                ),
                const Divider(height: 20, color: Colors.grey),

                const Text(
                  "Heart Rate (HR)",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColor,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "- Infancy (Birth to 1 year): 100 to 160 beats per minute (stabilizes around 120 bpm within the first 30 minutes).\n"
                      "- Toddlers (12–36 months) & Preschoolers (3–5 years): 80 to 130 beats per minute.\n"
                      "- School-aged Children (6–12 years): 70 to 110 beats per minute.\n"
                      "- Adolescents (13–18 years): 55 to 105 beats per minute.\n"
                      "- Young Adults (20–40 years): Average: 70 beats per minute.\n"
                      "- Middle Age (41–60 years): Average: 70 beats per minute.\n"
                      "- Elderly (61 years and above): Depends on the individual’s physical and health condition.",
                  style: TextStyle(fontSize: 16),
                ),
                const Divider(height: 20, color: Colors.grey),
                const Text(
                  "How to Measure Blood Pressure Manually",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColor,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "1. Roll up the sleeve on the right arm and locate the pulse of the artery.\n"
                      "2. Place the cuff on the arm, centering it above the artery and just above the elbow.\n"
                      "3. Position the stethoscope over the artery pulse and place the earpieces in your ears.\n"
                      "4. Inflate the cuff quickly to 200 mmHg and then slowly release the pressure.\n"
                      "5. Note the first sound (systolic pressure) and the last sound (diastolic pressure).",
                  style: TextStyle(fontSize: 16),
                ),
                const Divider(height: 20, color: Colors.grey),
                const Text(
                  "Pulse Rate",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColor,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "- Infancy (Birth to 1 year): From 70 bpm at birth to 90 bpm at one year.\n"
                      "- Toddlers (12–36 months) & Preschoolers (3–5 years): 80–110 bpm.\n"
                      "- School-aged Children (6–12 years): 80–120 bpm.\n"
                      "- Adolescents (13–18 years): 100–120 bpm.\n"
                      "- Young Adults (20–40 years): Average blood pressure: 120/80 mmHg.\n"
                      "- Middle Age (41–60 years): Average blood pressure: 120/80 mmHg.\n"
                      "- Elderly (61 years and above): Depends on the individual’s physical and health condition.",
                  style: TextStyle(fontSize: 16),
                ),
                const Divider(height: 20, color: Colors.grey),
                const Divider(height: 20, color: Colors.grey),
                const Text(
                  "How to Measure Pulse Rate",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColor,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "1. Using your index and middle fingers, locate the radial artery on the wrist (between the bone and tendon on the thumb side).\n"
                      "2. Apply gentle pressure until you feel the pulse.\n"
                      "3. Count the beats for 30 seconds and multiply by 2 to calculate beats per minute (BPM).\n"
                      "- If irregularities are noticed, count for a full minute.",
                  style: TextStyle(fontSize: 16),
                ),
                const Divider(height: 20, color: Colors.grey),
                const Text(
                  "How to Measure Blood Glucose Levels",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColor,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "For individuals with diabetes:\n"
                      "People monitor their blood glucose levels by pricking their fingers using a blood glucose meter or a continuous glucose monitor (CGM).\n\n"
                      "Steps for Using a Blood Glucose Meter:\n"
                      "1. Wash your hands thoroughly.\n"
                      "2. Insert the test strip into the device.\n"
                      "3. Use a lancet device to prick the side of your finger to obtain a drop of blood.\n"
                      "4. Touch the edge of the test strip to the drop of blood and wait for the reading.\n"
                      "5. The result will be displayed on the device screen.",
                  style: TextStyle(fontSize: 16),
                ),
                const Divider(height: 20, color: Colors.grey),
                const Text(
                  "Blood Pressure by Age Group",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColor,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Minimum Values",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColor2,
                  ),
                ),
                const SizedBox(height: 10),
                Table(
                  border: TableBorder.all(color: Colors.grey),
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(1),
                  },
                  children:const [
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("Age Group", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("Blood Pressure (mmHg)", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("1–12 months"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("75/50"),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("1–5 years"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("80/55"),
                      ),
                    ]),
                    // Add other rows for Minimum Values here...
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "Normal Values",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColor2,
                  ),
                ),
                const SizedBox(height: 10),
                Table(
                  border: TableBorder.all(color: Colors.grey),
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(1),
                  },
                  children:const [
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("Age Group", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("Blood Pressure (mmHg)", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("1–12 months"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("90/60"),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("1–5 years"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("95/65"),
                      ),
                    ]),
                    // Add other rows for Normal Values here...
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "Maximum Values",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColor2,
                  ),
                ),
                const SizedBox(height: 10),
                Table(
                  border: TableBorder.all(color: Colors.grey),
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(1),
                  },
                  children: const[
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("Age Group", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("Blood Pressure (mmHg)", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("1–12 months"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("110/75"),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("1–5 years"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("110/79"),
                      ),
                    ]),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}