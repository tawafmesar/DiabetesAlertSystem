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




// ================================= Accidents ========================== //

  static const String accidents_add = "$server/accidents/add.php";


  static const String accidents_view = "$server/accidents/view.php";
  static const String accidents_viewall = "$server/accidents/viewall.php";


  // ================================= tips ========================== //

  static const String tips_view = "$server/tips/view.php";
  static const String tips_remove = "$server/tips/remove.php";
  static const String tips_add = "$server/tips/add.php";


  // ================================= notifications ========================== //

  static const String notifications_view = "$server/notifications/view.php";
  static const String notifications_remove = "$server/notifications/remove.php";
  static const String notifications_add = "$server/notifications/add.php";






}
