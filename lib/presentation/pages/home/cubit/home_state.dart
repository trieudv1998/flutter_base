part of 'home_cubit.dart';

@immutable
class HomeState extends Equatable {
  final LoadStatus? status;

  const HomeState({
    /// get order detail
    this.status,
  });

  HomeState copyWith({
    LoadStatus? status,
  }) {
    return HomeState(
      /// get order detail
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        status,
      ];
}
