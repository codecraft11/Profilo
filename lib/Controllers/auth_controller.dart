import 'package:busniess_card_app/Controllers/user_controller.dart';
import 'package:busniess_card_app/Models/user_model.dart';
import 'package:busniess_card_app/Services/dynamiclink_service.dart';
import 'package:busniess_card_app/Services/firestore_service.dart';
import 'package:busniess_card_app/Utils/colors.dart';
import 'package:busniess_card_app/Utils/global_veriables.dart';
import 'package:busniess_card_app/Views/Authentication/login_view.dart';
import 'package:busniess_card_app/Views/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  Rxn<User> firebaseUser = Rxn<User>();

  User? get userGetter => firebaseUser.value;

  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(auth.authStateChanges());
  }

  Future<void> createUser(String name, String email, String password) async {
    try {
      UserCredential _authResult = await auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
      String link =
          await DynamicLink().createDynamicLink(_authResult.user!.uid);
      // if (!kIsWeb) {
      //   link = await DynamicLink().createDynamicLink(_authResult.user!.uid);
      // }
      UserModel _userModel = UserModel(
        id: _authResult.user!.uid,
        name: name,
        email: email,
        description: 'I am Profilo user',
        dynamicLink: link,
        imageUrl: '',
        direct: false,
        tag: true,
      );
      await Database().createUser(_userModel);
      Get.back(
        canPop: true,
      );
      Get.snackbar(
        "SignedUp",
        'Account Created Successfuly',
        backgroundColor: kMainColor,
        colorText: kBrightColor,
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar(
        "Error in Creating Account",
        e.toString(),
        backgroundColor: kRedColor,
        colorText: kBrightColor,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> logIn(String email, String password) async {
    try {
      UserCredential _authResult = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      isSigned.value = true;
      userID.value = _authResult.user!.uid;
      Get.put(UserController()).onInit();

      Get.offAll(
        () => HomeView(),
        duration: const Duration(seconds: 1),
        transition: Transition.zoom,
      );
      Get.snackbar(
        "SignedIn",
        "Signedin Successfully",
        backgroundColor: kMainColor,
        colorText: kBrightColor,
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar(
        "Error in Signing In",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kRedColor,
        colorText: kBrightColor,
      );
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      Get.snackbar(
        'Password Reset',
        'Recovery email has been sent!',
        backgroundColor: kMainColor,
        colorText: kBrightColor,
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        'Resetting failed',
        e.toString(),
        backgroundColor: kRedColor,
        colorText: kBrightColor,
      );
    }
  }

  Future<bool> validatePasttword(String password) async {
    var user = auth.currentUser!;
    try {
      var authCredentials =
          EmailAuthProvider.credential(email: user.email!, password: password);

      var authResult = await user.reauthenticateWithCredential(authCredentials);
      return true;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return false;
    }
    // return authResult.user != null;
  }

  Future<void> changePassword(String newPassword) async {
    var user = auth.currentUser!;
    try {
      await user.updatePassword(newPassword);
      Get.snackbar(
        'Successful',
        'Password Changed Successfully.',
        backgroundColor: kMainColor,
        colorText: kBrightColor,
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        'Failed',
        e.toString(),
        backgroundColor: kRedColor,
        colorText: kBrightColor,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  //! Google Signin

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
    ],
  );

  Future<void> googleLogin() async {
    try {
      var googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      UserCredential authResult =
          await auth.signInWithCredential(authCredential);

      if (authResult.additionalUserInfo!.isNewUser) {
        String link =
            await DynamicLink().createDynamicLink(authResult.user!.uid);
        UserModel _userModel = UserModel(
          id: authResult.user!.uid,
          name: authResult.user!.displayName,
          email: authResult.user!.email,
          description: 'I am Profilo user',
          dynamicLink: link,
          imageUrl: authResult.user!.photoURL ?? '',
          direct: false,
          tag: true,
        );
        await Database().createUser(_userModel);
      }

      isSigned.value = true;
      userID.value = authResult.user!.uid;
      Get.put(UserController()).onInit();

      Get.offAll(
        () => HomeView(),
        duration: const Duration(seconds: 1),
        transition: Transition.zoom,
      );
      Get.snackbar(
        "SignedIn",
        "Signedin Successfully",
        snackPosition: SnackPosition.TOP,
        backgroundColor: kMainColor,
        colorText: kBrightColor,
      );
    } catch (error) {
      print("Google:" + error.toString());
      Get.snackbar(
        'Failed',
        error.toString(),
        backgroundColor: kRedColor,
        colorText: kBrightColor,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> signOut() async {
    try {
      final googleSignin = GoogleSignIn();
      await googleSignin.signOut();
      await auth.signOut();

      isSigned.value = false;
      userID.value = '';
      await Get.offAll(() => LoginView());
    } catch (e) {
      Get.snackbar(
        "Error in Signing Out",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kRedColor,
        colorText: kBrightColor,
      );
    }
  }
}
