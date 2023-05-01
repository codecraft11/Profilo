import 'package:busniess_card_app/Controllers/user_controller.dart';
import 'package:busniess_card_app/Utils/AppTextStyleAndColors/appColors.dart';
import 'package:busniess_card_app/Utils/AppTextStyleAndColors/appTextStyle.dart';
import 'package:busniess_card_app/Utils/colors.dart';
import 'package:busniess_card_app/Views/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class ActivateNFCview extends StatelessWidget {
  ActivateNFCview({Key? key}) : super(key: key);

  final userController = Get.find<UserController>();
  ValueNotifier<dynamic> result = ValueNotifier(null);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/phone.png',
                    width: 200,
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      'Your Tag will be activated with the profile link',
                      textAlign: TextAlign.center,
                      style: h18HeadingWhiteBold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  InkWell(
                    onTap: () async {
                      await launch(
                        userController.userGetter!.dynamicLink!,
                      );
                    },
                    onLongPress: () {
                      Clipboard.setData(ClipboardData(
                          text: userController.userGetter!.dynamicLink!));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: kPrimaryColor,
                          content: const Text(
                            'Copied Link!',
                            style: TextStyle(
                              color: kBrightColor,
                            ),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: kDarkColor,
                          borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      child: Text(
                        userController.userGetter!.dynamicLink!,
                        style: h15HeadingWhiteBold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    color: Colors.transparent,
                    child: GestureDetector(
                      onTap: () {
                        _tagWrite(userController.userGetter!.dynamicLink!);
                        final activeCupertinoActionSheet = CupertinoActionSheet(
                          title: const Text(
                            "Ready to Read",
                            style: TextStyle(fontSize: 30, color: kBrightColor),
                          ),
                          message: Column(
                            children: [
                              Lottie.asset('assets/scan_animation.json'),
                              const Text(
                                "Hold a Profilo to the middle back of your phone to write the Tag.",
                                style: h15HeadingWhiteSimple,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: greyColor,
                                ),
                                width: Get.width * 0.9,
                                child: MaterialButton(
                                  onPressed: () => Navigator.pop(
                                    context,
                                  ),
                                  child: const Text(
                                    "Cancel",
                                    style: h18HeadingWhiteSimple,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                        showCupertinoModalPopup(
                          context: context,
                          builder: (context) => activeCupertinoActionSheet,
                        );
                      },
                      child: Container(
                        width: 300,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: kDarkColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Text(
                          'Write The Tag',
                          style: TextStyle(
                            letterSpacing: 1,
                            color: kBrightColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _tagRead() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      result.value = tag.data;
      NfcManager.instance.stopSession();
    });
  }

  void _tagWrite(String url) {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      var ndef = Ndef.from(tag);
      if (ndef == null || !ndef.isWritable) {
        result.value = 'Tag is not ndef writable';

        NfcManager.instance.stopSession(errorMessage: result.value);
        Get.offAll(() => HomeView());
        Get.snackbar("Error", "Tag is not ndef writable",
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
        return;
      }

      NdefMessage message = NdefMessage([
        // NdefRecord.createText('Hello World!'),
        NdefRecord.createUri(Uri.parse(url)),
        // NdefRecord.createUri(Uri.parse('https://flutter.dev')),
        // NdefRecord.createMime(
        //     'text/plain', Uint8List.fromList('Hello'.codeUnits)),
        // NdefRecord.createExternal(
        //     'com.example', 'mytype', Uint8List.fromList('mydata'.codeUnits)),
      ]);

      try {
        await ndef.write(message);
        result.value = 'Success to "Ndef Write"';
        NfcManager.instance.stopSession();
        Get.offAll(() => HomeView());
        Get.snackbar("Success", "Tag Written Successfully",
            snackPosition: SnackPosition.BOTTOM);
      } catch (e) {
        result.value = e;
        NfcManager.instance.stopSession(errorMessage: result.value.toString());
        Get.snackbar("Error", e.toString(),
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
        return;
      }
    });
  }

  // void _ndefWriteLock() {
  //   NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
  //     var ndef = Ndef.from(tag);
  //     if (ndef == null) {
  //       result.value = 'Tag is not ndef';
  //       NfcManager.instance.stopSession(errorMessage: result.value.toString());
  //       return;
  //     }

  //     try {
  //       await ndef.writeLock();
  //       result.value = 'Success to "Ndef Write Lock"';
  //       NfcManager.instance.stopSession();
  //     } catch (e) {
  //       result.value = e;
  //       NfcManager.instance.stopSession(errorMessage: result.value.toString());
  //       return;
  //     }
  //   });
  // }
}
