import 'package:flutter_base/core/utils/share_preferrences.dart';

Future<String> getAccessToken() async {
  final String token = await SharedPreferencesHelper.getStringValue(SharedPreferencesHelper.USER_TOKEN);
  return token;
}