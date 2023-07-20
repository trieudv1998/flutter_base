

import 'package:flutter/material.dart';
import 'package:flutter_base/core/domain/utils/share_preferrences.dart';

Future<String> getAccessToken() async {
  final String token = await SharedPreferencesHelper.getStringValue(SharedPreferencesHelper.USER_TOKEN);
  return token;
}

class Utils {
  static getScreenWidth(context) => MediaQuery.of(context).size.width;

  static getScreenHeight(context) => MediaQuery.of(context).size.height;
}