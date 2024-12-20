import 'package:json_annotation/json_annotation.dart';

part 'login.g.dart';
@JsonSerializable()
class LoginResponseModel {
  @JsonKey(name: 'access_token')
  final String? accessToken;

  LoginResponseModel({
    this.accessToken,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => _$LoginResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}
