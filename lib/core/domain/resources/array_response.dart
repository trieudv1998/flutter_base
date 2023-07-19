import 'package:json_annotation/json_annotation.dart';

part 'array_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ArrayResponse<T> {
  final String? message;
  final int? messageCode;
  final int? numberOfResult;
  final List<T>? result;

  factory ArrayResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ArrayResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$ArrayResponseToJson(this, toJsonT);

  const ArrayResponse({
    this.message,
    this.messageCode,
    this.numberOfResult,
    this.result,
  });
}
