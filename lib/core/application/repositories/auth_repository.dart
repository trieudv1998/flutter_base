import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_base/core/application/models/login.dart';
import 'package:flutter_base/core/domain/resources/object_response.dart';
import 'package:flutter_base/core/domain/resources/response_models.dart';

abstract class IAuthRepository {
  Future<Either<ErrorModel, ObjectResponse<LoginResponseModel>>> login({CancelToken? cancelToken});
}