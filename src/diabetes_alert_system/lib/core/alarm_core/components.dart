// This file includes outsourced widget components
import 'package:flutter/material.dart'; //Google Material Design assets
import '../../controller/alarm/alarm.dart';
import '../../controller/alarm/alarm_controller.dart';
import 'package:get/get.dart';

/// Show snackbar for the quiz
void showQuizSnackBar(BuildContext context, bool answerCorrect){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 1),
      content: Text(
          (answerCorrect) ? 'Correct answer!' : 'Wrong answer!',
          style: TextStyle(color: Colors.white)),
      backgroundColor: (answerCorrect) ? Colors.green : Colors.red,
    ),
  );
}


/// Show snackbar for alarm creation
void showAlarmCreationSnackBar(BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(milliseconds: 1500),
      content: Text('Alarm has been created.',
      ),
    ),
  );
}




/// Dialog component/widget to delete an alarm
class DialogResetAlarm extends StatefulWidget{

  final index;
  final alarmid;
  const DialogResetAlarm({Key? key, required this.index, this.alarmid}) : super(key: key);


  @override
  State<DialogResetAlarm> createState() => _MyDialogResetAlarmState();
}

class _MyDialogResetAlarmState extends State<DialogResetAlarm> {

  @override
  Widget build(BuildContext context) {
    final AlarmControllerImp controller = Get.put(AlarmControllerImp());

    return
      AlertDialog(
        title: Text('Delete alarm?'),
        content: Text(
            'You are about to delete this alarm.'),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pop(
                    context, 'CANCEL'),
            //close dialog
            child: Text('CANCEL'),
          ),
          TextButton(
            onPressed: () =>
            [
              //close dialog and delete alarm at the same time
              setState(() {
                print('widget.alarmid ====================');

                print(widget.alarmid);
                controller.remove(widget.alarmid);


                deleteAlarm(
                listOfSavedAlarms, widget.index);
              }),
              Navigator.pop(
                  context, 'DELETE'),
            ],
            child: Text('DELETE'),
          ),
        ],
      );
  }
}
