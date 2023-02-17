import 'package:chatsandbox/showUsers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'models/UserModel.dart';

class UpdateUser extends StatelessWidget {
  final User user;
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerTime = TextEditingController();
  final TextEditingController controllerImageUrl = TextEditingController();

  final FocusNode focusNode = FocusNode();

  UpdateUser({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    controllerName.text = user.name;
    controllerEmail.text = user.email;
    controllerTime.text = user.time;
    controllerImageUrl.text = user.imageUrl;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update User"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            getMyField(
                focusNode: focusNode,
                hintText: 'Name',
                textInputType: TextInputType.text,
                controller: controllerName),
            getMyField(
                hintText: 'Email',
                textInputType: TextInputType.text,
                controller: controllerEmail),
            getMyField(
                hintText: 'Time',
                textInputType: TextInputType.text,
                controller: controllerTime),
            getMyField(
                hintText: 'ImageURL',
                textInputType: TextInputType.text,
                controller: controllerImageUrl),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    User updateUser = User(
                        id: user.id,
                        uid: user.uid,
                        name: controllerName.text,
                        email: controllerEmail.text,
                        imageUrl: controllerImageUrl.text,
                        time: controllerTime.text);
                    final usersRef =
                        FirebaseFirestore.instance.collection('users');
                    usersRef
                        .doc(updateUser.uid)
                        .update(updateUser.toJson())
                        .whenComplete(() => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ShowUser())));
                  },
                  child: const Text("Update"),
                ),
                ElevatedButton(
                  onPressed: () {
                    controllerName.text = '';
                    controllerEmail.text = '';
                    controllerImageUrl.text = '';
                    controllerTime.text = '';
                    focusNode.requestFocus();
                  },
                  child: const Text("Reset"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  getMyField(
      {required String hintText,
      TextInputType textInputType = TextInputType.name,
      required TextEditingController controller,
      FocusNode? focusNode}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        keyboardType: textInputType,
        decoration: InputDecoration(
          hintText: "Enter $hintText",
          labelText: hintText,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
        ),
      ),
    );
  }
}
