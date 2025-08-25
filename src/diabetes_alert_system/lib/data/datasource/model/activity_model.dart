class ActivityModel {
  int? activityId;
  String? category;
  String? activityType;
  int? userWeight;
  double? caloriesBurned;
  String? activityDate;
  int? usersId;
  String? usersName;
  String? usersEmail;
  String? usersPhone;
  int? durationHours;
  int? durationMinutes;
  int? durationSeconds;

  ActivityModel({
    this.activityId,
    this.category,
    this.activityType,
    this.userWeight,
    this.caloriesBurned,
    this.activityDate,
    this.usersId,
    this.usersName,
    this.usersEmail,
    this.usersPhone,
    this.durationHours,
    this.durationMinutes,
    this.durationSeconds,
  });

  ActivityModel.fromJson(Map<String, dynamic> json) {
    activityId = json['activity_id'];
    category = json['category'];
    activityType = json['activity_type'];
    userWeight = json['user_weight'];
    caloriesBurned = json['calories_burned']?.toDouble();
    activityDate = json['activity_date'];
    usersId = json['users_id'];
    usersName = json['users_name'];
    usersEmail = json['users_email'];
    usersPhone = json['users_phone'];
    durationHours = json['duration_hours'];
    durationMinutes = json['duration_minutes'];
    durationSeconds = json['duration_seconds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['activity_id'] = activityId;
    data['category'] = category;
    data['activity_type'] = activityType;
    data['user_weight'] = userWeight;
    data['calories_burned'] = caloriesBurned;
    data['activity_date'] = activityDate;
    data['users_id'] = usersId;
    data['users_name'] = usersName;
    data['users_email'] = usersEmail;
    data['users_phone'] = usersPhone;
    data['duration_hours'] = durationHours;
    data['duration_minutes'] = durationMinutes;
    data['duration_seconds'] = durationSeconds;
    return data;
  }
}
