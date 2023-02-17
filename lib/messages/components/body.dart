import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatsandbox/models/Chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../AppState/appState.dart';
import '../../constants.dart';
import '../../models/ChatMessage.dart';
import 'chat_input_field.dart';
import 'message.dart';

class Body extends StatelessWidget {
  Chat chat;
  Body({
    required this.chat,
  });
  final CollectionReference chatsRef =
      FirebaseFirestore.instance.collection("chatMessage");

  @override
  Widget build(BuildContext context) {
    var appState = context.read<AppState>();

    return Consumer<AppState>(
      builder: (context, value, child) {
        if (value.chatId == '0') {
          return Container(
            child: Center(
              child: Text('Welcome ' +
                  value.name +
                  ' to internals. Stay updated with your team.'),
            ),
          );
        } else {
          final CollectionReference chatsRef = FirebaseFirestore.instance
              .collection("chatMessage")
              .doc()
              .collection(value.chatId);
          // final CollectionReference chatMessages =
          //     FirebaseFirestore.instance.collection("chatMessage");
          print(chat.name.toString());
          return Column(
            children: [
              buildAppBar(),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: FutureBuilder<QuerySnapshot>(
                    future: chatsRef.get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Something went wrong!');
                      }
                      if (snapshot.hasData) {
                        QuerySnapshot querySnapshot = snapshot.data!;
                        List<QueryDocumentSnapshot> documents =
                            querySnapshot.docs;
                        List<ChatMessage> chats = documents
                            .map(
                              (e) => ChatMessage(
                                  chatId: e["chatId"],
                                  text: e["text"],
                                  messageType: e['messageType'],
                                  messageStatus: e['messageStatus'],
                                  isSender: e['isSender']),
                            )
                            .toList();
                        return buildChats(chats);
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),

                  // ListView.builder(
                  //   itemCount: ChatMessages.length,
                  //   itemBuilder: (context, index) =>
                  //       Message(message: ChatMessages[index]),
                  // ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: FutureBuilder<QuerySnapshot>(
                    future: chatsRef.get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Something went wrong!');
                      }
                      if (snapshot.hasData) {
                        QuerySnapshot querySnapshot = snapshot.data!;
                        List<QueryDocumentSnapshot> documents =
                            querySnapshot.docs;
                        List<ChatMessage> msgs = documents
                            .map(
                              (e) => ChatMessage(
                                  chatId: e["chatId"],
                                  text: e["text"],
                                  messageType: e['messageType'],
                                  messageStatus: e['messageStatus'],
                                  isSender: e['isSender']),
                            )
                            .toList();
                        print(msgs.toString());
                        return buildChats(msgs);
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),

                  // ListView.builder(
                  //   itemCount: ChatMessages.length,
                  //   itemBuilder: (context, index) =>
                  //       Message(message: ChatMessages[index]),
                  // ),
                ),
              ),
              const ChatInputField(),
            ],
          );
        }
      },
    );
  }

  Widget buildChats(chats) {
    print('chat to string ... ' + chat.toString());
    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) => Message(message: chats[index]),
    );
  }

  AppBar buildAppBar() {
    // Chat chat;
    print(chat.id);
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          // BackButton(),
          CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(chat.imageUrl),
          ),
          SizedBox(width: kDefaultPadding * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                chat.name,
                style: TextStyle(fontSize: 16),
              ),
              Text(
                chat.time,
                style: TextStyle(fontSize: 12),
              )
            ],
          )
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.local_phone),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.videocam),
          onPressed: () {},
        ),
        SizedBox(width: kDefaultPadding / 2),
      ],
    );
  }
}
