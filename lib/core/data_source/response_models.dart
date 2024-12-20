import 'package:json_annotation/json_annotation.dart';

part 'response_models.g.dart';

@JsonSerializable()
class ErrorModel {
  final String? message;

  ErrorModel({this.message});

  factory ErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorModelToJson(this);
}