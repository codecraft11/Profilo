import 'package:busniess_card_app/Controllers/auth_controller.dart';
import 'package:busniess_card_app/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ChangePassword extends StatelessWidget {
  ChangePassword({Key? key}) : super(key: key);
  var isLoading = false.obs;
  final TextEditingController password = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController newRepeatPassword = TextEditingController();
  final authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text(
          "Change Password",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/svg/fPassword.svg',
                    width: 250,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    alignment: Alignment.center,
                    child: const Text(
                      "Change Password?",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: kBrightColor),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "You can change password here",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    height: 50,
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: kDarkLightColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: password,
                      cursorColor: kBrightColor,
                      decoration: const InputDecoration(
                        fillColor: kDarkLightColor,
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.password,
                          color: kMainColor,
                        ),
                        hintText: 'Old Password',
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    height: 50,
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: kDarkLightColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: newPassword,
                      cursorColor: kDarkColor,
                      decoration: const InputDecoration(
                        fillColor: kDarkLightColor,
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.password,
                          color: kMainColor,
                        ),
                        hintText: 'New Password',
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    height: 50,
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: kDarkLightColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: newRepeatPassword,
                      cursorColor: kDarkColor,
                      decoration: const InputDecoration(
                        fillColor: kDarkLightColor,
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.password,
                          color: kMainColor,
                        ),
                        hintText: 'Repeat New Password',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  Obx(() => Container(
                        height: 50,
                        width: 250,
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(12)),
                        child: isLoading.value
                            ? const CircularProgressIndicator()
                            : MaterialButton(
                                onPressed: () async {
                                  isLoading.value = true;

                                  if (password.text != '' &&
                                      newPassword.text != '' &&
                                      newRepeatPassword.text != '') {
                                    if (await authController
                                        .validatePasttword(password.text)) {
                                      if (newPassword.text ==
                                          newRepeatPassword.text) {
                                        authController
                                            .changePassword(newPassword.text);
                                      } else {
                                        Get.snackbar(
                                            'Error', 'Passwords are not same!');
                                      }
                                    } else {
                                      Get.snackbar('Error',
                                          'Old Password is not correct!');
                                    }
                                  } else {
                                    Get.snackbar(
                                        'Error', 'Enter Valid Passord');
                                  }
                                  isLoading.value = false;
                                },
                                child: const Text(
                                  "Change Password",
                                  style: TextStyle(
                                      color: kBrightColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                      )),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
