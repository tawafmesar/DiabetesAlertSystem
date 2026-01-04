import 'package:dartz/dartz.dart';
import '../../../../core/class/statusrequest.dart';
import '../../../../core/class/db_helper.dart';

class MedicationData {
  DBHelper dbHelper = DBHelper();

  MedicationData(dynamic crud); // Keeping constructor signature compatible but ignoring crud

  postdata(String id) async {
    try {
      // id is users_id, but since we are local and bypassing auth, we might ignore it or use a default user id.
      // However, to keep it compatible with existing logic, we can query by user_id if we decide to keep it.
      // For now, let's just return all medications or filter by a mocked user id if provided.
      // The original PHP query: SELECT * FROM medications WHERE user_id = ? ORDER BY medication_date_create DESC

      var response = await dbHelper.rawQuery(
          "SELECT * FROM medications ORDER BY medication_date_create DESC"); // Ignoring user_id for now as we are removing auth

      return Right({"status": "success", "data": response});
    } catch (e) {
      return const Left(StatusRequest.serverfailure);
    }
  }

  removedata(String id) async {
    try {
      var response = await dbHelper.rawDelete("DELETE FROM medications WHERE id = ?", [id]);
      if (response > 0) {
         return const Right({"status": "success"});
      } else {
         return const Left(StatusRequest.serverfailure);
      }
    } catch (e) {
      return const Left(StatusRequest.serverfailure);
    }
  }

  addmedicationdata(String id, String name, String classs, String type, String dosage, String frequency) async {
    try {
      // id is user_id
      var response = await dbHelper.rawInsert(
          "INSERT INTO medications (users_id, name, class, type, dosage, frequency) VALUES (?, ?, ?, ?, ?, ?)",
          [id, name, classs, type, dosage, frequency]);

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
