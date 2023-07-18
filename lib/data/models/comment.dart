import 'package:flutter_base/domain/entities/comment.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class CommentModel extends CommentEntity {
  const CommentModel({
    int? id,
    int? postId,
    String? name,
    String? email,
    String? body,
  }) : super(id: id, postId: postId, name: name, email: email, body: body);

  factory CommentModel.fromJson(Map<String, dynamic> json) => _$CommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);
}
