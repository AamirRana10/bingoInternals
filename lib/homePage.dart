import 'package:chatsandbox/showUsers.dart';
import 'package:flutter/material.dart';

import 'addUser.dart';
import 'chats/chats_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.amber,
              ),
              child: Text(
                'Chat Sand Box',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Users'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ShowUser()));
              },
            ),
            ListTile(
              title: const Text('Add User'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AddUser()));
              },
            ),
            ListTile(
              title: const Text('chats'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChatsScreen()));
              },
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("Chat Sand Box"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
