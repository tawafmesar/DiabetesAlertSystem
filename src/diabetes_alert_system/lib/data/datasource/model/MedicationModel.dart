class MedicationModel {
  int? medicationId;
  String? medicationName;
  String? medicationClass;
  String? medicationType;
  String? medicationDosage;
  String? medicationFrequency;
  String? medicationHealthCondition;
  String? medicationDateCreate;
  int? userId;
  String? userName;
  String? userEmail;
  String? userPhone;

  MedicationModel(
      {this.medicationId,
        this.medicationName,
        this.medicationClass,
        this.medicationType,
        this.medicationDosage,
        this.medicationFrequency,
        this.medicationHealthCondition,
        this.medicationDateCreate,
        this.userId,
        this.userName,
        this.userEmail,
        this.userPhone});

  MedicationModel.fromJson(Map<String, dynamic> json) {
    medicationId = json['medication_id'];
    medicationName = json['medication_name'];
    medicationClass = json['medication_class'];
    medicationType = json['medication_type'];
    medicationDosage = json['medication_dosage'];
    medicationFrequency = json['medication_frequency'];
    medicationHealthCondition = json['medication_health_condition'];
    medicationDateCreate = json['medication_date_create'];
    userId = json['user_id'];
    userName = json['user_name'];
    userEmail = json['user_email'];
    userPhone = json['user_phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['medication_id'] = this.medicationId;
    data['medication_name'] = this.medicationName;
    data['medication_class'] = this.medicationClass;
    data['medication_type'] = this.medicationType;
    data['medication_dosage'] = this.medicationDosage;
    data['medication_frequency'] = this.medicationFrequency;
    data['medication_health_condition'] = this.medicationHealthCondition;
    data['medication_date_create'] = this.medicationDateCreate;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['user_email'] = this.userEmail;
    data['user_phone'] = this.userPhone;
    return data;
  }
}