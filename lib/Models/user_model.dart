import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? name;
  String? email;
  String? description;
  String? dynamicLink;
  String? imageUrl;
  bool? direct;
  bool? tag;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.description,
    this.dynamicLink,
    this.imageUrl,
    this.direct,
    this.tag,
  });

  UserModel.fromFirestore(DocumentSnapshot doc) {
    id = doc['id'];
    name = doc['name'];
    email = doc['email'];
    description = doc['description'];
    dynamicLink = doc['dynamicLink'];
    imageUrl = doc['imageUrl'];
    direct = doc['direct'];
    tag = doc['tag'];
  }
}
