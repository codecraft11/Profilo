import 'package:busniess_card_app/Controllers/controller_visit_user.dart';
import 'package:busniess_card_app/Models/save_user_model.dart';
import 'package:busniess_card_app/Services/firestore_service.dart';
import 'package:busniess_card_app/Utils/colors.dart';
import 'package:busniess_card_app/Utils/global_veriables.dart';
import 'package:busniess_card_app/Views/Authentication/login_view.dart';
import 'package:busniess_card_app/Views/Widgets/social_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';

class ProfileView extends StatelessWidget {
  ProfileView({
    Key? key,
  }) : super(key: key);
  final visitUserController = Get.find<VisitUserController>();
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
                iconTheme: const IconThemeData(
                  color: kBrightColor,
                ),
                centerTitle: true,
                backgroundColor: kMainColor,
                elevation: 0,
                title: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Image.asset(
                    'assets/images/profilomain.png',
                    height: 40,
                    color: kBrightColor,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Obx(() {
                      if (visitUserController.userGetter == null) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: kMainColor,
                          ),
                        );
                      } else {
                        return Container(
                          height: 240,
                          child: Stack(
                            children: [
                              // Container(
                              //   color: kMainColor,
                              //   height: 240 - 22,
                              //   width: double.infinity,
                              //   child: Image.asset(
                              //     'assets/images/bubble.png',
                              //     fit: BoxFit.cover,
                              //   ),
                              // ),
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
                                                visitUserController
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
                                          visitUserController.userGetter!.name!,
                                          style: const TextStyle(
                                            color: kBrightColor,
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          visitUserController
                                              .userGetter!.description!,
                                          style: const TextStyle(
                                            color: kBrightColor,
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
                                    width: 200,
                                    child: MaterialButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      color: kMainColor,
                                      child: Text(
                                        isSigned.value!
                                            ? ' Save User'
                                            : 'Login',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: kBrightColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                      onPressed: () async {
                                        if (isSigned.value == true) {
                                          SaveUserModel model = SaveUserModel(
                                            uid: visitUserController
                                                .userGetter!.id,
                                            name: visitUserController
                                                .userGetter!.name,
                                            desc: visitUserController
                                                .userGetter!.description,
                                            imgUrl: visitUserController
                                                .userGetter!.imageUrl,
                                          );
                                          await Database().saveUser(model);
                                          Get.snackbar('User Added',
                                              'User Successfuly added to Contacts.',
                                              backgroundColor: kDarkColor,
                                              colorText: kBrightColor,
                                              snackPosition: SnackPosition.TOP);
                                        } else {
                                          Get.offAll(
                                            () => LoginView(),
                                            duration:
                                                const Duration(seconds: 1),
                                            transition: Transition.zoom,
                                          );
                                        }
                                      },
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
                      if (visitUserController.socialMediaList == null) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: kMainColor,
                          ),
                        );
                      } else if (visitUserController.socialMediaList!.length >
                          0) {
                        if (visitUserController.userGetter!.direct == true) {
                          launch(
                              visitUserController.socialMediaList!.first.link!);
                        }
                        return GridView.builder(
                            // physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemCount: visitUserController.userGetter!.direct!
                                ? 1
                                : visitUserController.socialMediaList!.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  launch(visitUserController
                                      .socialMediaList![index].link!);
                                },
                                child: SocialCard(
                                  lable: visitUserController
                                      .socialMediaList![index].linkName!,
                                ),
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
                              'User has no Social Data',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: kBrightColor,
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
