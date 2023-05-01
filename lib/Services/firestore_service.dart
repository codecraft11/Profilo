import 'package:busniess_card_app/Models/model_visit_user.dart';
import 'package:busniess_card_app/Models/save_user_model.dart';
import 'package:busniess_card_app/Models/socialmedia_model.dart';
import 'package:busniess_card_app/Models/user_model.dart';
import 'package:busniess_card_app/Utils/global_veriables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Database {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //! Regarding Users

  Future<bool> createUser(UserModel userModel) async {
    try {
      await firestore
          .collection("users")
          .doc(userModel.id)
          .collection('userDetials')
          .doc('userDetials')
          .set({
        "id": userModel.id,
        "name": userModel.name,
        "email": userModel.email,
        "description": userModel.description,
        "dynamicLink": userModel.dynamicLink,
        'imageUrl': userModel.imageUrl,
        'direct': userModel.direct,
        'tag': userModel.tag,
      });
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  // Future<UserModel> getUser(String uid) async {
  //   try {
  //     DocumentSnapshot _doc =
  //         await firestore.collection("users").doc(uid).get();
  //     return UserModel.fromFirestore(_doc);
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     rethrow;
  //   }
  // }

  Stream<List<UserModel>> userStreamm(String uid) {
    return firestore
        .collection('users')
        .doc(uid)
        .collection('userDetials')
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<UserModel> retVal = [];
      querySnapshot.docs.forEach((element) {
        retVal.add(UserModel.fromFirestore(element));
      });
      return retVal;
    });
  }

  //! Social Media Links

  Stream<List<SocialMediaModel>> socialMediaStream(String uid) {
    return firestore
        .collection('users')
        .doc(uid)
        .collection('socialMedia')
        .orderBy('pos', descending: false)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<SocialMediaModel> retVal = [];
      querySnapshot.docs.forEach((element) {
        retVal.add(SocialMediaModel.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }

  //! Update Data
  Future<void> updateProfilePic(imageUrl) async {
    await firestore
        .collection("users")
        .doc(userID.value)
        .collection('userDetials')
        .doc('userDetials')
        .update({"imageUrl": imageUrl});
  }

  Future<void> updateName(name) async {
    await firestore
        .collection("users")
        .doc(userID.value)
        .collection('userDetials')
        .doc('userDetials')
        .update({"name": name});
  }

  Future<void> updateDescription(description) async {
    await firestore
        .collection("users")
        .doc(userID.value)
        .collection('userDetials')
        .doc('userDetials')
        .update({"description": description});
  }

  Future<void> updateDirect(bool direct) async {
    await firestore
        .collection("users")
        .doc(userID.value)
        .collection('userDetials')
        .doc('userDetials')
        .update({"direct": direct});
  }

  //! Social Data

  Future<void> addSocial(String name, String link) async {
    await firestore
        .collection("users")
        .doc(userID.value)
        .collection('socialMedia')
        .doc(name)
        .set({
      "linkName": name,
      "link": link,
      "pos": 0,
    });
  }

  Future<void> deleteSocial(String name) async {
    await firestore
        .collection("users")
        .doc(userID.value)
        .collection('socialMedia')
        .doc(name)
        .delete();
  }

  //? Dragging update
  void onReorderFireStore(
      int oldIndex, int newIndex, List<SocialMediaModel> docs) {
    final batch = firestore.batch();
    for (int pos = 0; pos < docs.length; pos++) {
      batch.update(
          firestore
              .collection("users")
              .doc(userID.value)
              .collection('socialMedia')
              .doc(docs[pos].linkName),
          ({'pos': pos}));
    }
    batch.commit();
  }

  //! Visit User Functions
  Stream<List<VisitUserModel>> visitUserStream(String uid) {
    return firestore
        .collection('users')
        .doc(uid)
        .collection('userDetials')
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<VisitUserModel> retVal = [];
      querySnapshot.docs.forEach((element) {
        retVal.add(VisitUserModel.fromFirestore(element));
      });
      return retVal;
    });
  }

  Future<void> saveUser(SaveUserModel model) async {
    await firestore
        .collection("users")
        .doc(userID.value)
        .collection('savedUser')
        .doc(model.uid)
        .set({
      "uid": model.uid,
      "name": model.name,
      "desc": model.desc,
      "imgUrl": model.imgUrl,
    });
  }

  Stream<List<SaveUserModel>> savedUserStream() {
    return firestore
        .collection('users')
        .doc(userID.value)
        .collection('savedUser')
        .orderBy('name', descending: false)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<SaveUserModel> retVal = [];
      querySnapshot.docs.forEach((element) {
        retVal.add(SaveUserModel.fromFirestore(element));
      });
      return retVal;
    });
  }

  Future<void> deleteVisitUser(String uid) async {
    await firestore
        .collection("users")
        .doc(userID.value)
        .collection('savedUser')
        .doc(uid)
        .delete();
  }

  //! Social Media Links

  Stream<List<VisitUserSocialModel>> visitUserSocialStream(String uid) {
    return firestore
        .collection('users')
        .doc(uid)
        .collection('socialMedia')
        .orderBy('pos', descending: false)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<VisitUserSocialModel> retVal = [];
      querySnapshot.docs.forEach((element) {
        retVal.add(VisitUserSocialModel.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }
}
