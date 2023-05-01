import 'dart:typed_data';
import 'package:busniess_card_app/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';
import '../Controllers/user_controller.dart';

class QRView extends StatelessWidget {
  QRView({Key? key}) : super(key: key);

  final screenshotController = ScreenshotController();
  final userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.clear_rounded,
                      color: kBrightColor,
                      size: 40.0,
                    ),
                  ),
                ],
              ),
              Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/profilomain.png',
                        width: 300.0,
                        color: kBrightColor,
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        width: 200.0,
                        color: Colors.white,
                        child: QrImage(
                          data: userController.userGetter!.dynamicLink!,
                          backgroundColor: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MaterialButton(
                          color: kMainColor,
                          child: const Text('Save QR Code'),
                          onPressed: () async {
                            final image =
                                await screenshotController.captureFromWidget(
                              QR(
                                linkMessage:
                                    userController.userGetter!.dynamicLink!,
                                name: userController.userGetter!.name!,
                              ),
                            );

                            await saveImage(image);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('QR Code Saved to Gallery')),
                            );
                          }),
                      const SizedBox(
                        height: 10.0,
                      ),
                      // Container(
                      //   decoration: BoxDecoration(
                      //       color: kDarkColor,
                      //       borderRadius: BorderRadius.circular(10)),
                      //   padding: const EdgeInsets.symmetric(
                      //     vertical: 5,
                      //     horizontal: 20,
                      //   ),
                      //   child: const Text(
                      //     'Profile',
                      //     style: TextStyle(
                      //       color: kBrightColor,
                      //       fontSize: 20,
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        userController.userGetter!.name!,
                        style: const TextStyle(
                          color: kMainColor,
                          fontSize: 22.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        onTap: () async {
                          await launch(userController.userGetter!.dynamicLink!);
                        },
                        onLongPress: () {
                          Clipboard.setData(ClipboardData(
                              text: userController.userGetter!.dynamicLink!));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Copied Link!')),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: kDarkColor,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: kDarkColor,
                                )
                              ]),
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          child: Text(
                            userController.userGetter!.dynamicLink!,
                            style: const TextStyle(
                              color: kBrightColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Press & Hold to copy link',
                        style: TextStyle(color: kBrightColor, fontSize: 10),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Share.share(userController.userGetter!.dynamicLink!);
                        },
                        child: Container(
                          height: 50.0,
                          width: Get.width * 0.60,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: const Center(
                            child: Text(
                              'Share Profile Link',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                decoration: TextDecoration.none,
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
        ),
      ),
    );
  }

  Future<String> saveImage(Uint8List bytes) async {
    await [Permission.storage].request();
    var result;
    try {
      final timeNow = DateTime.now()
          .toIso8601String()
          .replaceAll('.', '-')
          .replaceAll(':', '-');
      final name = 'profilo-qr-$timeNow';
      result = await ImageGallerySaver.saveImage(bytes, name: name);
      return result['filePath'];
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
    return result['filePath'];
  }
}

class QR extends StatelessWidget {
  const QR({
    Key? key,
    required String linkMessage,
    required this.name,
  })  : _linkMessage = linkMessage,
        super(key: key);

  final String _linkMessage;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 400,
      width: 400.0,
      color: kMainColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/profilomain.png',
            width: 150,
          ),
          SizedBox(
            height: 200,
            width: 200,
            child: QrImage(
              data: _linkMessage,
              backgroundColor: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: const TextStyle(
              color: kDarkColor,
              fontSize: 22.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            _linkMessage,
            style: const TextStyle(color: Colors.blue),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
