import 'package:dartz/dartz.dart';
import '../../../../core/class/statusrequest.dart';
import '../../../../core/class/db_helper.dart';
import '../../../../core/class/crud.dart';

class AlarmsData {
  DBHelper dbHelper = DBHelper();

  AlarmsData(Crud crud);

  Future addAlarmsData({
    required String isActive,
    required String isRinging,
    required String nameOfAlarm,
    required String alarmTimeHour,
    required String alarmTimeMinute,
    required String alarmDate,
    required String isRecurrent,
    required String weekdayRecurrence,
    required String challengeMode,
    required String usersId,
    required String medicationsId,
  }) async {
    try {
      var response = await dbHelper.rawInsert(
        '''
        INSERT INTO alarms (
          is_active, is_ringing, name_of_alarm, alarm_time_hour, alarm_time_minute,
          alarm_date, is_recurrent, weekday_recurrence, challenge_mode, users_id, medications_id
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ''',
        [
          isActive, isRinging, nameOfAlarm, alarmTimeHour, alarmTimeMinute,
          alarmDate, isRecurrent, weekdayRecurrence, challengeMode, usersId, medicationsId
        ]
      );

      if (response > 0) {
        return Right({"status": "success", "alarm_id": response});
      } else {
        return const Left(StatusRequest.serverfailure);
      }
    } catch (e) {
      return const Left(StatusRequest.serverfailure);
    }
  }

  removedata(String id) async {
    try {
      var response = await dbHelper.rawDelete("DELETE FROM alarms WHERE id = ?", [id]);
      if (response > 0) {
        return const Right({"status": "success"});
      } else {
        return const Left(StatusRequest.serverfailure);
      }
    } catch (e) {
      return const Left(StatusRequest.serverfailure);
    }
  }

  removealldata(String id) async {
    try {
      var response = await dbHelper.rawDelete("DELETE FROM alarms"); // removing all alarms, ignoring user id
      if (response > 0) {
        return const Right({"status": "success"});
      } else {
         // If no rows deleted (maybe table empty), still success?
         // But rawDelete returns count. If 0, it might be fine if table was empty.
         // But let's assume success.
         return const Right({"status": "success"});
      }
    } catch (e) {
      return const Left(StatusRequest.serverfailure);
    }
  }
}
