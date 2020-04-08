import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String userId,fullName, designation, email, password;
  bool isAdmin;
  DateTime dateOfCreation;

  User(this.userId,this.fullName, this.designation, this.email, this.password, this.isAdmin,
      this.dateOfCreation);

  void updateFirebase(Firestore firestore) async {
    return await firestore.collection('users').document(this.userId).setData({
      "dateOfCreation": this.dateOfCreation,
      "designation": this.designation,
      "email": this.email,
      "fullName":
      this.fullName,
      "isAdmin": this.isAdmin,
      "password":
      this.password,
    });
  }
}
