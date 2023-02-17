import 'dart:convert';

Chat chatFromJson(String str) => Chat.fromJson(json.decode(str));

String chatToJson(Chat data) => json.encode(data.toJson());

class Chat {
  final String id, chatId, name, lastMessage, imageUrl, time;
  final bool isActive;

  Chat({
    required this.id,
    required this.chatId,
    required this.name,
    required this.lastMessage,
    required this.imageUrl,
    required this.time,
    required this.isActive,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'chatId': chatId,
        'name': name,
        'lastMessage': lastMessage,
        'imageUrl': imageUrl,
        'time': time,
        'isActive': isActive,
      };
  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        id: json["id"],
        chatId: json["chatId"],
        name: json["name"],
        lastMessage: json["lastMessage"],
        imageUrl: json["imageUrl"],
        time: json["time"],
        isActive: json["isActive"],
      );
}


// class Chat {
//   final String name, lastMessage, image, time;
//   final bool isActive;

//   Chat({
//     this.name = '',
//     this.lastMessage = '',
//     this.image = '',
//     this.time = '',
//     this.isActive = false,
//   });
// }

// List chatsData = [
//   Chat(
//     name: "Jenny Wilson",
//     lastMessage: "Hope you are doing well...",
//     image: "assets/images/user.png",
//     time: "3m ago",
//     isActive: false,
//   ),
//   Chat(
//     name: "Esther Howard",
//     lastMessage: "Hello Abdullah! I am...",
//     image: "assets/images/user_2.png",
//     time: "8m ago",
//     isActive: true,
//   ),
//   Chat(
//     name: "Ralph Edwards",
//     lastMessage: "Do you have update...",
//     image: "assets/images/user_3.png",
//     time: "5d ago",
//     isActive: false,
//   ),
//   Chat(
//     name: "Jacob Jones",
//     lastMessage: "You’re welcome :)",
//     image: "assets/images/user_4.png",
//     time: "5d ago",
//     isActive: true,
//   ),
//   Chat(
//     name: "Albert Flores",
//     lastMessage: "Thanks",
//     image: "assets/images/user_5.png",
//     time: "6d ago",
//     isActive: false,
//   ),
//   Chat(
//     name: "Jenny Wilson",
//     lastMessage: "Hope you are doing well...",
//     image: "assets/images/user.png",
//     time: "3m ago",
//     isActive: false,
//   ),
//   Chat(
//     name: "Esther Howard",
//     lastMessage: "Hello Abdullah! I am...",
//     image: "assets/images/user_2.png",
//     time: "8m ago",
//     isActive: true,
//   ),
//   Chat(
//     name: "Ralph Edwards",
//     lastMessage: "Do you have update...",
//     image: "assets/images/user_3.png",
//     time: "5d ago",
//     isActive: false,
//   ),
// ];
