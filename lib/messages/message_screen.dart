import 'package:chatsandbox/constants.dart';
import 'package:chatsandbox/models/Chat.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class MessagesScreen extends StatelessWidget {
  Chat chat;

  MessagesScreen({required this.chat});
  @override
  Widget build(BuildContext context) {
    print(chat);
    return Scaffold(
      // appBar: buildAppBar(),
      body: Body(chat: chat),
    );
  }

  // AppBar buildAppBar() {
  //   return AppBar(
  //     automaticallyImplyLeading: false,
  //     title: Row(
  //       children: [
  //         BackButton(),
  //         CircleAvatar(
  //           backgroundImage: AssetImage("assets/images/user_2.png"),
  //         ),
  //         SizedBox(width: kDefaultPadding * 0.75),
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               "Kristin Watson",
  //               style: TextStyle(fontSize: 16),
  //             ),
  //             Text(
  //               "Active 3m ago",
  //               style: TextStyle(fontSize: 12),
  //             )
  //           ],
  //         )
  //       ],
  //     ),
  //     actions: [
  //       IconButton(
  //         icon: Icon(Icons.local_phone),
  //         onPressed: () {},
  //       ),
  //       IconButton(
  //         icon: Icon(Icons.videocam),
  //         onPressed: () {},
  //       ),
  //       SizedBox(width: kDefaultPadding / 2),
  //     ],
  //   );
  // }
}
