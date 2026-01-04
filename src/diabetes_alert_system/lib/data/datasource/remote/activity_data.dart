import 'package:dartz/dartz.dart';
import '../../../../core/class/statusrequest.dart';
import '../../../../core/class/db_helper.dart';

class ActivityData {
  DBHelper dbHelper = DBHelper();

  ActivityData(dynamic crud);

  postdata(String user_id) async {
    try {
      // PHP: SELECT * FROM activities WHERE user_id = ? ORDER BY activity_date DESC
      var response = await dbHelper.rawQuery(
          "SELECT * FROM activities ORDER BY activity_date DESC");
      return Right({"status": "success", "data": response});
    } catch (e) {
      return const Left(StatusRequest.serverfailure);
    }
  }

  removedata(String id) async {
    try {
      var response = await dbHelper.rawDelete("DELETE FROM activities WHERE id = ?", [id]);
      if (response > 0) {
        return const Right({"status": "success"});
      } else {
        return const Left(StatusRequest.serverfailure);
      }
    } catch (e) {
      return const Left(StatusRequest.serverfailure);
    }
  }

  addActivityData(
      String user_id,
      String category,
      String activity_type,
      String duration_hours,
      String duration_minutes,
      String duration_seconds,
      String user_weight,
      String calories_burned
      ) async {
    try {
      var response = await dbHelper.rawInsert(
        '''
        INSERT INTO activities (
          user_id, category, activity_type, duration_hours, duration_minutes,
          duration_seconds, user_weight, calories_burned
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        ''',
        [
          user_id, category, activity_type, duration_hours, duration_minutes,
          duration_seconds, user_weight, calories_burned
        ]
      );

      if (response > 0) {
        return const Right({"status": "success"});
      } else {
        return const Left(StatusRequest.serverfailure);
      }
    } catch (e) {
      return const Left(StatusRequest.serverfailure);
    }
  }
}
