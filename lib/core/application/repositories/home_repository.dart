import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_base/core/application/models/comment.dart';
import 'package:flutter_base/core/application/models/direction.dart';
import 'package:flutter_base/core/domain/resources/response_models.dart';

import '../models/get_direction.dart';

abstract class IHomeRepository {
  Future<Either<ErrorModel, List<CommentModel>>> getComments({CancelToken? cancelToken});
  Future<Either<ErrorModel,Direction>> getDirections({GetDirection? queryParams ,CancelToken? cancelToken});
}
