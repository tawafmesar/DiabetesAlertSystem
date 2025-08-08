class notifications_model {
  int? notificationsId;
  int? usersId;
  String? notificationsMessage;
  String? notificationsTime;

  notifications_model(
      {this.notificationsId,
        this.usersId,
        this.notificationsMessage,
        this.notificationsTime});

  notifications_model.fromJson(Map<String, dynamic> json) {
    notificationsId = json['notifications_id'];
    usersId = json['users_id'];
    notificationsMessage = json['notifications_message'];
    notificationsTime = json['notifications_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notifications_id'] = this.notificationsId;
    data['users_id'] = this.usersId;
    data['notifications_message'] = this.notificationsMessage;
    data['notifications_time'] = this.notificationsTime;
    return data;
  }
}