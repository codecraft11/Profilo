import 'package:cloud_firestore/cloud_firestore.dart';

class VisitUserModel {
  String? id;
  String? name;
  String? email;
  String? description;
  String? dynamicLink;
  String? imageUrl;
  bool? direct;
  bool? tag;

  VisitUserModel({
    this.id,
    this.name,
    this.email,
    this.description,
    this.dynamicLink,
    this.imageUrl,
    this.direct,
    this.tag,
  });

  VisitUserModel.fromFirestore(DocumentSnapshot doc) {
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

class VisitUserSocialModel {
  String? linkName;
  String? link;
  int? pos;

  VisitUserSocialModel({
    this.linkName,
    this.link,
    this.pos,
  });

  VisitUserSocialModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    linkName = doc.get('linkName');
    link = doc.get('link');
    pos = doc.get('pos');
  }
}
