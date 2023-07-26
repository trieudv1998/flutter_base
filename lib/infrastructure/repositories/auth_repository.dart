import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_base/core/application/models/login.dart';
import 'package:flutter_base/core/application/repositories/auth_repository.dart';
import 'package:flutter_base/core/domain/resources/client_provider.dart';
import 'package:flutter_base/core/domain/resources/object_response.dart';
import 'package:flutter_base/core/domain/resources/response_models.dart';

class AuthRepository extends IAuthRepository {
  AuthRepository();

  @override
  Future<Either<ErrorModel, ObjectResponse<LoginResponseModel>>> login({CancelToken? cancelToken}) async {
    try {

      final response = await RestClientProvider.apiClient!.login(
        {
          "locale": "vn",
          "password": "Abc@12345",
          "phone_number": "0914642838",
          "client_id": "nothinghere",
          "csrf": "",
          "player_id": "",
        },
        cancelToken,
      );

      //TODO: handler response models => entity
      return Right(response);
    } catch (e) {
      if (e is DioError) {
        return Left(ErrorModel(message: e.error.toString()));
      }
      return Left(ErrorModel(message: e.toString()));
    }
  }
}
