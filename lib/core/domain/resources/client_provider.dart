import 'package:dio/dio.dart';
import 'package:flutter_base/core/application/api/api_client.dart';
import 'package:flutter_base/core/application/api/api_google.dart';
import 'package:flutter_base/core/domain/configs/app_configs.dart';
import 'package:flutter_base/core/domain/resources/dio_provider.dart';

class RestClientProvider {
  static ApiClient? apiClient;
  static ApiGoogle? apiGoogle;


  // static final String _baseUrl = env['BASE_URL'];

  /// Initialize rest client.
  /// [dio] The dio that will be used as a http client
  /// [forceInit] If true, we recreate RestClient. This is necessary when user
  /// logs in successfully or the token is reset/refreshed. In that case, we need to set
  /// the token to header again.
  static Future<void> init({Dio? dio, String? baseUrl, bool forceInit = false}) async {
    Dio? apiProvidedDio = dio;
    Dio? apiGoogleDio = dio;

    // If dio is not passed, generate new one
    apiProvidedDio ??= await provideDio();
    apiGoogleDio ??= await provideDio();


    if (forceInit) {
      apiClient = ApiClient(apiProvidedDio, baseUrl: baseUrl ?? AppConfigs.baseUrl);
      apiGoogle =
          ApiGoogle(apiGoogleDio, baseUrl: baseUrl ?? AppConfigs.googleUrl);
    } else {
      // Only recreate when restClient is null.
      apiClient ??= ApiClient(apiProvidedDio, baseUrl: baseUrl ?? AppConfigs.baseUrl);
      apiGoogle =
          ApiGoogle(apiGoogleDio, baseUrl: baseUrl ?? AppConfigs.googleUrl);
    }
  }
}