import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_base/core/application/models/comment.dart';
import 'package:flutter_base/core/domain/resources/response_models.dart';

abstract class IHomeRepository {
  Future<Either<ErrorModel, List<CommentModel>>> getComments({CancelToken? cancelToken});
}
