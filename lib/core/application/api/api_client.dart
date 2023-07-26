import 'package:dio/dio.dart';
import 'package:flutter_base/core/application/models/comment.dart';
import 'package:flutter_base/core/application/models/login.dart';
import 'package:flutter_base/core/domain/resources/object_response.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: '')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  @POST('/auth')
  Future<ObjectResponse<LoginResponseModel>> login(
    @Body() Map<String, String> body,
    @CancelRequest() CancelToken? cancelToken,
  );

  @GET('/comments')
  Future<List<CommentModel>> getComments(
    @CancelRequest() CancelToken? cancelToken,
  );
}
