import 'package:flutter/material.dart'; // Google Material Design assets
import 'package:intl/intl.dart';
import 'dart:async';
import '../../../controller/alarm/alarm.dart'; // functions and more for the alarm
import '../../../core/alarm_core/global.dart'; // global variables and general outsourced stuff
import '../../../core/constant/color.dart';
import '../../../core/constant/routes.dart';
import 'show_challenge_page.dart'; // widget for the challenge
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ShowAlarmPage extends StatefulWidget {
  final CustomAlarm? triggeredAlarm;
  final int alarmNumber;

  const ShowAlarmPage({Key? key, required this.triggeredAlarm, required this.alarmNumber}) : super(key: key);

  @override
  State<ShowAlarmPage> createState() => _MyShowAlarmPageState();
}

class _MyShowAlarmPageState extends State<ShowAlarmPage> {

  // init the vars, otherwise they will show NULL in the UI in the beginning
  DateTime _now = DateTime.now();
  String _dateString = DateFormat("EEEE, MMMM dd").format(DateTime.now());
  String _timeStringShort = DateFormat("HH:mm").format(DateTime.now());

  // timer to refresh the screen like for the current time
  late Timer _refreshTimer;

  /// refresh the presented strings for the current time etc.
  void _updateTime() {
    setState(() {
      // setState tells the Flutter framework that something has changed in this state, which causes it to rerun the build method
      _now = DateTime.now();
      _dateString = DateFormat("EEEE, MMMM dd").format(_now);
      _timeStringShort = DateFormat("HH:mm").format(_now);
    });
  }

  /// function to deactivate an alarm
  List<CustomAlarm?> _deactivateAlarm(CustomAlarm? triggeredAlarm, alarmIndex) {
    return deactivateAlarm(triggeredAlarm, alarmIndex);
  }

  @override
  void initState() {
    _refreshTimer = Timer.periodic(everySecond, (Timer t) => _updateTime());
    super.initState();
  }

  @override
  void dispose() {
    _refreshTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColor.backgroundcolor,
        body: Container(
          margin: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 70),
              Center(
                child: Text(
                  "Alarm",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  "${widget.triggeredAlarm?.nameOfAlarm}",
                  style: const TextStyle(
                    color: AppColor.primaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 30), // Adjusted spacing

              // Animated Icon with Text
              Column(
                children: [
                  FaIcon(
                    FontAwesomeIcons.pills,
                    color: AppColor.primaryColor,
                    size: 60,
                  )
                      .animate(
                    // Apply a pulsating animation
                    onPlay: (controller) => controller.repeat(reverse: true),
                  )
                      .scale(
                    duration: 800.ms,

                    curve: Curves.easeInOut,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Time to take your medication",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                      .animate(
                    onPlay: (controller) => controller.repeat(reverse: true),
                  )
                      .fadeIn(duration: 800.ms)
                      .move(begin: Offset(0, 20), end: Offset(0, 0)),
                ],
              ),

              const SizedBox(height: 50), // Adjusted spacing
              Center(
                child: const Text(
                  "It's",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Center(
                child: Text(
                  _timeStringShort,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 60,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  _dateString,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 80),
              Center(
                child: ElevatedButton(
                  style: TextButton.styleFrom(
                    backgroundColor: AppColor.primaryColor,
                  ),
                  onPressed: () {
                    if (widget.triggeredAlarm?.challengeMode == true) {
                      // Challenge mode
                      playAlarmSound(0.1); // Make alarm a bit more silent
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShowChallengePage(
                            triggeredAlarm: widget.triggeredAlarm,
                            alarmNumber: widget.alarmNumber,
                          ),
                        ),
                      );
                    } else {
                      // No challenge mode
                      _deactivateAlarm(widget.triggeredAlarm, widget.alarmNumber);
                    //TODO Add Get.offNamed(AppRoute.homepage);
                    }
                  },
                  child: const Text(
                    'Stop',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
