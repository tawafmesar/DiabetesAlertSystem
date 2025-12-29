double? _toDouble(dynamic v) {
  if (v == null) return null;
  if (v is double) return v;
  if (v is int) return v.toDouble();
  if (v is num) return v.toDouble();
  if (v is String) return double.tryParse(v);
  return null;
}

class HomeStatics {
  MetricsGrouped? metricsGrouped;
  List<AverageMetrics>? averageMetrics;
  int? alarmsCount;
  int? medicationCount;
  Activities? activities;
  String? generatedAt;

  HomeStatics(
      {this.metricsGrouped,
        this.averageMetrics,
        this.alarmsCount,
        this.medicationCount,
        this.activities,
        this.generatedAt});

  HomeStatics.fromJson(Map<String, dynamic> json) {
    metricsGrouped = json['metrics_grouped'] != null
        ? new MetricsGrouped.fromJson(json['metrics_grouped'])
        : null;
    if (json['average_metrics'] != null) {
      averageMetrics = <AverageMetrics>[];
      json['average_metrics'].forEach((v) {
        averageMetrics!.add(new AverageMetrics.fromJson(v));
      });
    }
    alarmsCount = json['alarms_count'];
    medicationCount = json['medication_count'];
    activities = json['activities'] != null
        ? new Activities.fromJson(json['activities'])
        : null;
    generatedAt = json['generated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.metricsGrouped != null) {
      data['metrics_grouped'] = this.metricsGrouped!.toJson();
    }
    if (this.averageMetrics != null) {
      data['average_metrics'] =
          this.averageMetrics!.map((v) => v.toJson()).toList();
    }
    data['alarms_count'] = this.alarmsCount;
    data['medication_count'] = this.medicationCount;
    if (this.activities != null) {
      data['activities'] = this.activities!.toJson();
    }
    data['generated_at'] = this.generatedAt;
    return data;
  }
}

class MetricsGrouped {
  List<BloodPressure>? bloodPressure;
  List<HeartRate>? heartRate;
  List<BloodSugar>? bloodSugar;

  MetricsGrouped({this.bloodPressure, this.heartRate, this.bloodSugar});

  MetricsGrouped.fromJson(Map<String, dynamic> json) {
    if (json['Blood Pressure'] != null) {
      bloodPressure = <BloodPressure>[];
      json['Blood Pressure'].forEach((v) {
        bloodPressure!.add(new BloodPressure.fromJson(v));
      });
    }
    if (json['Heart Rate'] != null) {
      heartRate = <HeartRate>[];
      json['Heart Rate'].forEach((v) {
        heartRate!.add(new HeartRate.fromJson(v));
      });
    }
    if (json['Blood Sugar'] != null) {
      bloodSugar = <BloodSugar>[];
      json['Blood Sugar'].forEach((v) {
        bloodSugar!.add(new BloodSugar.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bloodPressure != null) {
      data['Blood Pressure'] =
          this.bloodPressure!.map((v) => v.toJson()).toList();
    }
    if (this.heartRate != null) {
      data['Heart Rate'] = this.heartRate!.map((v) => v.toJson()).toList();
    }
    if (this.bloodSugar != null) {
      data['Blood Sugar'] = this.bloodSugar!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BloodPressure {
  int? value1;
  int? value2;
  String? timestamp;
  String? status;

  BloodPressure({this.value1, this.value2, this.timestamp, this.status});

  BloodPressure.fromJson(Map<String, dynamic> json) {
    value1 = json['value1'];
    value2 = json['value2'];
    timestamp = json['timestamp'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value1'] = this.value1;
    data['value2'] = this.value2;
    data['timestamp'] = this.timestamp;
    data['status'] = this.status;
    return data;
  }
}

class HeartRate {
  int? value1;
  dynamic value2;
  String? timestamp;
  String? status;

  HeartRate({this.value1, this.value2, this.timestamp, this.status});

  HeartRate.fromJson(Map<String, dynamic> json) {
    value1 = json['value1'];
    value2 = json['value2'];
    timestamp = json['timestamp'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value1'] = this.value1;
    data['value2'] = this.value2;
    data['timestamp'] = this.timestamp;
    data['status'] = this.status;
    return data;
  }
}

class BloodSugar {
  int? value1; // sugar value (e.g., mg/dL)
  String? timestamp;
  String? status;

  BloodSugar({this.value1, this.timestamp, this.status});

  BloodSugar.fromJson(Map<String, dynamic> json) {
    value1 = json['value1'];
    timestamp = json['timestamp'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value1'] = this.value1;
    data['timestamp'] = this.timestamp;
    data['status'] = this.status;
    return data;
  }
}

class AverageMetrics {
  String? label;
  double? value;

  AverageMetrics({this.label, this.value});

  AverageMetrics.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    // Use helper to accept int, double, or numeric-string values from JSON
    value = _toDouble(json['value']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['value'] = this.value;
    return data;
  }
}

class Activities {
  int? totalActivities;
  double? totalCalories;
  int? totalDurationSeconds;
  double? averageCaloriesPerActivity;
  String? lastActivityDate;
  List<ByType>? byType;
  List<Recent>? recent;
  List<Last7Days>? last7Days;

  Activities(
      {this.totalActivities,
        this.totalCalories,
        this.totalDurationSeconds,
        this.averageCaloriesPerActivity,
        this.lastActivityDate,
        this.byType,
        this.recent,
        this.last7Days});

  Activities.fromJson(Map<String, dynamic> json) {
    totalActivities = json['total_activities'];
    totalCalories = _toDouble(json['total_calories']);
    totalDurationSeconds = json['total_duration_seconds'];
    averageCaloriesPerActivity =
        _toDouble(json['average_calories_per_activity']);
    lastActivityDate = json['last_activity_date'];
    if (json['by_type'] != null) {
      byType = <ByType>[];
      json['by_type'].forEach((v) {
        byType!.add(new ByType.fromJson(v));
      });
    }
    if (json['recent'] != null) {
      recent = <Recent>[];
      json['recent'].forEach((v) {
        recent!.add(new Recent.fromJson(v));
      });
    }
    if (json['last_7_days'] != null) {
      last7Days = <Last7Days>[];
      json['last_7_days'].forEach((v) {
        last7Days!.add(new Last7Days.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_activities'] = this.totalActivities;
    data['total_calories'] = this.totalCalories;
    data['total_duration_seconds'] = this.totalDurationSeconds;
    data['average_calories_per_activity'] = this.averageCaloriesPerActivity;
    data['last_activity_date'] = this.lastActivityDate;
    if (this.byType != null) {
      data['by_type'] = this.byType!.map((v) => v.toJson()).toList();
    }
    if (this.recent != null) {
      data['recent'] = this.recent!.map((v) => v.toJson()).toList();
    }
    if (this.last7Days != null) {
      data['last_7_days'] = this.last7Days!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ByType {
  String? activityType;
  int? count;
  double? calories;
  int? durationSeconds;

  ByType({this.activityType, this.count, this.calories, this.durationSeconds});

  ByType.fromJson(Map<String, dynamic> json) {
    activityType = json['activity_type'];
    count = json['count'];
    calories = _toDouble(json['calories']);
    durationSeconds = json['duration_seconds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activity_type'] = this.activityType;
    data['count'] = this.count;
    data['calories'] = this.calories;
    data['duration_seconds'] = this.durationSeconds;
    return data;
  }
}

class Recent {
  int? activityId;
  String? category;
  String? activityType;
  int? durationSeconds;
  int? userWeight;
  double? caloriesBurned;
  String? activityDate;

  Recent(
      {this.activityId,
        this.category,
        this.activityType,
        this.durationSeconds,
        this.userWeight,
        this.caloriesBurned,
        this.activityDate});

  Recent.fromJson(Map<String, dynamic> json) {
    activityId = json['activity_id'];
    category = json['category'];
    activityType = json['activity_type'];
    durationSeconds = json['duration_seconds'];
    userWeight = json['user_weight'];
    caloriesBurned = _toDouble(json['calories_burned']);
    activityDate = json['activity_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activity_id'] = this.activityId;
    data['category'] = this.category;
    data['activity_type'] = this.activityType;
    data['duration_seconds'] = this.durationSeconds;
    data['user_weight'] = this.userWeight;
    data['calories_burned'] = this.caloriesBurned;
    data['activity_date'] = this.activityDate;
    return data;
  }
}

class Last7Days {
  String? date;
  int? activityCount;
  double? caloriesSum;
  int? durationSecondsSum;

  Last7Days(
      {this.date, this.activityCount, this.caloriesSum, this.durationSecondsSum});

  Last7Days.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    activityCount = json['activity_count'];
    caloriesSum = _toDouble(json['calories_sum']);
    durationSecondsSum = json['duration_seconds_sum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['activity_count'] = this.activityCount;
    data['calories_sum'] = this.caloriesSum;
    data['duration_seconds_sum'] = this.durationSecondsSum;
    return data;
  }
}