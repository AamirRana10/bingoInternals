import 'package:chatsandbox/components/filled_outline_button.dart';
import 'package:chatsandbox/constants.dart';
import 'package:chatsandbox/models/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/Chat.dart';
import 'chat_card.dart';

class ChatBody extends StatelessWidget {
  const ChatBody({super.key});

  @override
  Widget build(BuildContext context) {
    final CollectionReference chatsRef =
        FirebaseFirestore.instance.collection("chats");
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(kDefaultPadding, kDefaultPadding,
              kDefaultPadding, kDefaultPadding),
          color: kPrimaryColor,
          child: Row(
            children: const [
              Text('This is a beta version 0.1'),
              // FillOutlineButton(press: () {}, text: "Recent Message"),
              // const SizedBox(width: kDefaultPadding),
              // FillOutlineButton(
              //   press: () {},
              //   text: "Active",
              //   isFilled: false,
              // ),
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder<QuerySnapshot>(
            future: chatsRef.get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong!');
              }
              if (snapshot.hasData) {
                QuerySnapshot querySnapshot = snapshot.data!;
                List<QueryDocumentSnapshot> documents = querySnapshot.docs;
                List<Chat> chats = documents
                    .map((e) => Chat(
                        id: e["id"],
                        chatId: e["chatId"],
                        lastMessage: e['lastMessage'],
                        imageUrl: e['imageUrl'],
                        time: e['time'],
                        isActive: e['isActive'],
                        name: e['name']))
                    .toList();
                return buildChats(chats);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ],
    );
  }

  Widget buildChats(chats) => ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) => ChatCard(
          chat: chats[index],
          // press: () {
          //   if (MediaQuery.of(context).size.width > 900) {
          //     print('more than 556');
          //   } else {
          //     Navigator.pop(context);
          //     print('less than 556');
          //   }
          //   print(index);
          //   // getChat(id:index[id]);
          //   // Navigator.push(
          //   //   context,
          //   //   MaterialPageRoute(
          //   //     builder: (context) => MessagesScreen(),
          //   //   ),
          //   // );
          // },
        ),
      );

  // ListView.builder(
  //     itemCount: users.length,
  //     itemBuilder: (context, index) => Card(
  //           child: Padding(
  //             padding: const EdgeInsets.all(1.0),
  //             child: ListTile(
  //                 tileColor: Colors.white38,
  //                 title: Text(users[index].name),
  //                 leading: CircleAvatar(
  //                   child: Text('${users[index].age}'),
  //                 ),
  //                 subtitle: Text('${users[index].id}'),
  //                 trailing: SizedBox(
  //                   width: 60,
  //                   child: Row(
  //                     children: [
  //                       InkWell(
  //                           child: Icon(
  //                             Icons.edit,
  //                             color: Colors.lightBlue.withOpacity(0.75),
  //                           ),
  //                           onTap: () {}),
  //                       InkWell(
  //                         child: Icon(
  //                           Icons.delete,
  //                           color: Colors.red.withOpacity(0.75),
  //                         ),
  //                         onTap: () {},
  //                       ),
  //                     ],
  //                   ),
  //                 )),
  //           ),
  //         ));
}
