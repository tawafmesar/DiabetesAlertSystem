class MetricsModel {
  int? metricId;
  int? userId;
  String? metricType;
  String? metricValue1;
  String? metricValue2;
  String? metricTimestamp;
  String? userName;
  String? userEmail;
  String? userPhone;

  MetricsModel(
      {this.metricId,
        this.userId,
        this.metricType,
        this.metricValue1,
        this.metricValue2,
        this.metricTimestamp,
        this.userName,
        this.userEmail,
        this.userPhone});

  MetricsModel.fromJson(Map<String, dynamic> json) {
    metricId = json['metric_id'];
    userId = json['user_id'];
    metricType = json['metric_type'];
    metricValue1 = json['metric_value1'];
    metricValue2 = json['metric_value2'];
    metricTimestamp = json['metric_timestamp'];
    userName = json['user_name'];
    userEmail = json['user_email'];
    userPhone = json['user_phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['metric_id'] = this.metricId;
    data['user_id'] = this.userId;
    data['metric_type'] = this.metricType;
    data['metric_value1'] = this.metricValue1;
    data['metric_value2'] = this.metricValue2;
    data['metric_timestamp'] = this.metricTimestamp;
    data['user_name'] = this.userName;
    data['user_email'] = this.userEmail;
    data['user_phone'] = this.userPhone;
    return data;
  }
}