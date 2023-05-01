import 'package:busniess_card_app/Utils/colors.dart';
import 'package:busniess_card_app/Utils/global_veriables.dart';
import 'package:busniess_card_app/Views/Authentication/login_view.dart';
import 'package:busniess_card_app/Views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingScreen extends StatelessWidget {
  LoadingScreen({Key? key}) : super(key: key);
  final isLoading = true.obs;
  @override
  Widget build(BuildContext context) {
    if (isSigned.value == null) {
      isLoading.value = true;
    } else {
      isLoading.value = false;
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: kMainColor,
        body: Obx(
          () {
            if (isSigned.value == null) {
              return const Center(
                child: CircularProgressIndicator(
                  color: kDarkColor,
                ),
              );
            } else {
              return isSigned.value! ? HomeView() : LoginView();
            }
          },
        ),
      ),
    );
  }
}
