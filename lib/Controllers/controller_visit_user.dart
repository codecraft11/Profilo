import 'package:busniess_card_app/Models/model_visit_user.dart';
import 'package:busniess_card_app/Services/firestore_service.dart';
import 'package:busniess_card_app/Utils/global_veriables.dart';
import 'package:get/get.dart';

class VisitUserController extends GetxController {
  Rxn<List<VisitUserModel>> userModel = Rxn<List<VisitUserModel>>();
  Rxn<List<VisitUserSocialModel>> socialMedia =
      Rxn<List<VisitUserSocialModel>>();

  VisitUserModel? get userGetter => userModel.value?.first;

  List<VisitUserSocialModel>? get socialMediaList => socialMedia.value;

  @override
  void onInit() {
    print('userController initilized:::::::::::');

    userModel.bindStream(Database().visitUserStream(visitUserID.value!));
    socialMedia
        .bindStream(Database().visitUserSocialStream(visitUserID.value!));

    super.onInit();
  }

  // void updateUser() {
  //   userModel.bindStream(Stream.fromFuture(Database().getUser(userID.value!)));
  // }

  // set userSetter(UserModel value) {
  //   userModel.value?.first = value;
  // }

  // void clear() {
  //   userModel.value?.first = UserModel();
  // }
}
