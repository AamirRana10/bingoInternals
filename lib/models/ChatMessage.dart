import 'dart:convert';

enum ChatMessageType { text, audio, image, video }

enum MessageStatus { not_sent, not_view, viewed }

ChatMessage chatMessageFromJson(String str) =>
    ChatMessage.fromJson(json.decode(str));

String chatMessageToJson(ChatMessage data) => json.encode(data.toJson());

class ChatMessage {
  String? id;
  String? chatId;
  final String text;
  final ChatMessageType messageType;
  final MessageStatus messageStatus;
  final bool isSender;

  ChatMessage({
    this.id,
    required this.chatId,
    required this.text,
    required this.messageType,
    required this.messageStatus,
    required this.isSender,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'chatId': chatId,
        'text': text,
        'messageType': messageType,
        'messageStatus': messageStatus,
        'isSender': isSender
      };
  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        id: json["id"],
        chatId: json["chatId"],
        text: json["text"],
        messageType: json["messageType"],
        messageStatus: json["messageStatus"],
        isSender: json["isSender"],
      );
}

// class ChatMessage {

// }

// List demeChatMessages = [
//   ChatMessage(
//     text: "Hi Sajol,",
//     messageType: ChatMessageType.text,
//     messageStatus: MessageStatus.viewed,
//     isSender: false,
//   ),
//   ChatMessage(
//     text: "Hello, How are you?",
//     messageType: ChatMessageType.text,
//     messageStatus: MessageStatus.viewed,
//     isSender: true,
//   ),
//   ChatMessage(
//     text: "",
//     messageType: ChatMessageType.audio,
//     messageStatus: MessageStatus.viewed,
//     isSender: false,
//   ),
//   ChatMessage(
//     text: "",
//     messageType: ChatMessageType.video,
//     messageStatus: MessageStatus.viewed,
//     isSender: true,
//   ),
//   ChatMessage(
//     text: "Error happend",
//     messageType: ChatMessageType.text,
//     messageStatus: MessageStatus.not_sent,
//     isSender: true,
//   ),
//   ChatMessage(
//     text: "This looks great man!!",
//     messageType: ChatMessageType.text,
//     messageStatus: MessageStatus.viewed,
//     isSender: false,
//   ),
//   ChatMessage(
//     text: "Glad you like it",
//     messageType: ChatMessageType.text,
//     messageStatus: MessageStatus.not_view,
//     isSender: true,
//   ),
// ];
