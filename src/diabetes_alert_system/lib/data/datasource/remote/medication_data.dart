import '../../../../core/class/crud.dart';
import '../../../../linkapi.dart';

class MedicationData {
  Crud crud;
  MedicationData(this.crud);
  postdata(String id ) async {
    var response = await crud.postData(AppLink.medicationview, {
      "id" : id ,
    });
    return response.fold((l) => l, (r) => r);
  }

  removedata(String id ) async {
    var response = await crud.postData(AppLink.medicationremove, {
      "id" : id ,
    });
    return response.fold((l) => l, (r) => r);
  }
  addmedicationdata(String id ,String name ,String classs ,String type ,String dosage,String frequency) async {
    var response = await crud.postData(AppLink.medicationadd, {
      "id" : id ,
      "name" : name  ,
      "classs" : classs ,
      "type" : type  ,
      "dosage" : dosage ,
      "frequency" : frequency  ,
    });
    return response.fold((l) => l, (r) => r);
  }

}
