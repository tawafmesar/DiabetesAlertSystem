class AppLink {
  // static const String server = "https://maroon-snake-735491.hostingersite.com/backend/";

  static const String server = "http://10.0.2.2/app/DiabetesAlertSystem/src/backend/";

  static const String test = "$server/test.php";
  static const String imagesstatic = "$server/upload" ;


  static const String viewcategories = "$server/categories.php";

  static const String imagestCategories = "$imagesstatic/categories" ;
// ================================= Auth ========================== //


  static const String signUp = "$server/auth/signup.php";
  static const String login = "$server/auth/login.php";
  static const String resend = "$server/auth/resend.php";

  static const String verifycodessignup = "$server/auth/verfiycode.php";

// ================================= ForgetPassword ========================== //

  static const String checkEmail = "$server/forgetpassword/checkemail.php";
  static const String resetPassword = "$server/forgetpassword/resetpassword.php";
  static const String verifycodeforgetpassword = "$server/forgetpassword/verifycode.php";




// ================================= Medication ========================== //
  static const String medicationview = "$server/medications/view.php"  ;
  static const String medicationremove = "$server/medications/remove.php"  ;
  static const String medicationadd = "$server/medications/add.php"  ;



  // ================================= Metrics ========================== //
  static const String metricsview = "$server/metrics/view.php"  ;
  static const String metricsremove = "$server/metrics/remove.php"  ;
  static const String metricsreadd = "$server/metrics/add.php"  ;

  // ================================= Alarms ========================== //
  static const String alarmsadd = "$server/alarms/add.php"  ;
  static const String alarmsremove = "$server/alarms/remove.php"  ;
  static const String alarmsremoveall = "$server/alarms/removeall.php"  ;

  // ================================= activities ========================== //
  static const String activityadd = "$server/activities/add.php"  ;
  static const String activityview = "$server/activities/view.php"  ;
  static const String activityremove = "$server/activities/remove.php"  ;




}
