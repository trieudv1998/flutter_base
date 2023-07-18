import 'package:flutter_base/core/resources/api_response.dart';
import 'package:flutter_base/domain/entities/comment.dart';

abstract class HomeRepository {
  Future<ApiResponse<List<CommentEntity>>> getComments();
}
