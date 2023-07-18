
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_base/core/utils/check_connection_util.dart';
import 'package:flutter_base/core/utils/logger.dart';
import 'package:flutter_base/core/utils/navigation_services.dart';
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
    connectTimeout: 60 * 1000,
    receiveTimeout: 60 * 1000,
  );

  final Dio dio = Dio(options);
  //TO DO :by pass certificate
  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return client;
  };
  //-------------------------
  final InterceptorsWrapper interceptorsWrapper = InterceptorsWrapper(
    onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
      final bool isNetworkAvailable = await checkConnection();
      if (!isNetworkAvailable) {
        //TODO: handler show modal network
        return handler.next(options.copyWith(data: 'Connection Failed'));
      }
      return handler.next(options);
    },
    onResponse: (
      Response response,
      ResponseInterceptorHandler responseInterceptorHandler,
    ) {
      if (kReleaseMode) {
        AppLogger.instance.debug(response.toString());
      }
      return responseInterceptorHandler.next(response);
    },
    onError: customHandleErrorByStatusCode,
  );
  dio.interceptors.add(interceptorsWrapper);

  return dio;
}

customHandleErrorByStatusCode(DioError e, ErrorInterceptorHandler handler) async {
  if (kReleaseMode) {
    AppLogger.instance.error(e.message);
  }
  if (e.type == DioErrorType.cancel) {
    // Suppress this type of error, clear and move next
    e.error = "";
    return;
  }
  if (e.error is SocketException) {
    // e.error = "Không thể kết nối tới server";
    e.error = "";
    return handler.next(e);
  }
  debugPrint("------- ERROR -------");
  debugPrint(e.toString());
  final currentContext = NavigationService.navigatorKey.currentContext;
  if (currentContext != null) {
    switch (e.response?.statusCode) {
      case HttpStatus.unavailableForLegalReasons:
      case HttpStatus.unauthorized:
        break;
      case HttpStatus.internalServerError:
      default:
        final errorMessage =
            'URI:\n${e.requestOptions.uri}\nMethod:\n${e.requestOptions.method}\nQueryParameters:\n${e.requestOptions.queryParameters}\nData:\n${e.requestOptions.data}\nHeaders\n:${e.requestOptions.headers.toString()}';
    }
  }
  return handler.next(e);
}
