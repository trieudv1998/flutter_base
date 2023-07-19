import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class CommentModel {
  int? id;
  int? postId;
  String? name;
  String? email;
  String? body;

  CommentModel({
    this.id,
    this.postId,
    this.name,
    this.email,
    this.body,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => _$CommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);
}
