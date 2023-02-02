// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'articles.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Articles _$ArticlesFromJson(Map<String, dynamic> json) => Articles(
      id: json['id'] as int?,
      rating: json['rating'] as int?,
      author_id: json['author_id'] as int?,
      title: json['title'] as String?,
      topic_id: json['topic_id'] as int?,
      existing_solution_text: json['existing_solution_text'] as String?,
      existing_solution_image: json['existing_solution_image'] as String?,
      existing_solution_video: json['existing_solution_video'] as String?,
      proposed_solution_text: json['proposed_solution_text'] as String?,
      proposed_solution_image: json['proposed_solution_image'] as String?,
      proposed_solution_video: json['proposed_solution_video'] as String?,
      positive_effect: json['positive_effect'] as String?,
      author: json['author'] == null
          ? null
          : Author.fromJson(json['author'] as Map<String, dynamic>),
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => Comments.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ArticlesToJson(Articles instance) => <String, dynamic>{
      'id': instance.id,
      'author_id': instance.author_id,
      'title': instance.title,
      'topic_id': instance.topic_id,
      'rating': instance.rating,
      'existing_solution_text': instance.existing_solution_text,
      'existing_solution_image': instance.existing_solution_image,
      'existing_solution_video': instance.existing_solution_video,
      'proposed_solution_text': instance.proposed_solution_text,
      'proposed_solution_image': instance.proposed_solution_image,
      'proposed_solution_video': instance.proposed_solution_video,
      'positive_effect': instance.positive_effect,
      'comments': instance.comments,
      'author': instance.author,
    };

Author _$AuthorFromJson(Map<String, dynamic> json) => Author(
      id: json['id'] as int?,
      full_name: json['full_name'] as String?,
      phone: json['phone'] as String?,
      topic_id: json['topic_id'] as int?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
      'id': instance.id,
      'full_name': instance.full_name,
      'phone': instance.phone,
      'topic_id': instance.topic_id,
      'email': instance.email,
    };

Comments _$CommentsFromJson(Map<String, dynamic> json) => Comments(
      id: json['id'] as int?,
      text: json['text'] as String?,
      user_id: json['user_id'] as int?,
      datetime: json['datetime'] == null
          ? null
          : DateTime.parse(json['datetime'] as String),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      full_name: json['full_name'] as String?,
      you: json['you'] as int?,
    );

Map<String, dynamic> _$CommentsToJson(Comments instance) => <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'user_id': instance.user_id,
      'datetime': instance.datetime?.toIso8601String(),
      'user': instance.user,
      'full_name': instance.full_name,
      'you': instance.you,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int?,
      full_name: json['full_name'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'full_name': instance.full_name,
    };
