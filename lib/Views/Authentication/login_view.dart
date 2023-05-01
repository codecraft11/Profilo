import 'package:busniess_card_app/Controllers/auth_controller.dart';
import 'package:busniess_card_app/Utils/colors.dart';
import 'package:busniess_card_app/Utils/const.dart';
import 'package:busniess_card_app/Utils/global_veriables.dart';
import 'package:busniess_card_app/Views/Authentication/forgot_password.dart';
import 'package:busniess_card_app/Views/Authentication/signup_view.dart';
import 'package:busniess_card_app/Views/Widgets/textfield_widget.dart';
import 'package:busniess_card_app/Views/Widgets/transitions.dart';
import 'package:busniess_card_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final authController = Get.find<AuthController>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final isObsecure = true.obs;

  @override
  Widget build(BuildContext context) {
    // kIsWeb ? kWidth = 410 : Get.width;

    double height = Get.height;
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: kWidth,
            decoration: const BoxDecoration(
                // boxShadow: [
                //   BoxShadow(spreadRadius: 3, blurRadius: 10),
                // ],
                ),
            child: Scaffold(
              backgroundColor: backgroundColor,
              body: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 60.0, right: 20, left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(
                        () => isLoading.value
                            ? const CircularProgressIndicator(
                                color: kDarkColor,
                              )
                            // ignore: prefer_const_constructors
                            : Text(
                                'LOGIN',
                                style: h1HeadingBlack,
                              ),
                      ),
                      SizedBox(height: height * 0.05),
                      Image.asset(
                        "assets/images/profilomain.png",
                        height: height * 0.155,
                        color: kMainColor,
                      ),
                      SizedBox(height: height * 0.075),
                      TextFieldWidget(
                        obsecure: false,
                        controller: emailController,
                        leadingIcon: Icons.mail,
                        lable: 'Enter Email',
                      ),
                      const SizedBox(height: 15),
                      Obx(
                        () => TextFieldWidget(
                          controller: passwordController,
                          leadingIcon: Icons.lock,
                          lable: 'Enter Password',
                          obsecure: isObsecure.value,
                          trailing: isObsecure.value
                              ? IconButton(
                                  onPressed: () {
                                    isObsecure.value = false;
                                  },
                                  icon: const Icon(
                                    Icons.password,
                                    color: kMainColor,
                                  ),
                                )
                              : IconButton(
                                  onPressed: () {
                                    isObsecure.value = true;
                                  },
                                  icon: const Icon(
                                    Icons.remove_red_eye,
                                    color: kMainColor,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.only(right: 15),
                        width: double.infinity,
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () => Get.to(
                            ForgotPassword(),
                            duration: const Duration(milliseconds: 300),
                            transition: Transition.cupertinoDialog,
                          ),
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: kMainColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: MaterialButton(
                            height: 60.0,
                            color: kMainColor,
                            onPressed: () async {
                              isLoading.value = true;
                              if (GetUtils.isEmail(emailController.text)) {
                                await authController.logIn(emailController.text,
                                    passwordController.text);
                              } else {
                                Get.snackbar("Input Error", 'Enter Valid Data',
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: kRedColor);
                              }
                              isLoading.value = false;
                            },
                            child: const Text(
                              'LOGIN',
                              style: TextStyle(
                                  color: kFadedColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  letterSpacing: 2),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            "Don’t have an Account ? ",
                            style: TextStyle(
                              color: kFadedColor,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(
                                () => SignupView(),
                                duration: const Duration(milliseconds: 300),
                                transition: Transition.rightToLeft,
                              );
                            },
                            child: const Text(
                              "SignUp",
                              style: TextStyle(
                                color: kMainColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: const [
                          Expanded(
                              child: Divider(
                            thickness: 2,
                            indent: 20,
                            endIndent: 10,
                            color: kFadedColor,
                          )),
                          Text(
                            'OR',
                            style: TextStyle(color: kMainColor),
                          ),
                          Expanded(
                              child: Divider(
                            thickness: 2,
                            indent: 10,
                            endIndent: 20,
                            color: kFadedColor,
                          )),
                        ],
                      ),
                      const SizedBox(height: 15),
                      GestureDetector(
                        onTap: () async {
                          isLoading.value = true;
                          print('Pressed:::::::::');
                          await authController.googleLogin();
                          print('done');
                          isLoading.value = false;
                        },
                        child: Container(
                          width: 300,
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: kFadedColor),
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/svg/googleicon.svg',
                                // color: kMainColor,
                                width: 35,
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                'Login with Google',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: kFadedColor,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
