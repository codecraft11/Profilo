import 'package:busniess_card_app/Utils/colors.dart';
import 'package:flutter/material.dart';

class UpdateWidget extends StatelessWidget {
  const UpdateWidget({
    Key? key,
    required this.controller,
    required this.lable,
    required this.ontap,
  }) : super(key: key);

  final String lable;
  final TextEditingController controller;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.white.withOpacity(0.5),
          //     spreadRadius: 5,
          //     blurRadius: 7,
          //     offset: Offset(0, 3), // changes position of shadow
          //   ),
// ],
          border: Border.all(color: kDarkColor),
          color: Theme.of(context).colorScheme.background),
      child: Column(
        children: [
          Text(
            'Update $lable',
            style: const TextStyle(
                color: kBrightColor, fontWeight: FontWeight.bold, fontSize: 22),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  cursorColor: kFadedColor,
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.start,
                  style: const TextStyle(fontSize: 16.0, color: kBrightColor),
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    labelText: lable,
                    labelStyle: TextStyle(fontSize: 16.0, color: kBrightColor),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kBrightColor, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: kFadedColor, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              MaterialButton(
                height: 40,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: ontap,
                child: const Text('Update'),
                color: kMainColor,
              )
            ],
          ),
        ],
      ),
    );
  }
}
