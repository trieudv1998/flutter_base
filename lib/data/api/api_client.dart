import 'package:dio/dio.dart';
import 'package:flutter_base/data/models/comment.dart';
import 'package:retrofit/retrofit.dart';
part 'api_client.g.dart';

@RestApi(baseUrl: '')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  @GET('/comments')
  Future<HttpResponse<List<CommentModel>>> getComments();
}
