import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String userId, fullName, designation, email, password, department;
  bool isAdmin;
  DateTime dateOfCreation;

  User(this.userId, this.fullName, this.designation, this.email, this.password,
      this.department, this.isAdmin, this.dateOfCreation);

  void updateFirebase(Firestore firestore) async {
    return await firestore.collection('users').document(this.userId).setData({
      "dateOfCreation": this.dateOfCreation,
      "designation": this.designation,
      "department": this.department,
      "email": this.email,
      "fullName": this.fullName,
      "isAdmin": this.isAdmin,
      "password": this.password,
    });
  }

  User.fromFirebaseDocument(DocumentSnapshot firebaseDocument) {
    this.userId = firebaseDocument.documentID;
    this.fullName = firebaseDocument.data["fullName"];
    this.designation = firebaseDocument.data["designation"];
    this.email = firebaseDocument.data["email"];
    this.password = firebaseDocument.data["password"];
    this.department = firebaseDocument.data["department"];
    this.isAdmin = firebaseDocument.data["isAdmin"];
    this.dateOfCreation = firebaseDocument.data["dateOfCreation"].toDate();
  }
}
