import 'package:dio/dio.dart';
import 'package:flutter_base/core/configs/app_configs.dart';
import 'package:flutter_base/core/data_source/api_client.dart';
import 'package:flutter_base/core/data_source/dio_provider.dart';

class RestClientProvider {
  static ApiClient? apiClient;

  // static final String _baseUrl = env['BASE_URL'];

  /// Initialize rest client.
  /// [dio] The dio that will be used as a http client
  /// [forceInit] If true, we recreate RestClient. This is necessary when user
  /// logs in successfully or the token is reset/refreshed. In that case, we need to set
  /// the token to header again.
  static Future<void> init({Dio? dio, String? baseUrl, bool forceInit = false}) async {
    Dio? apiProvidedDio = dio;

    // If dio is not passed, generate new one
    apiProvidedDio ??= await provideDio();


    if (forceInit) {
      apiClient = ApiClient(apiProvidedDio, baseUrl: baseUrl ?? AppConfigs.baseUrl);
    } else {
      apiClient ??= ApiClient(apiProvidedDio, baseUrl: baseUrl ?? AppConfigs.baseUrl);
    }
  }
}