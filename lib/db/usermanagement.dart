import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<void> setUserByMobile(String name, String phone, String email, String sex) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser!.uid;

  FirebaseFirestore.instance.collection("/users").doc(uid).collection("/personalInfo").doc("info").set({
    "name" : name, "phone": phone, "email": email, "sex": sex
  });
}

Future<void> setUserByEmail(String name, String email) async{
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser!.uid;

  FirebaseFirestore.instance.collection("/users").doc(uid).collection("/personalInfo").doc("info").set({
    "email": email, "name": name
  });
}