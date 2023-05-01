import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Storage {
  FirebaseStorage storage = FirebaseStorage.instance;
  var url = ''.obs;
  Future<String> imageUploadToStorage(File image) async {
    Reference ref = storage
        .ref()
        .child("ProfilePictures/image" + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(image);
    await uploadTask.whenComplete(() async {
      url.value = (await ref.getDownloadURL()).toString();
    }).catchError((onError) {
      debugPrint(onError);
    });
    return url.value;
  }
}
