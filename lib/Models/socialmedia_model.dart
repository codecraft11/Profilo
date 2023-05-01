import 'package:cloud_firestore/cloud_firestore.dart';

class SocialMediaModel {
  String? linkName;
  String? link;
  int? pos;

  SocialMediaModel({
    this.linkName,
    this.link,
    this.pos,
  });

  SocialMediaModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    linkName = doc.get('linkName');
    link = doc.get('link');
    pos = doc.get('pos');
  }
}
