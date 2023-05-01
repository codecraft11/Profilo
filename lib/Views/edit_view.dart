import 'dart:io';
import 'package:busniess_card_app/Controllers/user_controller.dart';
import 'package:busniess_card_app/Services/firebase_storage_service.dart';
import 'package:busniess_card_app/Services/firestore_service.dart';
import 'package:busniess_card_app/Utils/colors.dart';
import 'package:busniess_card_app/Views/Widgets/bottom_update_widget.dart';
import 'package:busniess_card_app/Views/Widgets/edit_socialcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../main.dart';

// ignore: must_be_immutable
class EditView extends StatelessWidget {
  EditView({Key? key}) : super(key: key);

  final userController = Get.find<UserController>();

  late File image;
  final imageIsNull = true.obs;

  final isUploading = false.obs;
  chooseImage() async {
    final imgPicker = ImagePicker();
    try {
      PickedFile? pickedFile = await imgPicker.getImage(
          source: ImageSource.gallery, imageQuality: 20);
      image = File(pickedFile!.path);
      imageIsNull.value = false;
    } catch (e) {
      imageIsNull.value = true;
      Get.snackbar('Error', 'Select an Image to Upload');
    }
  }

  final TextEditingController socialController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController =
        TextEditingController(text: userController.userGetter!.name);
    final TextEditingController descController =
        TextEditingController(text: userController.userGetter!.description);
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
                elevation: 0,
                centerTitle: true,
                title: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(
                      color: kFadedColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
              body: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: SingleChildScrollView(
                    child: Obx(
                  () => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                            color: backgroundColor,
                            width: double.infinity,
                            height: 240,
                            // height: Get.height * 0.32,
                            // child: Image.asset(
                            //   'assets/images/bubble.png',
                            //   fit: BoxFit.cover,
                            //   // height: 300,
                            // ),
                          ),
                          SizedBox(
                            height: 240,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    alignment: Alignment.center,
                                    child: Stack(
                                      alignment: Alignment.center,
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
                                            child: Obx(
                                              () => ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(60),
                                                child: isUploading.value
                                                    ? const Center(
                                                        child:
                                                            const CircularProgressIndicator(),
                                                      )
                                                    : Image.network(
                                                        userController
                                                            .userGetter!
                                                            .imageUrl!,
                                                        fit: BoxFit.cover,
                                                        loadingBuilder:
                                                            (BuildContext
                                                                    context,
                                                                Widget child,
                                                                ImageChunkEvent?
                                                                    loadingProgress) {
                                                          if (loadingProgress ==
                                                              null) {
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
                                                        errorBuilder:
                                                            (BuildContext
                                                                    context,
                                                                Object
                                                                    exception,
                                                                StackTrace?
                                                                    stackTrace) {
                                                          return SvgPicture
                                                              .asset(
                                                            'assets/user.svg',
                                                            width: 122,
                                                          );
                                                        },
                                                      ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                width: 3,
                                                color: kMainColor,
                                              ),
                                              color: kDarkColor,
                                            ),
                                            height: 35,
                                            width: 35,
                                            child: Center(
                                              child: GestureDetector(
                                                onTap: () async {
                                                  await chooseImage();
                                                  if (imageIsNull.value ==
                                                      false) {
                                                    isUploading.value = true;
                                                    String url = await Storage()
                                                        .imageUploadToStorage(
                                                            image);
                                                    await Database()
                                                        .updateProfilePic(url);
                                                    isUploading.value = false;
                                                  }
                                                },
                                                child: const Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(width: 50),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 2),
                                        decoration: BoxDecoration(
                                            color: kDarkColor,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Text(
                                          userController.userGetter!.name!,
                                          maxLines: 1,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: kBrightColor),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            Get.bottomSheet(
                                              UpdateWidget(
                                                controller: nameController,
                                                lable: 'Name',
                                                ontap: () async {
                                                  await Database().updateName(
                                                      nameController.text);
                                                  Get.back();
                                                },
                                              ),
                                            );
                                          },
                                          icon: const Icon(Icons.edit))
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(width: 50),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 2),
                                        decoration: BoxDecoration(
                                            color: kDarkLightColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                          userController
                                              .userGetter!.description!,
                                          maxLines: 1,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: kBrightColor),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            Get.bottomSheet(
                                              UpdateWidget(
                                                controller: descController,
                                                lable: 'Description',
                                                ontap: () async {
                                                  await Database()
                                                      .updateDescription(
                                                          descController.text);
                                                  Get.back();
                                                },
                                              ),
                                            );
                                          },
                                          icon: const Icon(Icons.edit))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'Add Social Media',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: kBrightColor),
                      ),
                      Wrap(
                        // alignment: WrapAlignment.spaceEvenly,
                        // runAlignment: WrapAlignment.spaceEvenly,
                        // crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          EditSocialCard(
                            added: userController.socialMediaList!.any(
                                (element) =>
                                    element.linkName!.contains('Facebook')),
                            lable: 'Facebook',
                            controller: socialController,
                            prefix: 'https://facebook.com/',
                            onAdd: () async {
                              if (socialController.text != '') {
                                await Database().addSocial('Facebook',
                                    'https://facebook.com/${socialController.text}');
                                socialController.clear();
                                Get.back();
                              } else {
                                Get.snackbar('Error', 'Enter Valid Link',
                                    backgroundColor: kRedColor);
                              }
                            },
                            onDelete: () async {
                              await Database().deleteSocial('Facebook');
                              Get.back();
                            },
                          ),
                          EditSocialCard(
                            added: userController.socialMediaList!.any(
                                (element) =>
                                    element.linkName!.contains('Instagram')),
                            lable: 'Instagram',
                            controller: socialController,
                            prefix: 'https://instagram.com/',
                            onAdd: () async {
                              if (socialController.text != '') {
                                await Database().addSocial('Instagram',
                                    'https://instagram.com/${socialController.text}');
                                socialController.clear();
                                Get.back();
                              } else {
                                Get.snackbar('Error', 'Enter Valid Username',
                                    backgroundColor: kRedColor);
                              }
                            },
                            onDelete: () async {
                              await Database().deleteSocial('Instagram');
                              Get.back();
                            },
                          ),
                          EditSocialCard(
                            added: userController.socialMediaList!.any(
                                (element) =>
                                    element.linkName!.contains('Linkedin')),
                            lable: 'Linkedin',
                            controller: socialController,
                            prefix: 'https://linkedin.com/',
                            onAdd: () async {
                              if (socialController.text != '') {
                                await Database().addSocial('Linkedin',
                                    'https://linkedin.com/${socialController.text}');
                                socialController.clear();
                                Get.back();
                              } else {
                                Get.snackbar('Error', 'Enter Valid Link',
                                    backgroundColor: kRedColor);
                              }
                            },
                            onDelete: () async {
                              await Database().deleteSocial('Linkedin');
                              Get.back();
                            },
                          ),
                          EditSocialCard(
                            added: userController.socialMediaList!.any(
                                (element) =>
                                    element.linkName!.contains('Pinterest')),
                            lable: 'Pinterest',
                            controller: socialController,
                            prefix: 'https://www.pinterest.com/',
                            onAdd: () async {
                              if (socialController.text != '') {
                                await Database().addSocial('Pinterest',
                                    'https://www.pinterest.com/${socialController.text}');
                                socialController.clear();
                                Get.back();
                              } else {
                                Get.snackbar('Error', 'Enter Valid Url',
                                    backgroundColor: kRedColor);
                              }
                            },
                            onDelete: () async {
                              await Database().deleteSocial('Pinterest');
                              Get.back();
                            },
                          ),
                          EditSocialCard(
                            added: userController.socialMediaList!.any(
                                (element) =>
                                    element.linkName!.contains('Snapchat')),
                            lable: 'Snapchat',
                            controller: socialController,
                            prefix: 'https://www.snapchat.com/add/',
                            onAdd: () async {
                              if (socialController.text != '') {
                                await Database().addSocial('Snapchat',
                                    'https://www.snapchat.com/add/${socialController.text}');
                                socialController.clear();
                                Get.back();
                              } else {
                                Get.snackbar('Error', 'Enter Valid Username',
                                    backgroundColor: kRedColor);
                              }
                            },
                            onDelete: () async {
                              await Database().deleteSocial('Snapchat');
                              Get.back();
                            },
                          ),
                          EditSocialCard(
                            added: userController.socialMediaList!.any(
                                (element) =>
                                    element.linkName!.contains('TikTok')),
                            lable: 'TikTok',
                            controller: socialController,
                            prefix: 'https://www.tiktok.com/',
                            onAdd: () async {
                              if (socialController.text != '') {
                                await Database().addSocial('TikTok',
                                    'https://www.tiktok.com/${socialController.text}');
                                socialController.clear();
                                Get.back();
                              } else {
                                Get.snackbar('Error', 'Enter Valid Link',
                                    backgroundColor: kRedColor);
                              }
                            },
                            onDelete: () async {
                              await Database().deleteSocial('TikTok');
                              Get.back();
                            },
                          ),
                          EditSocialCard(
                            added: userController.socialMediaList!.any(
                                (element) =>
                                    element.linkName!.contains('Twitch')),
                            lable: 'Twitch',
                            controller: socialController,
                            prefix: 'https://www.twitch.tv/',
                            onAdd: () async {
                              if (socialController.text != '') {
                                await Database().addSocial('Twitch',
                                    'https://www.twitch.tv/${socialController.text}');
                                socialController.clear();
                                Get.back();
                              } else {
                                Get.snackbar('Error', 'Enter Valid Link',
                                    backgroundColor: kRedColor);
                              }
                            },
                            onDelete: () async {
                              await Database().deleteSocial('Twitch');
                              Get.back();
                            },
                          ),
                          EditSocialCard(
                            added: userController.socialMediaList!.any(
                                (element) =>
                                    element.linkName!.contains('Twitter')),
                            lable: 'Twitter',
                            controller: socialController,
                            prefix: 'https://twitter.com/',
                            onAdd: () async {
                              if (socialController.text != '') {
                                await Database().addSocial('Twitter',
                                    'https://twitter.com/${socialController.text}');
                                socialController.clear();
                                Get.back();
                              } else {
                                Get.snackbar('Error', 'Enter Valid Link',
                                    backgroundColor: kRedColor);
                              }
                            },
                            onDelete: () async {
                              await Database().deleteSocial('Twitter');
                              Get.back();
                            },
                          ),
                          EditSocialCard(
                            added: userController.socialMediaList!.any(
                                (element) =>
                                    element.linkName!.contains('Youtube')),
                            lable: 'Youtube',
                            controller: socialController,
                            prefix: 'https://youtube.com/',
                            onAdd: () async {
                              if (socialController.text != '') {
                                await Database().addSocial('Youtube',
                                    'https://youtube.com/${socialController.text}');
                                socialController.clear();
                                Get.back();
                              } else {
                                Get.snackbar('Error', 'Enter Valid Link',
                                    backgroundColor: kRedColor);
                              }
                            },
                            onDelete: () async {
                              await Database().deleteSocial('Youtube');
                              Get.back();
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Add Contacts',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: kBrightColor,
                        ),
                      ),
                      Wrap(
                        children: [
                          EditSocialCard(
                            added: userController.socialMediaList!.any(
                                (element) =>
                                    element.linkName!.contains('Call')),
                            lable: 'Call',
                            controller: socialController,
                            prefix: 'Phone # :  ',
                            onAdd: () async {
                              if (GetUtils.isNumericOnly(
                                  socialController.text)) {
                                await Database().addSocial(
                                    'Call', 'tel:${socialController.text}');
                                socialController.clear();
                                Get.back();
                              } else {
                                Get.snackbar('Error', 'Enter Valid Number',
                                    backgroundColor: kRedColor);
                              }
                            },
                            onDelete: () async {
                              await Database().deleteSocial('Call');
                              Get.back();
                            },
                          ),
                          EditSocialCard(
                            added: userController.socialMediaList!.any(
                                (element) =>
                                    element.linkName!.contains('Email')),
                            lable: 'Email',
                            controller: socialController,
                            prefix: 'Email :  ',
                            onAdd: () async {
                              if (GetUtils.isEmail(socialController.text)) {
                                await Database().addSocial(
                                    'Email', 'mailto:${socialController.text}');
                                socialController.clear();
                                Get.back();
                              } else {
                                Get.snackbar('Error', 'Enter Valid Email',
                                    backgroundColor: kRedColor);
                              }
                            },
                            onDelete: () async {
                              await Database().deleteSocial('Email');
                              Get.back();
                            },
                          ),
                          EditSocialCard(
                            added: userController.socialMediaList!.any(
                                (element) =>
                                    element.linkName!.contains('WhatsApp')),
                            lable: 'WhatsApp',
                            controller: socialController,
                            prefix: 'WhatsApp # :  +',
                            onAdd: () async {
                              if (GetUtils.isPhoneNumber(
                                  socialController.text)) {
                                await Database().addSocial('WhatsApp',
                                    'https://api.whatsapp.com/send?phone=+${socialController.text}&text= ');
                                socialController.clear();
                                Get.back();
                              } else {
                                Get.snackbar(
                                    'Error', 'Enter Valid WhatsApp Number',
                                    backgroundColor: kRedColor);
                              }
                            },
                            onDelete: () async {
                              await Database().deleteSocial('WhatsApp');
                              Get.back();
                            },
                          ),
                          EditSocialCard(
                            added: userController.socialMediaList!.any(
                                (element) =>
                                    element.linkName!.contains('Website')),
                            lable: 'Website',
                            controller: socialController,
                            prefix: 'Website :  ',
                            onAdd: () async {
                              if (GetUtils.isURL(socialController.text)) {
                                await Database().addSocial(
                                    'Website', socialController.text);
                                socialController.clear();
                                Get.back();
                              } else {
                                Get.snackbar('Error', 'Enter Valid Link',
                                    backgroundColor: kRedColor);
                              }
                            },
                            onDelete: () async {
                              await Database().deleteSocial('Website');
                              Get.back();
                            },
                          ),
                          EditSocialCard(
                            added: userController.socialMediaList!.any(
                                (element) =>
                                    element.linkName!.contains('Maps')),
                            lable: 'Maps',
                            controller: socialController,
                            prefix: 'Maps Link :  ',
                            onAdd: () async {
                              if (GetUtils.isURL(socialController.text)) {
                                await Database()
                                    .addSocial('Maps', socialController.text);
                                socialController.clear();
                                Get.back();
                              } else {
                                Get.snackbar('Error', 'Enter Valid Link',
                                    backgroundColor: kRedColor);
                              }
                            },
                            onDelete: () async {
                              await Database().deleteSocial('Maps');
                              Get.back();
                            },
                          ),
                          EditSocialCard(
                            added: userController.socialMediaList!.any(
                                (element) =>
                                    element.linkName!.contains('Facetime')),
                            lable: 'Facetime',
                            controller: socialController,
                            prefix: 'Facetime :  ',
                            onAdd: () async {
                              if (GetUtils.isURL(socialController.text)) {
                                await Database().addSocial(
                                    'Facetime', socialController.text);
                                socialController.clear();
                                Get.back();
                              } else {
                                Get.snackbar('Error', 'Enter Valid Link',
                                    backgroundColor: kRedColor);
                              }
                            },
                            onDelete: () async {
                              await Database().deleteSocial('Facetime');
                              Get.back();
                            },
                          ),
                        ],
                      ),
                      const Text(
                        'Add Music',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: kBrightColor,
                        ),
                      ),
                      Wrap(
                        children: [
                          EditSocialCard(
                            added: userController.socialMediaList!.any(
                                (element) =>
                                    element.linkName!.contains('Spotify')),
                            lable: 'Spotify',
                            controller: socialController,
                            prefix: 'Spotify : ',
                            onAdd: () async {
                              if (GetUtils.isURL(socialController.text)) {
                                await Database().addSocial(
                                    'Spotify', socialController.text);
                                socialController.clear();
                                Get.back();
                              } else {
                                Get.snackbar('Error', 'Enter Valid Link',
                                    backgroundColor: kRedColor);
                              }
                            },
                            onDelete: () async {
                              await Database().deleteSocial('Spotify');
                              Get.back();
                            },
                          ),
                          EditSocialCard(
                            added: userController.socialMediaList!.any(
                                (element) =>
                                    element.linkName!.contains('AppleMusic')),
                            lable: 'AppleMusic',
                            controller: socialController,
                            prefix: 'AppleMusic : ',
                            onAdd: () async {
                              if (GetUtils.isURL(socialController.text)) {
                                await Database().addSocial(
                                    'AppleMusic', socialController.text);
                                socialController.clear();
                                Get.back();
                              } else {
                                Get.snackbar('Error', 'Enter Valid Link',
                                    backgroundColor: kRedColor);
                              }
                            },
                            onDelete: () async {
                              await Database().deleteSocial('AppleMusic');
                              Get.back();
                            },
                          ),
                          EditSocialCard(
                            added: userController.socialMediaList!.any(
                                (element) =>
                                    element.linkName!.contains('Soundcloud')),
                            lable: 'Soundcloud',
                            prefix: 'Soundcloud : ',
                            controller: socialController,
                            onAdd: () async {
                              if (GetUtils.isURL(socialController.text)) {
                                await Database().addSocial(
                                    'Soundcloud', socialController.text);
                                socialController.clear();
                                Get.back();
                              } else {
                                Get.snackbar('Error', 'Enter Valid Link',
                                    backgroundColor: kRedColor);
                              }
                            },
                            onDelete: () async {
                              await Database().deleteSocial('Soundcloud');
                              Get.back();
                            },
                          ),
                        ],
                      ),
                      const Text(
                        'Add More',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: kBrightColor,
                        ),
                      ),
                      Wrap(
                        children: [
                          EditSocialCard(
                            added: userController.socialMediaList!.any(
                                (element) =>
                                    element.linkName!.contains('CustomLink')),
                            lable: 'CustomLink',
                            controller: socialController,
                            prefix: 'Link : ',
                            onAdd: () async {
                              if (GetUtils.isURL(socialController.text)) {
                                await Database().addSocial(
                                    'CustomLink', socialController.text);
                                socialController.clear();
                                Get.back();
                              } else {
                                Get.snackbar('Error', 'Enter Valid Link',
                                    backgroundColor: kRedColor);
                              }
                            },
                            onDelete: () async {
                              await Database().deleteSocial('CustomLink');
                              Get.back();
                            },
                          ),
                          EditSocialCard(
                            added: userController.socialMediaList!.any(
                                (element) =>
                                    element.linkName!.contains('Linktree')),
                            lable: 'Linktree',
                            controller: socialController,
                            prefix: 'https://linktr.ee/',
                            onAdd: () async {
                              if (socialController.text != '') {
                                await Database().addSocial('Linktree',
                                    'https://linktr.ee/${socialController.text}');
                                socialController.clear();
                                Get.back();
                              } else {
                                Get.snackbar('Error', 'Enter Valid Link',
                                    backgroundColor: kRedColor);
                              }
                            },
                            onDelete: () async {
                              await Database().deleteSocial('Linktree');
                              Get.back();
                            },
                          ),
                          EditSocialCard(
                            added: userController.socialMediaList!.any(
                                (element) =>
                                    element.linkName!.contains('OnlyFans')),
                            lable: 'OnlyFans',
                            controller: socialController,
                            prefix: 'Onlyfans Link :  ',
                            onAdd: () async {
                              if (GetUtils.isURL(socialController.text)) {
                                await Database().addSocial(
                                    'OnlyFans', socialController.text);
                                socialController.clear();
                                Get.back();
                              } else {
                                Get.snackbar('Error', 'Enter Valid Link',
                                    backgroundColor: kRedColor);
                              }
                            },
                            onDelete: () async {
                              await Database().deleteSocial('OnlyFans');
                              Get.back();
                            },
                          ),
                          EditSocialCard(
                            added: userController.socialMediaList!.any(
                                (element) =>
                                    element.linkName!.contains('Podcasts')),
                            lable: 'Podcasts',
                            controller: socialController,
                            prefix: 'Podcasts Link :  ',
                            onAdd: () async {
                              if (GetUtils.isURL(socialController.text)) {
                                await Database().addSocial(
                                    'Podcasts', socialController.text);
                                socialController.clear();
                                Get.back();
                              } else {
                                Get.snackbar('Error', 'Enter Valid Link',
                                    backgroundColor: kRedColor);
                              }
                            },
                            onDelete: () async {
                              await Database().deleteSocial('Podcasts');
                              Get.back();
                            },
                          ),
                          EditSocialCard(
                            added: userController.socialMediaList!.any(
                                (element) =>
                                    element.linkName!.contains('Yelp')),
                            lable: 'Yelp',
                            controller: socialController,
                            prefix: 'Yelp Link :  ',
                            onAdd: () async {
                              if (GetUtils.isURL(socialController.text)) {
                                await Database()
                                    .addSocial('Yelp', socialController.text);
                                socialController.clear();
                                Get.back();
                              } else {
                                Get.snackbar('Error', 'Enter Valid Link',
                                    backgroundColor: kRedColor);
                              }
                            },
                            onDelete: () async {
                              await Database().deleteSocial('Yelp');
                              Get.back();
                            },
                          ),
                          EditSocialCard(
                            added: userController.socialMediaList!.any(
                                (element) =>
                                    element.linkName!.contains('Clubhouse')),
                            lable: 'Clubhouse',
                            controller: socialController,
                            prefix: 'Clubhouse Link :  ',
                            onAdd: () async {
                              if (GetUtils.isURL(socialController.text)) {
                                await Database().addSocial(
                                    'Clubhouse', socialController.text);
                                socialController.clear();
                                Get.back();
                              } else {
                                Get.snackbar('Error', 'Enter Valid Link',
                                    backgroundColor: kRedColor);
                              }
                            },
                            onDelete: () async {
                              await Database().deleteSocial('Clubhouse');
                              Get.back();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
