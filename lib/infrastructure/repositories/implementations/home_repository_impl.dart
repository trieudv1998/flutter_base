import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_base/core/application/data_sources/interfaces/home_datasource.dart';
import 'package:flutter_base/core/application/models/comment.dart';
import 'package:flutter_base/core/domain/resources/response_models.dart';
import 'package:flutter_base/infrastructure/entities/comment.dart';
import 'package:flutter_base/infrastructure/repositories/interfaces/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeDataSource homeDataSource;

  HomeRepositoryImpl({required this.homeDataSource});

  @override
  Future<Either<ErrorModel, List<CommentEntity>>> getComments({CancelToken? cancelToken}) async {
    try {
      final response = await homeDataSource.getComments(cancelToken: cancelToken);

      //TODO: handler response models => entity
      return Right(response.map((e) => e.toEntity()).toList());
    } on DioError catch (e) {
      return Left(ErrorModel(message: e.error.toString()));
    }
  }
}
