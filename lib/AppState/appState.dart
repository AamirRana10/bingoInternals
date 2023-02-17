import 'package:chatsandbox/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/ChatMessage.dart';

class AppState with ChangeNotifier {
  // AppState();

  bool isLoggedIn = false;

  Future<User?> checkAuth() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      await user;
      if (user == null) {
        print('User is currently signed out!');
        isLoggedIn = false;
      } else {
        print('User is signed in!');
        isLoggedIn = true;
        getUserDetails();
      }
    });
    // if (prefs.getBool('isLoggedIn') == true) {
    //   isLoggedIn = true;
    // } else {
    //   isLoggedIn = false;
    // }
    notifyListeners();
  }

  var uid = "";
  var name = "";
  var email = "";
  var photoUrl = "";

  var chatId = '0';

  Future<void> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final user = await FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Name, email address, and profile photo URL
      name = user.displayName.toString();
      email = user.email.toString();
      photoUrl = user.photoURL.toString();

      // Check if user's email is verified
      // final emailVerified = user.emailVerified;

      // The user's ID, unique to the Firebase project. Do NOT use this value to
      // authenticate with your backend server, if you have one. Use
      // User.getIdToken() instead.
      uid = user.uid.toString();
      prefs.setString('name', name);
      prefs.setString('uid', uid);
      prefs.setString('photoUrl', photoUrl);
      notifyListeners();
    }
  }

  Future<User?> login(ctx, emailAddress, password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      final User user = credential.user!;
      addActiveUser;
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showsnackbar(ctx, 'No user found for that email.');
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showsnackbar(ctx, 'Wrong password provided for that user.');
        print('Wrong password provided for that user.');
      }
    }
    notifyListeners();
  }

  Future<void> addActiveUser() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    // Call the user's CollectionReference to add a new user
    return users
        .add({
          'email': email,
          'uid': uid,
          'photoUrl': photoUrl,
          'date': DateTime.now()
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> logOutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await FirebaseAuth.instance.signOut();
    prefs.clear();
    notifyListeners();
  }

  void showsnackbar(ctx, message) {
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        content: Text(message
            .toString()), // Change to something to show a meaningful error message
        backgroundColor: kErrorColor,
      ),
    );
  }

  Future<void> getAllUsers() async {
    final CollectionReference ref =
        FirebaseFirestore.instance.collection("users");
  }

  void addMessage(ChatMessage chatMessage, BuildContext context) {
    final chatMessages =
        FirebaseFirestore.instance.collection("chatMessages").doc();
    print(chatMessage.chatId);
    chatMessage.chatId = chatMessages.id;
    final data = chatMessage.toJson();

    //create document and write data to firebase

    chatMessages.set(data).whenComplete(() => print('cool'));
  }

  Future<void> setChatId(id) async {
    if (chatId == '0') {
      chatId = id;
    }
    notifyListeners();
  }

  // Future<void> addMessage(value) async {
  //   print(value);
  //   final CollectionReference ref =
  //       FirebaseFirestore.instance.collection("chatMessages");
  //
  //   ref.add(value);
  // }
}
