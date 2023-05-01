import 'package:cloud_firestore/cloud_firestore.dart';

class SaveUserModel {
  String? uid;
  String? name;
  String? desc;
  String? imgUrl;

  SaveUserModel({this.uid, this.name, this.desc, this.imgUrl});

  SaveUserModel.fromFirestore(DocumentSnapshot docs) {
    uid = docs.get('uid');
    name = docs.get('name');
    desc = docs.get('desc');
    imgUrl = docs.get('imgUrl');
  }
}
