import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_base/core/application/models/login.dart';
import 'package:flutter_base/core/application/repositories/auth_repository.dart';
import 'package:flutter_base/core/domain/enum/load_status.dart';
import 'package:flutter_base/core/domain/resources/client_provider.dart';
import 'package:flutter_base/core/domain/resources/object_response.dart';
import 'package:flutter_base/core/domain/resources/response_models.dart';
import 'package:flutter_base/core/domain/storages/global_storages.dart';
import 'package:flutter_base/core/domain/utils/logger.dart';
import 'package:flutter_base/core/domain/utils/share_preferrences.dart';
import 'package:flutter_base/core/domain/validators/validators.dart';
import 'package:flutter_base/infrastructure/repositories/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository authRepository;

  LoginCubit({required this.authRepository}) : super(const LoginState());

  void onChangePhoneNumber(String phoneNumber) {
    String phoneValidate = "";
    if (phoneNumber.trim().isEmpty) {
      phoneValidate = "So dien thoai khong duoc de trong";
    }
    if (!Validator.validatePhone(phoneNumber)) {
      phoneValidate = "So dien thoai khong dung dinh dang";
    }
    emit(state.copyWith(phoneNumber: phoneNumber.trim(), phoneValidate: phoneValidate));
    onCheckEnableButton();
  }

  void onChangePassword(String password) {
    String passwordValidate = "";
    if (password.trim().isEmpty) {
      passwordValidate = "Mat khau khong duoc de trong";
    }
    if (password.length < 6) {
      passwordValidate = "Mat khau toi thieu 6 ki tu";
    }
    emit(state.copyWith(password: password.trim(), passwordValidate: passwordValidate));
    onCheckEnableButton();
  }

  void onCheckEnableButton() {
    final isEnable =
        state.phoneValidate?.isEmpty == true && state.passwordValidate?.isEmpty == true;
    emit(state.copyWith(isEnable: isEnable));
  }

  Future<void> login({CancelToken? cancelToken}) async {
    try {
      Either<ErrorModel, ObjectResponse<LoginResponseModel>> response = await authRepository.login(cancelToken: cancelToken);
      response.fold(
        (error) => {
          emit(state.copyWith(
            loginStatus: LoadStatus.FAILURE,
            msgLogin: error.message,
          )),
        },
        (response) async => {
          emit(state.copyWith(
            loginStatus: LoadStatus.SUCCESS,
            msgLogin: '',
          )),
          await saveLoggedInSession(response.data?.accessToken ?? ''),
        },
      );
    } catch (e, s) {
      AppLogger.instance.error(e);
    }
  }

  Future<void> saveLoggedInSession(String token) async {
    try {
      await SharedPreferencesHelper.saveStringValue(SharedPreferencesHelper.ACCESS_TOKEN, token);
      await RestClientProvider.init(forceInit: true);
      GlobalStorage.accessToken = token;
    } catch (e) {
      AppLogger.instance.error(e);
    }
  }
}
