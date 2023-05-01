import 'package:busniess_card_app/Controllers/auth_controller.dart';
import 'package:busniess_card_app/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({Key? key}) : super(key: key);
  var isLoading = false.obs;
  final TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainColor,
        title: const Text(
          "Reset Password",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
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
                      "Forget Password?",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Text(
                    "Enter your email to reset password.",
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
                      color: kDarkLightColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: email,
                      cursorColor: kDarkColor,
                      decoration: const InputDecoration(
                        fillColor: kDarkLightColor,
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.email,
                          color: kMainColor,
                        ),
                        hintText: 'Email',
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
                            color: kMainColor,
                            borderRadius: BorderRadius.circular(12)),
                        child: isLoading.value
                            ? const CircularProgressIndicator()
                            : MaterialButton(
                                onPressed: () async {
                                  isLoading.value = true;
                                  if (GetUtils.isEmail(email.text)) {
                                    await Get.find<AuthController>()
                                        .resetPassword(email.text);
                                  } else {
                                    Get.snackbar('Error', 'Enter valid Email.');
                                  }
                                  isLoading.value = false;
                                },
                                child: const Text(
                                  "Send Reset Link",
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
