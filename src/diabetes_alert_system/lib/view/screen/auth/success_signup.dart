import 'package:flutter/material.dart';
import '../../../controller/auth/successsignup_controller.dart';
import 'package:get/get.dart';

import '../../../core/constant/color.dart';
import '../../widget/auth/custom_auth_app_bar.dart';
import '../../widget/custom_elevated_button.dart';

class SuccessSignUp extends StatelessWidget {
  const SuccessSignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SuccessSignUpControllerImp controller =
    Get.put(SuccessSignUpControllerImp());
    return Scaffold(

      appBar:
      const CustomAuthAppBar(
        title: 'Success Registration',
        icon: Icons.verified_user_outlined,
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(children: [
          const Center(
              child: Icon(
                Icons.check_circle_outline,
                size: 200,
                color: AppColor.primaryColor,
              )),
          Text("Congratulations",
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(fontSize: 30)),
          const Text("Account created successfully"),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child:  CustomElevatedButton(text: 'Go to Login',
              onPressed: controller.goToPageLogin,
              icon: Icons.navigate_next,),

          ),
          const SizedBox(height: 30)
        ]),
      ),
    );
  }
}
