import 'package:busniess_card_app/Controllers/auth_controller.dart';
import 'package:busniess_card_app/Controllers/controller_visit_user.dart';
import 'package:busniess_card_app/Controllers/saved_user_controller.dart';
import 'package:busniess_card_app/Controllers/user_controller.dart';
import 'package:busniess_card_app/Services/dynamiclink_service.dart';
import 'package:busniess_card_app/Utils/global_veriables.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthCheckBinding implements Bindings {
  @override
  void dependencies() {
    if (Get.find<AuthController>().userGetter != null) {
      debugPrint('auth checking...');
      DynamicLink().handleDynamicLinks();
      isSigned.value = true;
      userID.value = Get.find<AuthController>().userGetter!.uid;
      debugPrint('----USER FOUND ${userID.value}');
      Get.put(UserController());
    } else {
      if (!kIsWeb) DynamicLink().handleDynamicLinks();
      isSigned.value = false;
      debugPrint('-----USER NOT FOUND-----');
    }
  }
}

class VisitUserBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VisitUserController>(() => VisitUserController());
  }
}

class SavedUserBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SavedUserController>(() => SavedUserController());
  }
}
