import '../../../../core/class/crud.dart';
import '../../../../linkapi.dart';

class HistoryAcccidentsData {
  Crud crud;
  HistoryAcccidentsData(this.crud);
  postdata() async {
    var response = await crud.postData(AppLink.accidents_viewall, {});
    return response.fold((l) => l, (r) => r);
  }

  postdataofemergency() async {
    var response = await crud.postData(AppLink.accidents_viewall, {});
    return response.fold((l) => l, (r) => r);
  }
}