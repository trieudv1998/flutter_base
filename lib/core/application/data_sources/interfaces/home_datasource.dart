
import 'package:dio/dio.dart';
import 'package:flutter_base/core/application/models/comment.dart';

abstract class HomeDataSource {
  Future<List<CommentModel>> getComments({
    CancelToken? cancelToken,
  });
}