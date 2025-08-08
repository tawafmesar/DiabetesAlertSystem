import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/forgetpassword/forgetpassword_controller.dart';
import '../../../../core/class/handlingdataview.dart';
import '../../../../core/constant/color.dart';
import '../../../../core/functions/validinput.dart';
import '../../../widget/auth/LogoAuth.dart';
import '../../../widget/auth/custom_auth_app_bar.dart';
import '../../../widget/auth/customtextbodyauth.dart';
import '../../../widget/auth/customtextformauth.dart';
import '../../../widget/auth/customtexttitleauth.dart';
import '../../../widget/custom_elevated_button.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ForgetPasswordControllerImp());

    return Scaffold(
      appBar: const CustomAuthAppBar(
        title: 'Forgot Password',
        icon: Icons.vpn_key ,
        showBackButton: true,
      ),
      body: GetBuilder<ForgetPasswordControllerImp>(
        builder: (controller) => HandlingDataViewRequest(
          statusRequest: controller.statusRequest,
          widget: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: Form(
              key: controller.formstate,
              child: ListView(
                children: [
                  const LogoAuth(),
                  const SizedBox(
                    height: 20,
                  ),
                  const CustomTextTitleAuth(text: "Check Email"),
                  const SizedBox(
                    height: 10,
                  ),
                  const CustomTextBodyAuth(
                    text:
                    "Please enter your email address to receive a verification code",
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  CustonTextFormAuth(
                    isNumber: false,
                    valid: (val) {
                      return validInput(val!, 5, 100, "email");
                    },
                    mycontroller: controller.email,
                    hinttext: "Enter your email address",
                    iconData: Icons.email_outlined,
                    labeltext: "Email Address",
                  ),
                  CustomElevatedButton(text: 'Check',
                    onPressed: controller.checkemail,
                    icon: Icons.mark_email_read,),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
