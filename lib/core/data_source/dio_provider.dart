import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_base/core/utils/utils.dart';

Future<Dio> provideDio({Map<String, dynamic>? pHeaders, bool isNewVersion = false}) async {
  // Try to get access token. If existing, add this token to the http headers
  final Map<String, dynamic> headers = pHeaders ?? {'content-type': 'application/json'};
  String accessToken = await getAccessToken();

  if (accessToken.isNotEmpty) {
    headers.putIfAbsent('Authorization', () => 'Bearer $accessToken');
  }

  final BaseOptions options = BaseOptions(
    headers: headers,
    connectTimeout: const Duration(milliseconds: 60 * 1000),
    receiveTimeout: const Duration(milliseconds: 60 * 1000),
  );

  final Dio dio = Dio(options);
  //TO DO :by pass certificate
  (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
    final client = HttpClient();
    client.badCertificateCallback = (cert, host, port) => true;
    return client;
  };
  //-------------------------
  final InterceptorsWrapper interceptorsWrapper = InterceptorsWrapper(
    onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
      return handler.next(options);
    },
    onResponse: (
      Response response,
      ResponseInterceptorHandler responseInterceptorHandler,
    ) {
      return responseInterceptorHandler.next(response);
    },
    onError: customHandleErrorByStatusCode,
  );
  dio.interceptors.add(interceptorsWrapper);

  return dio;
}

customHandleErrorByStatusCode(DioException err, ErrorInterceptorHandler handler) async {
  if (err.type == DioExceptionType.cancel) {
    // Suppress this type of error, clear and move next
    return;
  }
  // Check if the user is unauthorized.
  if (err.response?.statusCode == 401) {
    // Refresh the user's authentication token.
    // await refreshToken();
    // Retry the request.
    try {
      // handler.resolve(await _retry(err.requestOptions));
    } on DioException catch (e) {
      // If the request fails again, pass the error to the next interceptor in the chain.
      handler.next(e);
    }
    // Return to prevent the next interceptor in the chain from being executed.
    return;
  }
  // Pass the error to the next interceptor in the chain.
  handler.next(err);
}
