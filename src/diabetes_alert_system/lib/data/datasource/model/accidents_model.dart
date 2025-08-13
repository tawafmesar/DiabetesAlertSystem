class accidents_model {
  int? accidentsId;
  String? accidentsLatitude;
  String? accidentsLongitude;
  String? accidentsSeverity;
  String? accidentsDescription;
  String? accidentsMethod;
  String? accidentsStatus;
  String? accidentsTime;
  int? usersId;
  String? usersName;
  String? usersEmail;
  String? usersPhone;

  accidents_model(
      {this.accidentsId,
        this.accidentsLatitude,
        this.accidentsLongitude,
        this.accidentsSeverity,
        this.accidentsDescription,
        this.accidentsMethod,
        this.accidentsStatus,
        this.accidentsTime,
        this.usersId,
        this.usersName,
        this.usersEmail,
        this.usersPhone});

  accidents_model.fromJson(Map<String, dynamic> json) {
    accidentsId = json['accidents_id'];
    accidentsLatitude = json['accidents_latitude'];
    accidentsLongitude = json['accidents_longitude'];
    accidentsSeverity = json['accidents_severity'];
    accidentsDescription = json['accidents_description'];
    accidentsMethod = json['accidents_method'];
    accidentsStatus = json['accidents_status'];
    accidentsTime = json['accidents_time'];
    usersId = json['users_id'];
    usersName = json['users_name'];
    usersEmail = json['users_email'];
    usersPhone = json['users_phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accidents_id'] = this.accidentsId;
    data['accidents_latitude'] = this.accidentsLatitude;
    data['accidents_longitude'] = this.accidentsLongitude;
    data['accidents_severity'] = this.accidentsSeverity;
    data['accidents_description'] = this.accidentsDescription;
    data['accidents_method'] = this.accidentsMethod;
    data['accidents_status'] = this.accidentsStatus;
    data['accidents_time'] = this.accidentsTime;
    data['users_id'] = this.usersId;
    data['users_name'] = this.usersName;
    data['users_email'] = this.usersEmail;
    data['users_phone'] = this.usersPhone;
    return data;
  }
}