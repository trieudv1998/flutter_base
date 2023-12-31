import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/application/common/widgets/custom_dialog.dart';
import 'package:flutter_base/core/domain/constants/app_colors.dart';
import 'package:flutter_base/core/domain/resources/error_handler.dart';
import 'package:flutter_base/core/domain/storages/global_storages.dart';
import 'package:flutter_base/core/domain/utils/check_connection_util.dart';
import 'package:flutter_base/core/domain/utils/logger.dart';
import 'package:flutter_base/core/domain/utils/navigation_services.dart';
import 'package:flutter_base/core/domain/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        if (GlobalStorage.haveDialogError == false) {
          GlobalStorage.haveDialogError = true;
          showCustomDialog(
            NavigationService.navigatorKey.currentContext!,
            hideNegativeButton: true,
            onPressPositive: () async {
              final bool isNetworkAvailable = await checkConnection();
              if (isNetworkAvailable) {
                final globalContext = NavigationService.navigatorKey.currentContext!;
                Navigator.of(globalContext).pop();
                GlobalStorage.haveDialogError = false;
              }
            },
            showCloseButton: false,
            title: 'Không có kết nối',
            content: Text(
              'Không có kết nối',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400, color: AppColors.b200),
            ),
            textPositive: 'Thử lại',
            barrierDismissible: false,
            preventBack: true,
          );
        }
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
  final errorMessage = DioExceptions.fromDioError(e).toString();
  if (e.type == DioErrorType.cancel) {
    // Suppress this type of error, clear and move next
    e.error = "";
    return;
  }
  e.error = errorMessage;
  return handler.next(e);
}
