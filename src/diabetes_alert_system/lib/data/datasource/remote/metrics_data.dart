import '../../../../core/class/crud.dart';
import '../../../../linkapi.dart';

class MetricsData {
  Crud crud;
  MetricsData(this.crud);
  postdata(String id ) async {
    var response = await crud.postData(AppLink.metricsview, {
      "id" : id ,
    });
    return response.fold((l) => l, (r) => r);
  }

  removedata(String id ) async {
    var response = await crud.postData(AppLink.metricsremove, {
      "id" : id ,
    });
    return response.fold((l) => l, (r) => r);
  }

  addmetricsdata(String id ,String metric_type ,String value1 ,String value2 ) async {
    var response = await crud.postData(AppLink.metricsreadd, {
      "id" : id ,
      "metric_type" : metric_type  ,
      "value1" : value1 ,
      "value2" : value2  ,
    });
    return response.fold((l) => l, (r) => r);
  }

}
