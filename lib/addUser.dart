import 'package:chatsandbox/showUsers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'models/UserModel.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final controllerID = TextEditingController();
  final controllerName = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerImageUrl = TextEditingController();
  final controllerTime = TextEditingController();
  // final controllerIsActive = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add User"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          getMyField(
              focusNode: focusNode,
              hintText: 'ID',
              textInputType: TextInputType.number,
              controller: controllerID),
          getMyField(
              hintText: 'Name',
              textInputType: TextInputType.text,
              controller: controllerName),
          getMyField(
              hintText: 'Email',
              textInputType: TextInputType.text,
              controller: controllerEmail),
          getMyField(
              hintText: 'Image Url',
              textInputType: TextInputType.text,
              controller: controllerImageUrl),
          getMyField(
              hintText: 'Time',
              textInputType: TextInputType.text,
              controller: controllerTime),
          // getMyField(
          //     hintText: 'User is Active?',
          //     textInputType: TextInputType.text,
          //     controller: controllerIsActive),
          const SizedBox(
            height: 32,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  User user = User(
                    id: controllerID.text,
                    name: controllerName.text,
                    email: controllerEmail.text,
                    imageUrl: controllerImageUrl.text,
                    time: controllerTime.text,
                  );
                  createUser(user, context);
                },
                child: const Text("Add"),
              ),
              ElevatedButton(
                onPressed: () {
                  controllerID.text = '';
                  controllerName.text = '';
                  controllerEmail.text = '';
                  controllerImageUrl.text = '';
                  controllerTime.text = '';
                  focusNode.requestFocus();
                },
                child: const Text("Reset"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) => const ShowUser()),
                  );
                },
                child: const Text("Show Users"),
              ),
            ],
          )
        ],
      ),
    );
  }

  //To create users in firebase database
  void createUser(User user, BuildContext context) {
    final docUser = FirebaseFirestore.instance.collection("users").doc();
    user.uid = docUser.id;
    final data = user.toJson();

    //create document and write data to firebase

    docUser.set(data).whenComplete(() => Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const ShowUser())));
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
