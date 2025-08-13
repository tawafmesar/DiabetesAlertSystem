import '../../../../core/class/crud.dart';
import '../../../../linkapi.dart';

class NotificationsData {
  Crud crud;
  NotificationsData(this.crud);
  postdata(String id ) async {
    var response = await crud.postData(AppLink.notifications_view, {
      "id" : id ,
    });    return response.fold((l) => l, (r) => r);
  }

  adddata(String accidents_id ,String notifications_message,String accidents_status  ) async {
    var response = await crud.postData(AppLink.notifications_add, {
      "accidents_id" : accidents_id ,
      "notifications_message" : notifications_message  ,
      "accidents_status" : accidents_status  ,

    });
    return response.fold((l) => l, (r) => r);
  }

  removedata(String id) async {
    var response = await crud.postData(AppLink.notifications_remove, {
      "id" : id ,
    });    return response.fold((l) => l, (r) => r);
  }

}