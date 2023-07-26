import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  String? accessToken;

  LoginEntity({
    this.accessToken,
  });

  @override
  List<Object?> get props => [
    accessToken,
  ];
}