import 'package:flutter/material.dart'; //Google Material Design assets
import 'package:intl/intl.dart';
import 'package:medicare/core/constant/color.dart';
import 'dart:async';
import 'dart:developer' as dev;
import 'package:shared_preferences/shared_preferences.dart'; // for saving/loading data for new start of the app
import 'dart:convert'; // for JSON etc.
import '../../../controller/alarm/alarm.dart'; // functions and more for the alarm
import '../../../controller/alarm/alarm_controller.dart';
import '../../../core/alarm_core/components.dart';
import '../../../core/alarm_core/global.dart'; // global variables and general outsourced stuff
import '../../../core/constant/imageasset.dart';
import 'add_alarm_page.dart'; // widget for the alarm adding
import 'package:get/get.dart';

class HomePageAlarmOverview extends StatefulWidget {
  const HomePageAlarmOverview({Key? key, required this.title})
      : super(key: key);

  // This widget is the homepage of the app. It has different states.
  final String title;

  @override
  State<HomePageAlarmOverview> createState() => _HomePageAlarmOverviewState();
}

class _HomePageAlarmOverviewState extends State<HomePageAlarmOverview> {

  bool isAM(TimeOfDay time) => time.hour < 12;

  DecorationImage getDayNightImage(TimeOfDay time) {
    return DecorationImage(
      image: AssetImage(isAM(time) ? AppImageAsset.sun : AppImageAsset.moon),
      fit: BoxFit.cover,
    );
  }

  String formatTimeTo12Hour(TimeOfDay time) {
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat("hh:mm a").format(dateTime);
  }


  DateTime _now = DateTime.now();
  String _dateString = DateFormat("MMMM dd, yyyy").format(DateTime.now());
  String _timeString = DateFormat("HH:mm:ss a").format(DateTime.now());
  final String currentTime = DateFormat('hh:mm a').format(DateTime.now());

  late DateTime alarmTimeAsDateTime;
  late DateTime threeSecondsAfterAlarm;

  // timer on order to ....
  late Timer _refreshTimer; // ...refresh the screen like for the current time
  late Timer _alarmCheckerTimer; // ...check for the alarm trigger status
  late Timer _saveDataTimer; // ...save/backup data regularly

  /// refresh the presented strings for the current time etc.
  void _updateTime() {
    setState(() {
      // setState causes the rerun of the build method
      _now = DateTime.now();
      _dateString = DateFormat("MMMM dd, yyyy").format(_now);
      _timeString = DateFormat("HH:mm:ss a").format(_now);
    });
  }

  /// check whether one of the alarms is triggered
  _alarmChecker(List<CustomAlarm?> currentAlarmList) {
    setState(() {
      // check whether there is any alarm that is the past and is not set to isRinging=False yet
      for (int i = 0; i < currentAlarmList.length; i++) {
        // first check whether the alarm is active
        if (currentAlarmList[i]!.isActive == true) {
          // case 1: single time alarm
          if (currentAlarmList[i]!.isRecurrent == false) {
            // the day has passed
            // +1 day because also the same day should be included
            if (currentAlarmList[i]!.alarmDate.isBefore(DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day + 1))) {
              // the time has passed (but not too long time ago, like 3 seconds)
              alarmTimeAsDateTime = DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                  currentAlarmList[i]!.alarmTime.hour,
                  currentAlarmList[i]!.alarmTime.minute);
              threeSecondsAfterAlarm = DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                  currentAlarmList[i]!.alarmTime.hour,
                  currentAlarmList[i]!.alarmTime.minute,
                  5);
              if ((DateTime.now().isAfter(alarmTimeAsDateTime)) &&
                  (DateTime.now().isBefore(threeSecondsAfterAlarm))) {
                //only if isRinging is still false, build the next page; otherwise it would be done several times leading to glitches
                if (currentAlarmList[i]!.isRinging == false) {
                  // start the alarm
                  alarmReaction(currentAlarmList[i], i, context, 'Single');
                  break; // break first for letting ring only one alarm if there are multiple
                  //return;
                }
              }
            }
          }

          // case 2: recurring alarm
          else if (currentAlarmList[i]!.isRecurrent == true) {
            // check whether today is one of the recurring days
            if (currentAlarmList[i]!.weekdayRecurrence[
            dateTimeRemapper(DateTime.now().weekday)] ==
                true) {
              // the time has passed (but not too long time ago, like 3 seconds)
              alarmTimeAsDateTime = DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                  currentAlarmList[i]!.alarmTime.hour,
                  currentAlarmList[i]!.alarmTime.minute);
              threeSecondsAfterAlarm = DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                  currentAlarmList[i]!.alarmTime.hour,
                  currentAlarmList[i]!.alarmTime.minute,
                  5);
              if ((DateTime.now().isAfter(alarmTimeAsDateTime)) &&
                  (DateTime.now().isBefore(threeSecondsAfterAlarm))) {
                //only if isRinging is still false, build the next page; otherwise it would be done several times leading to glitches
                if (currentAlarmList[i]!.isRinging == false) {
                  // start the alarm
                  alarmReaction(currentAlarmList[i], i, context, 'Recurrent');
                  break; // break first for letting ring only one alarm if there are multiple
                }
              }
            }
          }
        }
      }
    });
  }

  @override
  void initState() {
    // update the in the UI presented current time regularly
    _refreshTimer = Timer.periodic(everySecond, (Timer t) => _updateTime());

    // check for alarm status regularly
    _alarmCheckerTimer = Timer.periodic(
        everySecond, (Timer t) => _alarmChecker(listOfSavedAlarms));

    // backup data regularly (just in case)
    _saveDataTimer = Timer.periodic(every2Minutes, (Timer t) => saveData());

    loadData(); // load backup of alarm list
    stopAlarmSound(); // turn off sound from last start
    super.initState();
  }

  /// Loading the current alarm list on start
  Future<void> loadData() async {
    dev.log("Loading alarm data...", name: 'Alarm');
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (prefs.containsKey('alarmList')) {
        listOfSavedAlarms = (prefs.getStringList('alarmList') ?? [])
            .map((alarm) => CustomAlarm.fromJson(jsonDecode(alarm)))
            .toList();
        dev.log('Loaded ${listOfSavedAlarms.length} saved alarms.',
            name: 'Alarm');
      } else {
        dev.log('No saved alarms found.', name: 'Alarm');
      }
    });
  }

  @override
  void dispose() {
    //after timer is done, dispose it and it can be reused
    _refreshTimer.cancel();
    _alarmCheckerTimer.cancel();
    _saveDataTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(
        title: const Text("Alarm" ,       style: TextStyle(color: AppColor.white),
      ),
        backgroundColor: AppColor.primaryColor,
      )
      ,
      body: Container(
        child: ListView(
          //scrollable
          children: <Widget>[
            Column(
              children: <Widget>[
                // I need this single column to allow multiple rows
                Row(
                  // Row for the current date/time and the add alarm button
                  children: <Widget>[
                    Expanded(
                      // Col/Expanded for showing the current time and date
                      flex: 7, // 70%
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(

                                children: <Widget>[
                                  const Expanded(
                                    flex: 4,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Current time:',
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        currentTime,
                                        style: Theme.of(context).textTheme.titleLarge,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Row(
                              children: <Widget>[SizedBox(height: 15)],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  const Expanded(
                                    flex: 4,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child:  Text(
                                        'Current date:',
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        _dateString,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                      ),
                    ),
                  ],
                ),
                Divider(),
                const Row(
                  children: <Widget>[SizedBox(height: 40)],
                ),
                // Add some distance between the next row

                // List of alarms (for loop)
                for (int i = 0; i < listOfSavedAlarms.length; i++)
                  Dismissible(
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
                      return await showDialog<String>(
                        context: context,
                        builder: (BuildContext context) {
                          return DialogResetAlarm(index: i,alarmid:listOfSavedAlarms[i]?.id.toString() );
                        },
                      ).then((result) {

                        return result == 'DELETE';
                      });
                    },
                    onDismissed: (direction) async {
                      listOfSavedAlarms.removeAt(i);
                      await saveData();
                      loadData();
                      setState(() {});
                    },

                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Card(
                          elevation: 10,
                          margin: const EdgeInsets.all(20),
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
                                title: Text(
                                  "Alarm: ${listOfSavedAlarms[i]?.nameOfAlarm}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                subtitle:         Text(
                                  "Time: ${formatTimeTo12Hour(listOfSavedAlarms[i]?.alarmTime ?? TimeOfDay.now())}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                trailing: Switch(
                                  value: listOfSavedAlarms[i]?.isActive ?? false,
                                  activeColor: AppColor.primaryColor,
                                  onChanged: (bool value) {
                                    setState(() {
                                      listOfSavedAlarms[i]?.isActive = value;
                                      saveData();
                                    });
                                  },
                                ),

                              ),

                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                color: listOfSavedAlarms[i]?.isRecurrent == true
                                    ? AppColor.primaryColor
                                    : AppColor.secoundColor,
                                child: Align(
                                  heightFactor: 1.2,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    listOfSavedAlarms[i]?.isRecurrent == true
                                        ? "Recurs: ${weekdayBoolListToString(listOfSavedAlarms[i]!.weekdayRecurrence)}"
                                        : "Date: ${DateFormat('EEE, d MMM').format(listOfSavedAlarms[i]!.alarmDate)}",
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                            ],
                          ),
                        ),
                        Positioned(
                          top: -12,
                          left: 0,
                          right: 0,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Container(
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
                                    listOfSavedAlarms[i]?.isActive == true
                                        ? AppImageAsset.alarmactive
                                        : AppImageAsset.alarmnotactive,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ,

                const Row(
                  // Add some space
                  children: <Widget>[
                    SizedBox(height: 60),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),floatingActionButton: FloatingActionButton(
      heroTag: "addAlarmButton",
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
              const AddAlarmPage()),
        );
      },
      child: Icon(Icons.alarm_add),
      backgroundColor: AppColor.primaryColor,
    ),
    );
  }
}
