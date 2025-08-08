import '../../../../core/class/crud.dart';
import '../../../../linkapi.dart';

class AccidentsData {
  Crud crud;
  AccidentsData(this.crud);
  postdata(String users_id ,
      String accidents_latitude ,
      String accidents_longitude ,
      String accidents_severity,
      String accidents_method,
      String accidents_description) async {
    var response = await crud.postData(AppLink.accidents_add, {
      "users_id" : users_id ,
      "accidents_latitude" : accidents_latitude  ,
      "accidents_longitude" : accidents_longitude ,
      "accidents_severity" : accidents_severity  ,
      "accidents_method" : accidents_method ,
      "accidents_description" : accidents_description ,

    });
    return response.fold((l) => l, (r) => r);
  }
}