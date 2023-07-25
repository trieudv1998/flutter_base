import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_base/core/application/models/comment.dart';
import 'package:flutter_base/core/domain/resources/response_models.dart';
import 'package:flutter_base/infrastructure/entities/comment.dart';

abstract class HomeRepository {
  Future<Either<ErrorModel, List<CommentEntity>>> getComments({CancelToken? cancelToken});
}
