import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerss/pages/homepage.dart';

Future<void> signIn(String email, String password, BuildContext context) async {
  FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: email, password: password)
      .then((signedInUser) {
    print(signedInUser.uid);
    createNewUser(email, password, context);
  }).catchError((e) {
    if (e.toString().contains("ERROR_EMAIL_ALREADY_IN_USE")) {
      print('ERROR EMAIL ALREADY EXIST');
    } else {
      print(e.toString());
    }
    print(e);
  });
}

Future<void> createNewUser(email, password, context) async {
  Firestore.instance.collection('/users').document(email);
  DocumentReference ds =
      Firestore.instance.collection('/users').document(email);
  Map<String, dynamic> user = {'email': email, 'password': password};
  ds.setData(user).whenComplete(() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Homepage()));
    print('user created');
  });
}

Future<void> logIn(String email, String password, BuildContext context) async {
  FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: password)
      .then((FirebaseUser user) {
    Firestore.instance
        .collection('/users')
        .document(email)
        .get()
        .then((DocumentSnapshot ds) {
      if (ds.data == null) {
        Firestore.instance
            .collection('/teacher')
            .document(email)
            .get()
            .then((DocumentSnapshot teacherDate) {})
            .catchError((e) {
          print(e);
        });
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Homepage()));
      }
    }).catchError((e) {
      //closeProgressDialog(context);
      if (e.toString().contains("ERROR_USER_NOT_FOUND")) {
        print('User Not Found');
      } else if (e.toString().contains("ERROR_WRONG_PASSWORD")) {
        print('The password is invalid');
      } else if (e.toString().contains("ERROR_INVALID_EMAIL")) {
        print('The email address is badly formatted');
      } else if (e.toString().contains("ERROR_NETWORK_REQUEST_FAILED")) {
        print('Network error');
      } else {
        print(e);
      }
    });
  });
}