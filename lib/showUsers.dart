import 'package:chatsandbox/updateUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'models/UserModel.dart';

class ShowUser extends StatefulWidget {
  const ShowUser({super.key});

  @override
  State<ShowUser> createState() => _ShowUserState();
}

class _ShowUserState extends State<ShowUser> {
  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: FutureBuilder<QuerySnapshot>(
              future: usersRef.get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong!');
                }
                if (snapshot.hasData) {
                  QuerySnapshot querySnapshot = snapshot.data!;
                  List<QueryDocumentSnapshot> documents = querySnapshot.docs;
                  List<User> users = documents
                      .map((e) => User(
                            id: e["id"],
                            uid: e['uid'],
                            name: e['name'],
                            email: e['email'],
                            imageUrl: e['imageUrl'],
                            time: e['time'],
                          ))
                      .toList();
                  return buildUsers(users);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildUsers(users) => ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) => Card(
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: ListTile(
                  title: Text(users[index].name),
                  leading: CircleAvatar(
                    child: Text(users[index].id),
                  ),
                  subtitle: Text(
                    users[index].email,
                    style: TextStyle(color: Colors.white.withOpacity(.65)),
                  ),
                  trailing: SizedBox(
                    width: 60,
                    child: Row(
                      children: [
                        InkWell(
                            child: Icon(
                              Icons.edit,
                              color: Colors.lightBlue.withOpacity(0.75),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        UpdateUser(user: users[index]),
                                  ));
                            }),
                        InkWell(
                          child: Icon(
                            Icons.delete,
                            color: Colors.red.withOpacity(0.75),
                          ),
                          onTap: () {
                            usersRef.doc(users[index].uid).delete();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ShowUser()));
                          },
                        ),
                      ],
                    ),
                  )),
            ),
          ));
}
