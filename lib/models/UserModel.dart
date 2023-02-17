import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.uid,
    this.id,
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.time,
    // required this.isActive,
  });

  String? uid;
  String? id;
  String name;
  String email;
  String imageUrl;
  String time;
  // bool isActive;

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'id': id,
        'name': name,
        'email': email,
        'imageUrl': imageUrl,
        'time': time,
        // 'isActive': isActive,
      };
  factory User.fromJson(Map<String, dynamic> json) => User(
        uid: json["uid"],
        id: json["id"],
        name: json["name"],
        email: json["email"],
        imageUrl: json["imageUrl"],
        time: json["time"],
        // isActive: json["isActive"]
      );
}
