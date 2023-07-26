import 'package:json_annotation/json_annotation.dart';

part 'object_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ObjectResponse<T> {
  @JsonKey(name: 'Code')
  final String? code;
  @JsonKey(name: 'MsgCode')
  final String? msgCode;
  @JsonKey(name: 'Message')
  final String? message;
  @JsonKey(name: 'Data')
  final T? data;

  factory ObjectResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ObjectResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$ObjectResponseToJson(this, toJsonT);

  const ObjectResponse({
    this.code,
    this.msgCode,
    this.message,
    this.data,
  });
}