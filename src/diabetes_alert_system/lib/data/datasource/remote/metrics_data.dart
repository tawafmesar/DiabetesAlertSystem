import 'package:dartz/dartz.dart';
import '../../../../core/class/statusrequest.dart';
import '../../../../core/class/db_helper.dart';
import '../../../../core/class/crud.dart';

class MetricsData {
  DBHelper dbHelper = DBHelper();

  MetricsData(Crud crud);

  postdata(String id) async {
    try {
      // PHP: SELECT * FROM metrics WHERE user_id = ? ORDER BY metric_timestamp DESC
      var response = await dbHelper.rawQuery(
          "SELECT * FROM metrics ORDER BY metric_timestamp DESC");
      return Right({"status": "success", "data": response});
    } catch (e) {
      return const Left(StatusRequest.serverfailure);
    }
  }

  removedata(String id) async {
    try {
      var response = await dbHelper.rawDelete("DELETE FROM metrics WHERE id = ?", [id]);
      if (response > 0) {
        return const Right({"status": "success"});
      } else {
        return const Left(StatusRequest.serverfailure);
      }
    } catch (e) {
      return const Left(StatusRequest.serverfailure);
    }
  }

  addmetricsdata(String id, String metric_type, String value1, String value2) async {
    try {
      var response = await dbHelper.rawInsert(
          "INSERT INTO metrics (user_id, metric_type, value1, value2) VALUES (?, ?, ?, ?)",
          [id, metric_type, value1, value2]);

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
