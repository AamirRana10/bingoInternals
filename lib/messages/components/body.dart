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
    // List myList = [];

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
          appState.getMessages(value.chatId);
          // final CollectionReference chatsRef =
          //     FirebaseFirestore.instance.collection("chatMessage");

          // final querySnapshot = FirebaseFirestore.instance
          //     .collection('chatMessage')
          //     .limit(10)
          //     .where('chatId', isEqualTo: value.chatId)
          //     .get();

          // querySnapshot.then((value) {
          // myList = value.docs.toList();
          // print('yehi hai -> ' + myList.toString());

          // for (var doc in value.docs) {
          // Getting data directly
          // String name = doc.get('text');
          // print(doc.get('messageStatus'));

          // Getting data from map
          // Map<String, dynamic> data = doc.data();
          // int age = data['age'];
          // }
          // });

          // final CollectionReference chatMessages =
          //     FirebaseFirestore.instance.collection("chatMessage");

          return Column(
            children: [
              buildAppBar(),
              // Expanded(
              //   child: Padding(
              //     padding:
              //         const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              //     child: FutureBuilder<QuerySnapshot>(
              //       future: chatMessages.get(),
              //       builder: (context, snapshot) {
              //         if (snapshot.hasError) {
              //           return const Text('Something went wrong!');
              //         }
              //         if (snapshot.hasData) {
              //           QuerySnapshot querySnapshot = snapshot.data!;
              //           List<QueryDocumentSnapshot> documents =
              //               querySnapshot.docs;
              //           List<ChatMessage> chatmsg = documents
              //               .map(
              //                 (e) => ChatMessage(
              //                     chatId: e["chatId"],
              //                     text: e["text"],
              //                     messageType: e['messageType'],
              //                     messageStatus: e['messageStatus'],
              //                     isSender: e['isSender']),
              //               )
              //               .toList();
              //           return buildChats(chatmsg);
              //         } else {
              //           return const Center(child: CircularProgressIndicator());
              //         }
              //       },
              //     ),
              //   ),
              // ),

              ListView.builder(
                shrinkWrap: true,
                itemCount: appState.chatData.length,
                itemBuilder: (context, index) {
                  if (appState.chatData.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    var chats = appState.chatData;
                    return ListTile(
                      title: Text(chats.toString()),
                    );
                  }
                },
              ),

              // Expanded(
              //   child: Padding(
              //     padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              //     child: ListView.builder(
              //       shrinkWrap: true,
              //       itemCount: appState.chatData.length,
              //       itemBuilder: (context, index) {
              //         return Text(appState.chatData.length.toString());
              //       },
              //     ),
              //
              //     // FutureBuilder(
              //     //   future: appState.chatData,
              //     //   builder: (context, snapshot) {
              //     //     if (snapshot.hasError) {
              //     //       print('mysnapshot has no data and here it is ... ' +
              //     //           snapshot.error.toString());
              //     //       return const Text('Something went wrong!');
              //     //     }
              //     //     if (snapshot.hasData) {
              //     //       print('mysnapshot has data and here it is ... ' +
              //     //           snapshot.data.toString());
              //     //       QuerySnapshot querySnapshot = snapshot.data!;
              //     //       List<QueryDocumentSnapshot> documents =
              //     //           querySnapshot.docs;
              //     //       List<ChatMessage> msgs = documents
              //     //           .map(
              //     //             (e) => ChatMessage(
              //     //                 id: e["id"],
              //     //                 chatId: e["chatId"],
              //     //                 text: e["text"],
              //     //                 messageType: e['messageType'],
              //     //                 messageStatus: e['messageStatus'],
              //     //                 isSender: e['isSender']),
              //     //           )
              //     //           .toList();
              //     //       print(msgs.toString());
              //     //       return Text(snapshot.data.toString());
              //     //       // return buildChats(msgs);
              //     //     } else {
              //     //       return const Center(child: CircularProgressIndicator());
              //     //     }
              //     //   },
              //     // ),
              //   ),
              // ),
              const ChatInputField(),
            ],
          );
        }
      },
    );
  }

  // Widget buildChats(chats) {
  //   // print('chat to string ... ' + chat.name);
  //   return ListView.builder(
  //     itemCount: chats.length,
  //     itemBuilder: (context, index) => Message(message: chats[index]),
  //   );
  // }
  // Widget buildChats(msgs) {
  //   // print('chat to string ... ' + chat.name);
  //   return ListView.builder(
  //     itemCount: msgs.length,
  //     itemBuilder: (context, index) => Message(message: msgs[index]),
  //   );
  // }

  // Widget buildChats(msgs) {
  //   print('chat to string ... ' + msgs.toString());
  //   return ListView.builder(
  //     itemCount: 5,
  //     itemBuilder: (context, index) => Text(chat.name),
  //   );
  // }

  AppBar buildAppBar() {
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
