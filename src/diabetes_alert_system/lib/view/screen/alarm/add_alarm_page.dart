import 'package:flutter/material.dart'; // Google Material Design assets
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'dart:developer' as dev;
import 'package:weekday_selector/weekday_selector.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart'; // Added import
import '../../../controller/alarm/alarm.dart'; // Functions and more for the alarm
import '../../../controller/alarm/alarm_controller.dart';
import 'package:get/get.dart';

import '../../../core/class/handlingdataview.dart';
import '../../../core/constant/color.dart';
import '../../../core/functions/validinput.dart';
import '../../widget/auth/custom_auth_app_bar.dart';
import '../../widget/auth/customtextformauth.dart';
import '../../widget/custom_elevated_button.dart';

class AddAlarmPage extends StatefulWidget {
  const AddAlarmPage({Key? key}) : super(key: key);

  @override
  State<AddAlarmPage> createState() => _MyAddAlarmPageState();
}

class _MyAddAlarmPageState extends State<AddAlarmPage> {
  String? selectedOption;

  Time _chosenTime = Time(hour: DateTime.now().hour, minute: DateTime.now().minute);
  DateTime _chosenDate = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day + 1); // default today plus 1 day later
  List<bool> _chosenWeekdays = List.filled(7, false); // For weekday picker
  bool _challengingModeActive = false;
  bool _recurrentMode = false;

  // Text controller for the Alarm TextField.
  final _alarmNameController = TextEditingController(text: 'Medication alarm title');

  final AlarmControllerImp controller = Get.put(AlarmControllerImp());

  @override
  void dispose() {
    _alarmNameController.dispose();
    super.dispose();
  }

  /// Function to save the created/edited alarm
  Future<List<CustomAlarm?>> _saveAlarm(List<CustomAlarm?> currentAlarmList) async {
    String alarmTimeHour = _chosenTime.hour.toString().padLeft(2, '0');
    String alarmTimeMinute = _chosenTime.minute.toString().padLeft(2, '0');


    // Await the AddAlarms method and get the alarm_id
    String? alarmId = await controller.AddAlarms(
      'true',
      'false',
      _alarmNameController.text,
      alarmTimeHour,
      alarmTimeMinute,
      _chosenDate.toIso8601String(),
      _recurrentMode.toString(),
      _chosenWeekdays.toString(),
      _challengingModeActive.toString(),
    );

    if (alarmId != null) {
      print("Successfully added Alarm with ID: $alarmId");
    } else {
      print("Failed to add Alarm.");
    }
    print("_chosenWeekdays: ==========================");
    print(_chosenWeekdays);



    List<CustomAlarm?> alarmList = currentAlarmList;

    CustomAlarm? newCreatedAlarm = CustomAlarm(
      id: alarmId,
      isActive: true,
      isRinging: false,
      nameOfAlarm: _alarmNameController.text,
      alarmTime: _chosenTime,
      alarmDate: _chosenDate,
      isRecurrent: _recurrentMode,
      weekdayRecurrence: _chosenWeekdays,
      challengeMode: _challengingModeActive,
    );

    alarmList.add(newCreatedAlarm);


    listOfSavedAlarms = alarmList;

    await saveData();

    return alarmList;
  }

  /// Time selector using day_night_time_picker
  void _onTimeChanged(Time newTime) {
    setState(() {
      _chosenTime = newTime;
    });
  }

  void _selectTime() {
    Navigator.of(context).push(
      showPicker(
        context: context,
        value: _chosenTime,
        onChange: _onTimeChanged,
        minuteInterval: TimePickerInterval.ONE,
        is24HrFormat: false,
        // Optional parameters
        // For example, to add duskSpanInMinutes, you might need to extend or customize the picker
      ),
    );
  }

  void _selectDate() async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      locale: const Locale('en', 'GB'), // Start week on Monday
      initialDate: _chosenDate,
      firstDate: DateTime.now(), // Today
      lastDate: DateTime(DateTime.now().year + 5, DateTime.now().month, DateTime.now().day),
      helpText: 'Select a date',
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme:const ColorScheme.light(
              primary: AppColor.primaryColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColor.primaryColor2,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (newDate != null) {
      // Closes the menu and saves everything
      setState(() {
        _chosenDate = newDate;
        _recurrentMode = false; // If date is chosen and saved, set recurrent mode to false
        _chosenWeekdays = List.filled(7, false); // Reset weekdays
      });
    }
  }


  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Get.put(AlarmControllerImp());
    return Scaffold(

      appBar: const CustomAuthAppBar(
          title: 'Add an alarm',
          icon:  Icons.alarm_add,
          showBackButton:true
      )
      ,
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child: SingleChildScrollView( // Added to prevent overflow
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Select Time button
                  Expanded(
                    flex: 5,
                    child: CustomElevatedButton(
                      text: "Select Time",
                      radius: 12,
                      icon: Icons.access_time,
                      onPressed: _selectTime,
                    ),
                  ),

                  // Selected time display
                  Expanded(
                    flex: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: _selectTime,
                          behavior: HitTestBehavior.opaque,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Selected time:',
                              ),
                              const SizedBox(height: 6),
                              Text(
                                _chosenTime.format(context),
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
              ,
              SizedBox(height: 20),

             const Row(
                children: <Widget>[
                  Expanded(
                    child:  Text(
                      '\nPlease choose either a concrete date for the alarm or - if it is repetitive - choose the desired weekdays.\n',
                    ),
                  ),
                ],
              ),

              Row(
                // Date selector
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: CustomElevatedButton(
                      text: "Select Date",
                      radius: 12,
                      icon: Icons.calendar_today,
                      onPressed: _selectDate,
                    ),
                  )
                  ,
                  Expanded(
                    flex: 5,
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                      onTap: _selectDate,
                      behavior: HitTestBehavior.opaque,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Selected date:',
                            style: TextStyle(
                              color: _recurrentMode == false ? Colors.black : Colors.black26,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            DateFormat('MMMEd').format(_chosenDate),
                            style: TextStyle(
                              color: _recurrentMode == false ? Colors.black : Colors.black26,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                      ]
                    ),
                  ),
                ],
              ),
             const SizedBox(height: 20), // Added space

              Row(
                // Weekday picker
                children: <Widget>[
                  Expanded(
                    child: WeekdaySelector(
                      selectedFillColor:AppColor.primaryColor,
                      fillColor:  AppColor.backgroundcolor,
                      elevation: 3,
                      firstDayOfWeek: DateTime.saturday,
                      onChanged: (int day) {
                        setState(() {
                          final index = day % 7;
                          _chosenWeekdays[index] = !_chosenWeekdays[index];
                          // If any weekday is active, activate recurrent mode, otherwise not
                          if (_chosenWeekdays.any((e) => e == true)) {
                            _recurrentMode = true;
                          } else {
                            _recurrentMode = false;
                          }
                        });
                      },
                      values: _chosenWeekdays,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20), // Added space

              GetBuilder<AlarmControllerImp>(
                builder: (controller) => HandlingDataViewRequest(
                  statusRequest: controller.statusRequest,
                  widget: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        hintText: 'Select Medication Name',
                        labelText: "Medication Name",
                        suffixIcon: InkWell(child: Icon(FontAwesomeIcons.pills)),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      value: selectedOption,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedOption = newValue;
                          if (newValue != null) {
                            _alarmNameController.text = "$newValue Reminder";

                            controller.Medication_id.text = controller.MedicationsMap[newValue] ?? '';
                            controller.getMedications();
                          }
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a medication name';
                        }
                        return null;
                      },
                      items: controller.Medicationdata
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20), // Added space

              Row(
                children: <Widget>[
                  Expanded(
                    flex: 8,
                    child: Form(
                      key: _formKey,
                      child: CustonTextFormAuth(
                        isNumber: false,
                        valid: (val) => validInput(val!, 1, 50, "text"),
                        mycontroller: _alarmNameController,
                        hinttext: "Medication Alarm Title",
                        iconData: Icons.receipt,
                        labeltext: "Name of alarm",
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10), // Added space

              Row(
                // Toggle/Switch for Challenge Mode
                children: <Widget>[
                  Expanded(
                    flex: 8,
                    child: Text(
                      'Challenge mode',
                      style: TextStyle(
                        color: (_challengingModeActive == true) ? Colors.black : Colors.black38,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Switch(
                      value: _challengingModeActive,
                      activeColor: AppColor.primaryColor,
                      onChanged: (bool value) {
                        setState(() {
                          _challengingModeActive = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20), // Added space
              const Divider(),
              const SizedBox(height: 10), // Added space

              Row(
                children: <Widget>[
                  // Cancel button
                  Expanded(
                    flex: 40,
                    child: Center(
                      child: CustomElevatedButton(
                        text: "Cancel",
                        radius: 12,
                        icon: Icons.close,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),

                  const Expanded(
                    flex: 20,
                    child: Center(),
                  ),

                  // Confirm button
                  Expanded(
                    flex: 40,
                    child: Center(
                      child: CustomElevatedButton(
                        text: "Confirm",
                        radius: 12,
                        icon: Icons.check,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (selectedOption == null) {
                              Get.defaultDialog(
                                title: 'Notification',
                                middleText: 'Please select a medication name',
                              );
                              return;
                            }
                            _saveAlarm(listOfSavedAlarms);
                            saveData();
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              )
              ,

            ],
          ),
        ),
      ),
    );
  }
}
