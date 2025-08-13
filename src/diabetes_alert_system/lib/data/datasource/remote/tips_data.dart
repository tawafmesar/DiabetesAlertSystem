import '../../../../core/class/crud.dart';
import '../../../../linkapi.dart';

class TipsData {
  Crud crud;
  TipsData(this.crud);
  postdata() async {
    var response = await crud.postData(AppLink.tips_view, {});
    return response.fold((l) => l, (r) => r);
  }

  removedata(String id) async {
    var response = await crud.postData(AppLink.tips_remove, {
      "id" : id ,
    });    return response.fold((l) => l, (r) => r);
  }

  adddata(String title ,String content ) async {
    var response = await crud.postData(AppLink.tips_add, {
      "tips_title" : title ,
      "tips_content" : content  ,
    });
    return response.fold((l) => l, (r) => r);
  }


}