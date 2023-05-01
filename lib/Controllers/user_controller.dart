import 'package:busniess_card_app/Models/socialmedia_model.dart';
import 'package:busniess_card_app/Models/user_model.dart';
import 'package:busniess_card_app/Services/firestore_service.dart';
import 'package:busniess_card_app/Utils/global_veriables.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  Rxn<List<UserModel>> userModel = Rxn<List<UserModel>>();
  Rxn<List<SocialMediaModel>> socialMedia = Rxn<List<SocialMediaModel>>();

  UserModel? get userGetter => userModel.value?.first;

  List<SocialMediaModel>? get socialMediaList => socialMedia.value;

  @override
  void onInit() {
    print('userController initilized:::::::::::');
    if (isSigned.value!) {
      userModel.bindStream(Database().userStreamm(userID.value!));
      socialMedia.bindStream(Database().socialMediaStream(userID.value!));
    } else {}
    super.onInit();
  }

  // void updateUser() {
  //   userModel.bindStream(Stream.fromFuture(Database().getUser(userID.value!)));
  // }

  set userSetter(UserModel value) {
    userModel.value?.first = value;
  }

  void clear() {
    userModel.value?.first = UserModel();
  }
}
