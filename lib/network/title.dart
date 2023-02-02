import 'dart:convert';

class Topics {
  String? title;
  int? id;

  Topics({this.title, this.id});
  factory Topics.fromJson(dynamic json) => Topics(
        id: json["id"] as int,
        title: json["title"] as String,
      );
}
