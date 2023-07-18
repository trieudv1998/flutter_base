import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
  final int? postId;
  final int? id;
  final String? name;
  final String? email;
  final String? body;

  const CommentEntity({
    this.postId,
    this.id,
    this.name,
    this.email,
    this.body,
  });

  @override
  List<Object?> get props {
    return [postId, id, name, email, body];
  }
}
