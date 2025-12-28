import '../../../../core/class/crud.dart';
import '../../../../linkapi.dart';

class ActivityData {
  Crud crud;
  ActivityData(this.crud);
  postdata(String user_id ) async {
    var response = await crud.postData(AppLink.activityview, {
      "user_id" : user_id ,
    });
    return response.fold((l) => l, (r) => r);
  }

  removedata(String id ) async {
    var response = await crud.postData(AppLink.activityremove, {
      "id" : id ,
    });
    return response.fold((l) => l, (r) => r);
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
    var response = await crud.postData(AppLink.activityadd, {
      "user_id": user_id,
      "category": category,
      "activity_type": activity_type,
      "duration_hours": duration_hours,
      "duration_minutes": duration_minutes,
      "duration_seconds": duration_seconds,
      "user_weight": user_weight,
      "calories_burned": calories_burned,
    });

    return response.fold((l) => l, (r) => r);
  }

}
