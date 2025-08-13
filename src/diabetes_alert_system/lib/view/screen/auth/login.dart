import 'package:flutter/material.dart';

import '../../../controller/auth/login_controller.dart';
import '../../../core/class/handlingdataview.dart';
import '../../../core/constant/color.dart';

import '../../../core/functions/alertexitapp.dart';
import '../../../core/functions/validinput.dart';
import '../../widget/auth/LogoAuth.dart';
import '../../widget/auth/custom_auth_app_bar.dart';
import '../../widget/auth/customtextbodyauth.dart';
import '../../widget/auth/customtextformauth.dart';
import '../../widget/auth/customtexttitleauth.dart';
import 'package:get/get.dart';

import '../../widget/auth/textsignup.dart';
import '../../widget/custom_elevated_button.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LoginControllerImp());

    return Scaffold(
      appBar: const CustomAuthAppBar(
        title: 'Login',
        icon: Icons.login,
      )
      ,
      body:PopScope(
    canPop: false,
    onPopInvoked: (bool canPop) {
        alertExitApp; },
        child: GetBuilder<LoginControllerImp>(
          builder: (controller) => HandlingDataViewRequest(
            statusRequest: controller.statusRequest,
            widget: Container(
              padding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              child: Form(
                key: controller.formstate,
                child: ListView(
                  children: [
                    const LogoAuth(),
                    const SizedBox(height: 20),
                    const CustomTextTitleAuth(text: "Welcome Back"),
                    const SizedBox(height: 10),
                    const CustomTextBodyAuth(
                      text: "Login to access your account and all its features.",
                    ),
                    const SizedBox(height: 15),
                    CustonTextFormAuth(
                      isNumber: false,
                      valid: (val) => validInput(val!, 5, 100, "email"),
                      mycontroller: controller.email,
                      hinttext: "Enter your email",
                      iconData: Icons.email_outlined,
                      labeltext: "Email",
                    ),
                    CustonTextFormAuth(
                      isNumber: false,
                      valid: (val) => validInput(val!, 5, 30, "password"),
                      obscureText: true,
                      mycontroller: controller.password,
                      hinttext: "Enter your password",
                      iconData: Icons.lock_outline,
                      labeltext: "Password",
                    ),
                    InkWell(
                      onTap: controller.goToForgetPassword,
                      child: const Text(
                        "Forgot password?",
                        textAlign: TextAlign.right,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomElevatedButton(text: 'Login',
                      onPressed: controller.login,
                    icon: Icons.login,),
                    const SizedBox(height: 40),
                    CustomTextSignUpOrSignIn(
                      textone: "Don't have an account? ",
                      texttwo: "Create an account",
                      onTap: controller.goToSignUp,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
