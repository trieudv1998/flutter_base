part of 'home_cubit.dart';
@immutable
class HomeState extends Equatable {
  final LoadStatus? commentStatus;
  final List<CommentEntity>? listComment;

  const HomeState({
    /// get order detail
    this.commentStatus,
    this.listComment,
  });

  HomeState copyWith({
    LoadStatus? commentStatus,
    List<CommentEntity>? listComment,
  }) {
    return HomeState(
      /// get order detail
      commentStatus: commentStatus ?? this.commentStatus,
      listComment: listComment ?? this.listComment,
    );
  }

  @override
  List<Object?> get props => [
    commentStatus,
    listComment,
  ];
}

