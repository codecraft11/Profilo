// ignore_for_file: unrelated_type_equality_checks

import 'package:busniess_card_app/Bindings/all_bindings.dart';
import 'package:busniess_card_app/Controllers/user_controller.dart';
import 'package:busniess_card_app/Services/firestore_service.dart';
import 'package:busniess_card_app/Utils/colors.dart';
import 'package:busniess_card_app/Views/Widgets/drawer.dart';
import 'package:busniess_card_app/Views/Widgets/social_card.dart';
import 'package:busniess_card_app/Views/edit_view.dart';
import 'package:busniess_card_app/Views/qr_view.dart';
import 'package:busniess_card_app/Views/saved_uses_view.dart';
import 'package:busniess_card_app/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:drag_drop_gridview/devdrag.dart';

class HomeView extends StatelessWidget {
  HomeView({
    Key? key,
  }) : super(key: key);

  final userController = Get.find<UserController>();
  // final bool onpress;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: kWidth,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(spreadRadius: 3, blurRadius: 10),
              ],
            ),
            child: Scaffold(
              backgroundColor: backgroundColor,
              appBar: AppBar(
                backgroundColor: backgroundColor,
                iconTheme: const IconThemeData(
                  color: kFadedColor,
                ),
                centerTitle: true,
                elevation: 0,
                title: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Image.asset(
                    'assets/images/profilomain.png',
                    height: 40,
                    color: kMainColor,
                  ),
                ),
                actions: [
                  // IconButton(onPressed: () {}, icon: Icon(Icons.people)),
                  // SizedBox(width: 5),
                  kIsWeb
                      ? const SizedBox()
                      : GestureDetector(
                          onTap: () {
                            Get.to(
                              () => QRView(),
                              duration: const Duration(milliseconds: 300),
                              transition: Transition.upToDown,
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(right: 15.0),
                            child: Icon(
                              Icons.qr_code,
                              color: kFadedColor,
                            ),
                          ),
                        ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Get.to(
                    () => SavedUsersView(),
                    binding: SavedUserBinding(),
                    duration: const Duration(milliseconds: 300),
                    transition: Transition.rightToLeft,
                  );
                },
                tooltip: 'People',
                backgroundColor: kMainColor,
                child: const Icon(
                  Icons.people,
                  color: kBrightColor,
                ),
              ),
              drawer: Obx(() {
                if (userController.userGetter == null) {
                  return Container();
                } else {
                  return MyDrawer(
                    name: userController.userGetter!.name!,
                    img: userController.userGetter!.imageUrl!,
                  );
                }
              }),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Obx(() {
                      if (userController.userGetter == null) {
                        return Container(
                          height: 240,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: backgroundColor,

                            // image: DecorationImage(
                            //     image: AssetImage(
                            //       'assets/images/bubble.png',
                            //     ),
                            //     fit: BoxFit.cover),
                          ),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: kMainColor,
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          height: 240,
                          color: backgroundColor,
                          child: Stack(
                            children: [
                              Container(
                                color: Colors.transparent,
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 15.0, bottom: 0.0),
                                          child: Container(
                                            height: 110.0,
                                            width: 110.0,
                                            decoration: BoxDecoration(
                                                color: kDarkColor,
                                                borderRadius:
                                                    BorderRadius.circular(60)),
                                            padding: const EdgeInsets.all(2),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(60),
                                              child: Image.network(
                                                userController
                                                    .userGetter!.imageUrl!,
                                                fit: BoxFit.cover,
                                                loadingBuilder:
                                                    (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                  if (loadingProgress == null) {
                                                    return child;
                                                  }
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      value: loadingProgress
                                                                  .expectedTotalBytes !=
                                                              null
                                                          ? loadingProgress
                                                                  .cumulativeBytesLoaded /
                                                              loadingProgress
                                                                  .expectedTotalBytes!
                                                          : null,
                                                    ),
                                                  );
                                                },
                                                errorBuilder: (BuildContext
                                                        context,
                                                    Object exception,
                                                    StackTrace? stackTrace) {
                                                  return SvgPicture.asset(
                                                    'assets/user.svg',
                                                    width: 130,
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          userController.userGetter!.name!,
                                          style: const TextStyle(
                                            color: kFadedColor,
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          userController
                                              .userGetter!.description!,
                                          style: const TextStyle(
                                            color: kFadedColor,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: SizedBox(
                                    width: 400,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(
                                          width: 130,
                                          child: MaterialButton(
                                            color: kDarkColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            onPressed: () async {
                                              try {
                                                userController
                                                        .userGetter!.direct!
                                                    ? await Database()
                                                        .updateDirect(false)
                                                    : await Database()
                                                        .updateDirect(true);
                                                Get.snackbar(
                                                  'Updated',
                                                  'Direct Updated Successfully',
                                                  snackPosition:
                                                      SnackPosition.TOP,
                                                  backgroundColor: kMainColor,
                                                  colorText: kBrightColor,
                                                );
                                              } catch (e) {
                                                Get.snackbar(
                                                  'Error',
                                                  e.toString(),
                                                  snackPosition:
                                                      SnackPosition.BOTTOM,
                                                  backgroundColor: kDarkColor,
                                                  colorText: kBrightColor,
                                                );
                                              }
                                              // setState(() {
                                              //   directOn ? directOn = false : directOn = true;
                                              // });
                                              // await DataBase().updateDirect(uid, directOn);
                                              // ScaffoldMessenger.of(context)
                                              //     .showSnackBar(const SnackBar(content: Text('Direct Updated')));
                                            },
                                            child: Text(
                                              userController.userGetter!.direct!
                                                  ? 'Direct Off'
                                                  : 'Direct On',
                                              style: const TextStyle(
                                                color: kBrightColor,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 130,
                                          child: MaterialButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            color: kPrimaryColor,
                                            child: const Text(
                                              ' Edit Profile ',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: kBrightColor,
                                                fontSize: 12,
                                              ),
                                            ),
                                            onPressed: () {
                                              Get.to(
                                                () => EditView(),
                                                duration: const Duration(
                                                    milliseconds: 400),
                                                transition: Transition
                                                    .leftToRightWithFade,
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    }),
                    Obx(() {
                      if (userController.socialMediaList == null) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: kMainColor,
                          ),
                        );
                      } else if (userController.socialMediaList!.length > 0) {
                        return DragAndDropGridView(
                            physics: const NeverScrollableScrollPhysics(),
                            feedback: (int index) {
                              return Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: kDarkColor),
                                padding: const EdgeInsets.all(10),
                                // color: kRedColor,
                                child: SvgPicture.asset(
                                  'assets/svg/${userController.socialMediaList![index].linkName!}.svg',
                                ),
                              );
                            },
                            childWhenDragging: (int a) {
                              return Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: kDarkColor,
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                              );
                            },
                            isCustomFeedback: true,
                            isCustomChildWhenDragging: true,
                            onReorder: _onReorder,
                            onWillAccept: (oldIndex, newIndex) {
                              if (userController.socialMediaList![newIndex] ==
                                  "something") {
                                return false;
                              }
                              return true;
                            },
                            // shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemCount: userController.userGetter!.direct!
                                ? 1
                                : userController.socialMediaList!.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  launch(userController
                                      .socialMediaList![index].link!);
                                },
                                child: SocialCard(
                                    lable: userController
                                        .socialMediaList![index].linkName!),
                              );
                            });
                      } else {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 40),
                            SvgPicture.asset(
                              'assets/svg/nodata.svg',
                              width: 200,
                            ),
                            const SizedBox(height: 30),
                            const Text(
                              'You have no Data',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: kBrightColor),
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              width: 130,
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                color: kDarkColor,
                                child: const Text(
                                  ' + Add Profiles ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: kBrightColor,
                                    fontSize: 12,
                                  ),
                                ),
                                onPressed: () {
                                  Get.to(() => EditView(),
                                      duration: Duration(milliseconds: 400),
                                      transition:
                                          Transition.leftToRightWithFade);
                                },
                              ),
                            ),
                          ],
                        );
                      }
                    })
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _onReorder(int oldIndex, int newIndex) {
  final userController = Get.find<UserController>();
  if (oldIndex < newIndex) newIndex -= 1;
  userController.socialMediaList!
      .insert(newIndex, userController.socialMediaList!.removeAt(oldIndex));
  Database()
      .onReorderFireStore(oldIndex, newIndex, userController.socialMediaList!);
}
