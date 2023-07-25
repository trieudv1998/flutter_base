import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
  CommentEntity({
    this.id,
    this.postId,
    this.name,
    this.emailUser,
    this.body,
  });

  String? id;
  int? postId;
  String? name;
  String? emailUser;
  String? body;

  @override
  List<Object?> get props => [
        id,
        postId,
        name,
        emailUser,
        body,
      ];
}
