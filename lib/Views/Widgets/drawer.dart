import 'package:busniess_card_app/Controllers/auth_controller.dart';
import 'package:busniess_card_app/Utils/colors.dart';
import 'package:busniess_card_app/Views/Authentication/change_password.dart';
import 'package:busniess_card_app/Views/activate_nfc_view.dart';
import 'package:busniess_card_app/Views/edit_view.dart';
import 'package:busniess_card_app/Views/qr_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MyDrawer extends StatelessWidget {
  static String route = "Drawer";
  const MyDrawer({
    Key? key,
    required this.name,
    required this.img,
  }) : super(key: key);

  final String name;
  final String img;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      child: Drawer(
        backgroundColor: backgroundColor,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 190.0,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: kMainColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 110.0,
                        width: 110.0,
                        decoration: BoxDecoration(
                            color: kDarkColor,
                            borderRadius: BorderRadius.circular(60)),
                        padding: const EdgeInsets.all(4),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: Image.network(
                            img,
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                              return SvgPicture.asset(
                                'assets/user.svg',
                                width: 122,
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        name,
                        style: const TextStyle(
                          color: kBrightColor,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                // Positioned(
                //   top: 168.0,
                //   left: 60.0,
                //   child: Container(
                //     width: 130,
                //     child: MaterialButton(
                //       shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(20)),
                //       color: kDarkColor,
                //       child: Text(
                //         ' Disable ',
                //         textAlign: TextAlign.center,
                //         style: TextStyle(
                //           color: kBrightColor,
                //           fontSize: 12,
                //         ),
                //       ),
                //       onPressed: () {},
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 190.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      ListTile(
                        title: const Text(
                          'Home',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: kBrightColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        leading: const Icon(
                          Icons.home_outlined,
                          size: 25.0,
                          color: kBrightColor,
                        ),
                        onTap: () {
                          Get.back();
                        },
                      ),
                      ListTile(
                        title: const Text(
                          'Edit Profile',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: kBrightColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        leading: const Icon(
                          Icons.person_outline_rounded,
                          size: 25.0,
                          color: kBrightColor,
                        ),
                        onTap: () {
                          Get.back();
                          Get.to(
                            () => EditView(),
                            duration: const Duration(milliseconds: 400),
                            transition: Transition.leftToRightWithFade,
                          );
                        },
                      ),

                      ListTile(
                        title: const Text(
                          'My QR Code',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: kBrightColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        leading: const Icon(
                          Icons.qr_code_rounded,
                          size: 25.0,
                          color: kBrightColor,
                        ),
                        onTap: () {
                          Get.to(
                            () => QRView(),
                            duration: const Duration(milliseconds: 400),
                            transition: Transition.leftToRightWithFade,
                          );
                        },
                      ),

                      kIsWeb
                          ? Container()
                          : ListTile(
                              title: const Text(
                                'Activate',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: kBrightColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              leading: const Icon(
                                Icons.power_settings_new_rounded,
                                size: 25.0,
                                color: kBrightColor,
                              ),
                              onTap: () {
                                Get.to(
                                  () => ActivateNFCview(),
                                  duration: const Duration(milliseconds: 400),
                                  transition: Transition.leftToRightWithFade,
                                );
                              },
                            ),

                      const ListTile(
                        title: Text(
                          'Buy profilo',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: kBrightColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        leading: Icon(
                          Icons.shopping_bag_outlined,
                          size: 25.0,
                          color: kBrightColor,
                        ),
                      ),

                      const ListTile(
                        title: Text(
                          'How to profilo',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: kBrightColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        leading: Icon(
                          Icons.search_rounded,
                          size: 25.0,
                          color: kBrightColor,
                        ),
                      ),

                      ListTile(
                        title: const Text(
                          'Change Password',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: kBrightColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        leading: const Icon(
                          Icons.remove_red_eye_outlined,
                          size: 25.0,
                          color: kBrightColor,
                        ),
                        onTap: () {
                          Get.to(
                            () => ChangePassword(),
                            duration: const Duration(milliseconds: 400),
                            transition: Transition.leftToRightWithFade,
                          );
                          // await Get.find<AuthController>().signOut();
                        },
                      ),

                      ListTile(
                        title: const Text(
                          'Log out',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: kBrightColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        leading: const Icon(
                          Icons.logout,
                          size: 25.0,
                          color: kBrightColor,
                        ),
                        onTap: () async {
                          await Get.find<AuthController>().signOut();
                        },
                      ),

                      // GestureDetectorWidget(
                      //   icon: Icon(
                      //     Icons.nfc_rounded,
                      //     size: 25.0,
                      //     color: kDarkColor,
                      //   ),
                      //   text: 'Read a taplo',
                      //   ontap: () {
                      //     final action = CupertinoActionSheet(
                      //       title: Text(
                      //         "Ready to Scan",
                      //         style: TextStyle(fontSize: 30),
                      //       ),
                      //       message: Column(
                      //         children: [
                      //           Lottie.asset('assets/scan_animation.json'),
                      //           Text(
                      //             "Hold a Taplo to the middle back of your phone to view Profile. Hold the Taplo there until the profile appears!",
                      //             style: TextStyle(
                      //               fontSize: 15.0,
                      //               color: Colors.black,
                      //             ),
                      //           ),
                      //           SizedBox(
                      //             height: 15,
                      //           ),
                      //           Container(
                      //             decoration: BoxDecoration(
                      //               borderRadius: BorderRadius.circular(10),
                      //               color: Colors.grey,
                      //             ),
                      //             width: tWidth * 0.9,
                      //             child: MaterialButton(
                      //               onPressed: () => Navigator.pop(
                      //                 context,
                      //               ),
                      //               child: Text(
                      //                 "Cancel",
                      //                 style: TextStyle(
                      //                   color: Colors.black,
                      //                   fontSize: 18,
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     );
                      //     showCupertinoModalPopup(
                      //         context: context, builder: (context) => action);
                      //   },
                      // ),
                    ],
                  ),
                ),
              ],
            ),
            const Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    "Version 1.0",
                    style: TextStyle(
                      color: kDarkColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
