import 'package:busniess_card_app/Models/save_user_model.dart';
import 'package:busniess_card_app/Services/firestore_service.dart';
import 'package:get/get.dart';

class SavedUserController extends GetxController {
  Rxn<List<SaveUserModel>> savedUsers = Rxn<List<SaveUserModel>>();

  List<SaveUserModel>? get savedUserList => savedUsers.value;

  @override
  void onInit() {
    savedUsers.bindStream(Database().savedUserStream());
    super.onInit();
  }
}
