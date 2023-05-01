import 'dart:ui';

import 'package:busniess_card_app/Bindings/all_bindings.dart';
import 'package:busniess_card_app/Controllers/saved_user_controller.dart';
import 'package:busniess_card_app/Services/firestore_service.dart';
import 'package:busniess_card_app/Utils/colors.dart';
import 'package:busniess_card_app/Utils/global_veriables.dart';
import 'package:busniess_card_app/Views/VisiterUser/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../main.dart';

class SavedUsersView extends StatelessWidget {
  SavedUsersView({Key? key}) : super(key: key);
  final savedUserController = Get.find<SavedUserController>();
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
                backgroundColor: kMainColor,
                title: const Text('Profilo Contacts'),
                elevation: 0,
              ),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(() {
                    if (savedUserController.savedUserList == null) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: kMainColor,
                        ),
                      );
                    } else if (savedUserController.savedUserList!.isNotEmpty) {
                      var users = savedUserController.savedUserList!;
                      return ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: users.length,
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                          itemBuilder: (context, index) {
                            return Slidable(
                              actionPane: const SlidableDrawerActionPane(),
                              actionExtentRatio: 0.25,
                              secondaryActions: [
                                IconButton(
                                    onPressed: () async {
                                      await Database()
                                          .deleteVisitUser(users[index].uid!);
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: kRedColor,
                                    ))
                              ],
                              actions: [
                                IconButton(
                                    onPressed: () async {
                                      await Database()
                                          .deleteVisitUser(users[index].uid!);
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: kRedColor,
                                    ))
                              ],
                              child: Container(
                                decoration: BoxDecoration(
                                    color: kDarkLightColor,
                                    borderRadius: BorderRadius.circular(12)),
                                child: ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      users[index].imgUrl!,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(
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
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        return SvgPicture.asset(
                                          'assets/user.svg',
                                          width: 58,
                                        );
                                      },
                                    ),
                                  ),
                                  title: Text(
                                    users[index].name!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: kBrightColor),
                                  ),
                                  subtitle: Text(
                                    users[index].desc!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: kBrightColor),
                                  ),
                                  trailing: IconButton(
                                      onPressed: () {
                                        visitUserID.value = users[index].uid;
                                        Get.to(
                                          () => ProfileView(),
                                          binding: VisitUserBinding(),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.launch,
                                        color: kBrightColor,
                                      )),
                                ),
                              ),
                            );
                          });
                    } else {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 40),
                            SvgPicture.asset(
                              'assets/svg/nocontact.svg',
                              width: 200,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'You have no contacts saved.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: kBrightColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
