import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../AppState/appState.dart';
import '../../models/ChatMessage.dart';
import '../../models/TextMsg.dart';

class ChatInputField extends StatefulWidget {
  const ChatInputField({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  @override
  Widget build(BuildContext context) {
    var appState = context.read<AppState>();
    TextEditingController textController = TextEditingController();
    final CollectionReference chatMessageRef =
        FirebaseFirestore.instance.collection("chatMessage");
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 32,
            color: const Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            const Icon(Icons.mic, color: kPrimaryColor),
            const SizedBox(width: kDefaultPadding),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding * 0.75,
                ),
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.sentiment_satisfied_alt_outlined,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(0.64),
                    ),
                    const SizedBox(width: kDefaultPadding / 4),
                    Expanded(
                      child: TextField(
                        controller: textController,
                        textInputAction: TextInputAction.go,
                        onSubmitted: (value) {
                          // appState.addMessage(ChatMessage chatMessage);
                          Textmsg texts = Textmsg(
                            text: value,
                          );
                          addTxt(texts, context);
                          print(value);
                          textController.clear();
                        },
                        decoration: const InputDecoration(
                          hintText: "Type message",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.attach_file,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(0.64),
                    ),
                    const SizedBox(width: kDefaultPadding / 4),
                    Icon(
                      Icons.camera_alt_outlined,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(0.64),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  addTxt(Textmsg texts, BuildContext context) {
    final docTxt =
        FirebaseFirestore.instance.collection("chatMessage/1-2/texts/").doc();
    texts.id = docTxt.id;
    // print(texts.id);
    final data = texts.toJson();

    //create document and write data to firebase

    docTxt.set(data);
  }
}
