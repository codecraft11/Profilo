import 'package:busniess_card_app/Controllers/auth_controller.dart';
import 'package:busniess_card_app/Utils/colors.dart';
import 'package:busniess_card_app/Utils/const.dart';
import 'package:busniess_card_app/Views/Widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../main.dart';

class SignupView extends StatelessWidget {
  SignupView({Key? key}) : super(key: key);
  final authController = Get.find<AuthController>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final isObsecure = true.obs;
  final isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
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
                        const EdgeInsets.only(top: 40.0, right: 20, left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 40.0,
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              'SIGNUP',
                              style: h1HeadingBlack,
                            ),
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
                          controller: nameController,
                          leadingIcon: Icons.person,
                          lable: 'Enter Name',
                        ),
                        const SizedBox(height: 15),
                        TextFieldWidget(
                          obsecure: false,
                          controller: emailController,
                          leadingIcon: Icons.mail,
                          lable: 'Enter Email',
                        ),
                        const SizedBox(height: 15),
                        Obx(() => TextFieldWidget(
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
                            )),
                        const SizedBox(height: 10),
                        Obx(() => Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: MaterialButton(
                                  height: 60.0,
                                  color: kMainColor,
                                  onPressed: () async {
                                    isLoading.value = true;
                                    if (GetUtils.isEmail(
                                            emailController.text) &&
                                        nameController.text != '' &&
                                        passwordController.text != '') {
                                      await authController.createUser(
                                          nameController.text,
                                          emailController.text,
                                          passwordController.text);
                                      nameController.clear();
                                      emailController.clear();
                                      passwordController.clear();
                                    } else {
                                      Get.snackbar("Input Error",
                                          'Enter Valid Information',
                                          backgroundColor: Colors.white60);
                                    }
                                    isLoading.value = false;
                                  },
                                  child: isLoading.value
                                      ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : const Text(
                                          'SIGNUP',
                                          style: TextStyle(
                                              color: kBrightColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              letterSpacing: 2),
                                        ),
                                ),
                              ),
                            )),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text(
                              "Already have an account ? ",
                              style: TextStyle(
                                color: kFadedColor,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.back(canPop: true);
                              },
                              child: const Text(
                                "Login",
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
                          children: [
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
                            const Expanded(
                                child: const Divider(
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
                            padding: const EdgeInsets.all(8),
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
                                  width: 40,
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  'Signup with Google',
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
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
