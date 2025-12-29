import '../../../../core/class/crud.dart';
import '../../../../linkapi.dart';

class HomeStaticsData {
  Crud crud;
  HomeStaticsData(this.crud);
  postdata(String id ) async {
    var response = await crud.postData(AppLink.homestaticsview, {
      "id" : id ,
    });
    return response.fold((l) => l, (r) => r);
  }

}
