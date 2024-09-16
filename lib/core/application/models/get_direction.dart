import 'package:json_annotation/json_annotation.dart';

part 'get_direction.g.dart';

@JsonSerializable()
class GetDirection {
  String? origin;
  String ? destination;
  String? key;
  String? mode;
  String? alternatives;

  GetDirection({
    this.origin,
    this.destination,
    this.key,
    this.mode,
    this.alternatives,
  });

  factory GetDirection.fromJson(Map<String, dynamic> json) => _$GetDirectionFromJson(json);

  Map<String, dynamic> toJson() => _$GetDirectionToJson(this);
}
