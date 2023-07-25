part of 'home_cubit.dart';

@immutable
class HomeState extends Equatable {
  final LoadStatus? commentStatus;
  final List<CommentEntity>? listComment;
  final String? errorMessage;

  const HomeState({
    /// get order detail
    this.commentStatus,
    this.listComment,
    this.errorMessage,
  });

  HomeState copyWith({
    LoadStatus? commentStatus,
    List<CommentEntity>? listComment,
    String? errorMessage,
  }) {
    return HomeState(
      /// get order detail
      commentStatus: commentStatus ?? this.commentStatus,
      listComment: listComment ?? this.listComment,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        commentStatus,
        listComment,
        errorMessage,
      ];
}
