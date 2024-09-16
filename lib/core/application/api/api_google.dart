import 'package:dio/dio.dart';
import 'package:flutter_base/core/application/models/direction.dart';
import 'package:flutter_base/core/application/models/get_direction.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'api_google.g.dart';


@RestApi(baseUrl: '')
abstract class ApiGoogle {
  factory ApiGoogle(Dio dio, {String? baseUrl}) = _ApiGoogle;

  @GET('/directions/json')
  Future<Direction> getDirections(
      @Queries() GetDirection? queries,
      @CancelRequest() CancelToken? cancelToken,
  );
}
