import 'package:busniess_card_app/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class EditSocialCard extends StatelessWidget {
  const EditSocialCard({
    Key? key,
    required this.added,
    required this.lable,
    required this.controller,
    required this.onAdd,
    required this.onDelete,
    this.prefix,
  }) : super(key: key);

  final bool added;
  final String lable;
  final TextEditingController controller;
  final VoidCallback onAdd;
  final VoidCallback onDelete;
  final String? prefix;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.bottomSheet(Container(
          height: 200,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            color: backgroundColor,
            border: Border.all(color: kDarkColor),
          ),
          child: Column(
            children: [
              Text(
                'Update $lable',
                style: const TextStyle(
                    color: kBrightColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: controller,
                cursorColor: kMainColor,
                keyboardType: TextInputType.text,
                textAlign: TextAlign.start,
                style: const TextStyle(fontSize: 16.0, color: kMainColor),
                decoration: InputDecoration(
                  prefixStyle: const TextStyle(color: kBrightColor),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  labelText: prefix,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  prefixText: prefix,
                  labelStyle: TextStyle(fontSize: 16.0, color: kDarkColor),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kBrightColor, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: kMainColor, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    height: 40,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    onPressed: onDelete,
                    child: Text(
                      added ? 'Delete' : 'Cancel',
                      style: const TextStyle(color: kBrightColor),
                    ),
                    color: kRedColor,
                  ),
                  const SizedBox(width: 20),
                  MaterialButton(
                    height: 40,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    onPressed: onAdd,
                    child: added
                        ? const Text(
                            'Update',
                            style: TextStyle(color: kBrightColor),
                          )
                        : const Text(
                            'Add',
                            style: TextStyle(color: kBrightColor),
                          ),
                    color: kMainColor,
                  ),
                ],
              )
            ],
          ),
        ));
      },
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                    color: added
                        ? kDarkColor.withOpacity(0.8)
                        : Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    spreadRadius: 1),
              ],
            ),
            height: 100,
            width: 100,
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 60,
                  child: SvgPicture.asset(
                    'assets/svg/$lable.svg',
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  lable,
                  style: TextStyle(color: kDarkColor),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            child: Container(
              height: 20.0,
              width: 20.0,
              decoration: BoxDecoration(
                color: added ? kMainColor : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Icon(
                  Icons.done_rounded,
                  size: 12.0,
                  color: added ? kBrightColor : Colors.transparent,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
