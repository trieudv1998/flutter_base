part of 'login_cubit.dart';


class LoginState extends Equatable {

  /// required
  final String phoneNumber;
  final String? phoneValidate;
  final String password;
  final String? passwordValidate;
  final bool? isEnable;

  final LoadStatus? loginStatus;
  final String? msgLogin;

  const LoginState({
    /// required
    this.phoneNumber = "",
    this.phoneValidate,
    this.password = "",
    this.passwordValidate,
    this.isEnable,
    this.loginStatus,
    this.msgLogin
  });

  LoginState copyWith({
    /// required
    String? phoneNumber,
    String? phoneValidate,
    String? password,
    String? passwordValidate,
    bool? isEnable,
    LoadStatus? loginStatus,
    String? msgLogin,
  }) {
    return LoginState(
      /// required
      phoneNumber: phoneNumber ?? this.phoneNumber,
      phoneValidate: phoneValidate ?? this.phoneValidate,
      password: password ?? this.password,
      passwordValidate: passwordValidate ?? this.passwordValidate,
      isEnable: isEnable ?? this.isEnable,
      loginStatus: loginStatus ?? this.loginStatus,
      msgLogin: msgLogin ?? this.msgLogin,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    /// required
    phoneNumber,
    phoneValidate,
    password,
    passwordValidate,
    isEnable,
    loginStatus,
    msgLogin
  ];
}

