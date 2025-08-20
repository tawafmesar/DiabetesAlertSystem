import '../../../../core/class/crud.dart';
import '../../../../linkapi.dart';

class AlarmsData {
  Crud crud;
  AlarmsData(this.crud);

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
    // Prepare the data map to be sent to the API
    var data = {
      "is_active": isActive,
      "is_ringing": isRinging,
      "name_of_alarm": nameOfAlarm,
      "alarm_time_hour": alarmTimeHour,
      "alarm_time_minute": alarmTimeMinute,
      "alarm_date": alarmDate,
      "is_recurrent": isRecurrent,
      "weekday_recurrence": weekdayRecurrence, // assuming it's a JSON string
      "challenge_mode": challengeMode,
      "users_id": usersId,
      "medications_id": medicationsId,
    };

    // Call the API endpoint to add alarm data
    var response = await crud.postData(AppLink.alarmsadd, data);

    // Return the response
    return response.fold((l) => l, (r) => r);
  }

  removedata(String id ) async {
    var response = await crud.postData(AppLink.alarmsremove, {
      "id" : id ,
    });
    return response.fold((l) => l, (r) => r);
  }
  removealldata(String id ) async {
    var response = await crud.postData(AppLink.alarmsremoveall, {
      "id" : id ,
    });
    return response.fold((l) => l, (r) => r);
  }

}
