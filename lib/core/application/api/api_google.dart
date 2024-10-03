import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'api_google.g.dart';

@RestApi(baseUrl: '')
abstract class ApiGoogle {
  factory ApiGoogle(Dio dio, {String? baseUrl}) = _ApiGoogle;
}
