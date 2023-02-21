import 'dart:convert';

Textmsg textmsgFromJson(String str) => Textmsg.fromJson(json.decode(str));

String textmsgToJson(Textmsg data) => json.encode(data.toJson());

class Textmsg {
  Textmsg({
    this.id,
    this.sender,
    required this.text,
  });

  String? id;
  String? sender;
  String text;

  factory Textmsg.fromJson(Map<String, dynamic> json) => Textmsg(
        id: json["id"],
        sender: json["sender"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sender": sender,
        "text": text,
      };
}
