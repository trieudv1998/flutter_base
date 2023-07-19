import 'package:json_annotation/json_annotation.dart';

part 'object_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ObjectResponse<T> {
  final String? message;
  final int? messageCode;
  final int? numberOfResult;
  final T? result;

  factory ObjectResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ObjectResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$ObjectResponseToJson(this, toJsonT);

  const ObjectResponse({
    this.message,
    this.messageCode,
    this.numberOfResult,
    this.result,
  });
}