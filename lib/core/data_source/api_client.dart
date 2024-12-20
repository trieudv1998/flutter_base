import 'package:dio/dio.dart';
import 'package:flutter_base/core/data_source/object_response.dart';
import 'package:flutter_base/core/dto/login.dart';
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
}
