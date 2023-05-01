import 'package:busniess_card_app/Utils/colors.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key? key,
    required this.lable,
    required this.controller,
    required this.leadingIcon,
    required this.obsecure,
    this.trailing,
  }) : super(key: key);

  final TextEditingController controller;
  final IconData leadingIcon;
  final Widget? trailing;
  final String lable;
  final bool obsecure;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      width: double.infinity,
      decoration: BoxDecoration(
          // color: kFadedColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: kMainColor)),
      child: TextField(
        obscureText: obsecure,
        controller: controller,
        cursorColor: kFadedColor,
        style: const TextStyle(color: kBrightColor),
        decoration: InputDecoration(
            fillColor: kDarkLightColor,
            border: InputBorder.none,
            // labelStyle: TextStyle(color: kDarkColor),
            icon: Icon(
              leadingIcon,
              color: kMainColor,
            ),
            hintText: lable,
            hintStyle: const TextStyle(color: kBrightColor),
            suffixIcon: trailing),
      ),
    );
  }
}
