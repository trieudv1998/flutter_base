import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
part 'direction.g.dart';
@JsonSerializable()
class Direction {
  List<GeocodedWaypoint> geocoded_waypoints;
  List<RouteItem> routes;
  String status;

  Direction({
    required this.geocoded_waypoints,
    required this.routes,
    required this.status,
  });
  factory Direction.fromJson(Map<String, dynamic> json) => _$DirectionFromJson(json);

  Map<String, dynamic> toJson() => _$DirectionToJson(this);
}
@JsonSerializable()
class GeocodedWaypoint {
  String geocoder_status;
  String place_id;
  List<String> types;

  GeocodedWaypoint({
    required this.geocoder_status,
    required this.place_id,
    required this.types,
  });

  factory GeocodedWaypoint.fromJson(Map<String, dynamic> json) => _$GeocodedWaypointFromJson(json);

  Map<String, dynamic> toJson() => _$GeocodedWaypointToJson(this);
}
@JsonSerializable()
class RouteItem {
  Bounds bounds;
  String copyrights;
  List<Leg> legs;
  PolylineItem overview_polyline;
  String summary;
  List<dynamic> warnings;
  List<dynamic> waypoint_order;

  RouteItem({
    required this.bounds,
    required this.copyrights,
    required this.legs,
    required this.overview_polyline,
    required this.summary,
    required this.warnings,
    required this.waypoint_order,
  });

  factory RouteItem.fromJson(Map<String, dynamic> json) => _$RouteItemFromJson(json);

  Map<String, dynamic> toJson() => _$RouteItemToJson(this);
}
@JsonSerializable()
class Bounds {
  Northeast northeast;
  Northeast southwest;

  Bounds({
    required this.northeast,
    required this.southwest,
  });
  factory Bounds.fromJson(Map<String, dynamic> json) => _$BoundsFromJson(json);

  Map<String, dynamic> toJson() => _$BoundsToJson(this);
}
@JsonSerializable()
class Northeast {
  double lat;
  double lng;

  Northeast({
    required this.lat,
    required this.lng,
  });
  factory Northeast.fromJson(Map<String, dynamic> json) => _$NortheastFromJson(json);

  Map<String, dynamic> toJson() => _$NortheastToJson(this);

}
@JsonSerializable()
class Leg {
  Distance distance;
  Distance duration;
  String end_address;
  Northeast end_location;
  String start_address;
  Northeast start_location;
  List<Step> steps;
  List<dynamic> traffic_speed_entry;
  List<dynamic> via_waypoint;

  Leg({
    required this.distance,
    required this.duration,
    required this.end_address,
    required this.end_location,
    required this.start_address,
    required this.start_location,
    required this.steps,
    required this.traffic_speed_entry,
    required this.via_waypoint,
  });
  factory Leg.fromJson(Map<String, dynamic> json) => _$LegFromJson(json);

  Map<String, dynamic> toJson() => _$LegToJson(this);

}
@JsonSerializable()
class Distance {
  String text;
  int value;

  Distance({
    required this.text,
    required this.value,
  });
  factory Distance.fromJson(Map<String, dynamic> json) => _$DistanceFromJson(json);

  Map<String, dynamic> toJson() => _$DistanceToJson(this);

}
@JsonSerializable()
class Step {
  Distance distance;
  Distance duration;
  Northeast end_location;
  String html_instructions;
  PolylineItem polyline;
  Northeast start_location;
  TravelMode travel_mode;
  String? maneuver;

  Step({
    required this.distance,
    required this.duration,
    required this.end_location,
    required this.html_instructions,
    required this.polyline,
    required this.start_location,
    required this.travel_mode,
    this.maneuver,
  });
  factory Step.fromJson(Map<String, dynamic> json) => _$StepFromJson(json);

  Map<String, dynamic> toJson() => _$StepToJson(this);

}
@JsonSerializable()
class PolylineItem {
  String points;

  PolylineItem({
    required this.points,
  });
  factory PolylineItem.fromJson(Map<String, dynamic> json) => _$PolylineItemFromJson(json);

  Map<String, dynamic> toJson() => _$PolylineItemToJson(this);

}

enum TravelMode {
  DRIVING
}

final travelModeValues = EnumValues({
  "DRIVING": TravelMode.DRIVING
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverse_map;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverse_map = map.map((k, v) => MapEntry(v, k));
    return reverse_map;
  }
}
