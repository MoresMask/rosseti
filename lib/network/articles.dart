import 'package:json_annotation/json_annotation.dart';
part 'articles.g.dart';

@JsonSerializable()
class Articles {
  int? id;
  int? author_id;
  String? title;
  int? topic_id;
  int? rating;
  String? existing_solution_text;
  String? existing_solution_image;
  String? existing_solution_video;
  String? proposed_solution_text;
  String? proposed_solution_image;
  String? proposed_solution_video;
  String? positive_effect;
  List<Comments>? comments;
  Author? author;
  Articles(
      {this.id,
      this.rating,
      this.author_id,
      this.title,
      this.topic_id,
      this.existing_solution_text,
      this.existing_solution_image,
      this.existing_solution_video,
      this.proposed_solution_text,
      this.proposed_solution_image,
      this.proposed_solution_video,
      this.positive_effect,
      this.author,
      this.comments});
  factory Articles.fromJson(Map<String, dynamic> json) =>
      _$ArticlesFromJson(json);

  Map<String, dynamic> toJson() => _$ArticlesToJson(this);
}

@JsonSerializable()
class Author {
  int? id;
  String? full_name;
  String? phone;
  int? topic_id;
  String? email;
  Author({
    this.id,
    this.full_name,
    this.phone,
    this.topic_id,
    this.email,
  });

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorToJson(this);
}

@JsonSerializable()
class Comments {
  int? id;
  String? text;
  int? user_id;
  DateTime? datetime;
  User? user;
  String? full_name;
  int? you;

  Comments(
      {this.id,
      this.text,
      this.user_id,
      this.datetime,
      this.user,
      this.full_name,
      this.you});
  factory Comments.fromJson(Map<String, dynamic> json) =>
      _$CommentsFromJson(json);

  Map<String, dynamic> toJson() => _$CommentsToJson(this);
}

@JsonSerializable()
class User {
  int? id;
  String? full_name;
  User({this.id, this.full_name});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
