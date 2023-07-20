import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_base/core/application/models/comment.dart';
import 'package:flutter_base/core/domain/resources/client_provider.dart';
import 'package:flutter_base/core/domain/resources/response_models.dart';

abstract class HomeRepository {
  Future<Either<ErrorModel, List<CommentModel>>> getComments();
}

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl();

  @override
  Future<Either<ErrorModel, List<CommentModel>>> getComments() async {
    try {
      final response = await RestClientProvider.apiClient!.getComments();

      return Right(response);
    } on DioError catch (e) {

      return Left(ErrorModel(message: e.toString()));
    }
  }
}
