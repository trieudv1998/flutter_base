
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
part 'direction.g.dart';
// Directions directionsFromJson(String str) => Directions.fromJson(json.decode(str));
//
// String directionsToJson(Directions data) => json.encode(data.toJson());
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
  // factory Directions.fromJson(Map<String, dynamic> json) => Directions(
  //   geocodedWaypoints: List<GeocodedWaypoint>.from(json["geocoded_waypoints"].map((x) => GeocodedWaypoint.fromJson(x))),
  //   routes: List<Route>.from(json["routes"].map((x) => Route.fromJson(x))),
  //   status: json["status"],
  // );
  //
  // Map<String, dynamic> toJson() => {
  //   "geocoded_waypoints": List<dynamic>.from(geocodedWaypoints.map((x) => x.toJson())),
  //   "routes": List<dynamic>.from(routes.map((x) => x.toJson())),
  //   "status": status,
  // };
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
  // factory GeocodedWaypoint.fromJson(Map<String, dynamic> json) => GeocodedWaypoint(
  //   geocoderStatus: json["geocoder_status"],
  //   placeId: json["place_id"],
  //   types: List<String>.from(json["types"].map((x) => x)),
  // );
  //
  // Map<String, dynamic> toJson() => {
  //   "geocoder_status": geocoderStatus,
  //   "place_id": placeId,
  //   "types": List<dynamic>.from(types.map((x) => x)),
  // };
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

  // factory Route.fromJson(Map<String, dynamic> json) => Route(
  //   bounds: Bounds.fromJson(json["bounds"]),
  //   copyrights: json["copyrights"],
  //   legs: List<Leg>.from(json["legs"].map((x) => Leg.fromJson(x))),
  //   overviewPolyline: Polyline.fromJson(json["overview_polyline"]),
  //   summary: json["summary"],
  //   warnings: List<dynamic>.from(json["warnings"].map((x) => x)),
  //   waypointOrder: List<dynamic>.from(json["waypoint_order"].map((x) => x)),
  // );
  //
  // Map<String, dynamic> toJson() => {
  //   "bounds": bounds.toJson(),
  //   "copyrights": copyrights,
  //   "legs": List<dynamic>.from(legs.map((x) => x.toJson())),
  //   "overview_polyline": overviewPolyline.toJson(),
  //   "summary": summary,
  //   "warnings": List<dynamic>.from(warnings.map((x) => x)),
  //   "waypoint_order": List<dynamic>.from(waypointOrder.map((x) => x)),
  // };
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

  // factory Bounds.fromJson(Map<String, dynamic> json) => Bounds(
  //   northeast: Northeast.fromJson(json["northeast"]),
  //   southwest: Northeast.fromJson(json["southwest"]),
  // );
  //
  // Map<String, dynamic> toJson() => {
  //   "northeast": northeast.toJson(),
  //   "southwest": southwest.toJson(),
  // };
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

  // factory Northeast.fromJson(Map<String, dynamic> json) => Northeast(
  //   lat: json["lat"]?.toDouble(),
  //   lng: json["lng"]?.toDouble(),
  // );
  //
  // Map<String, dynamic> toJson() => {
  //   "lat": lat,
  //   "lng": lng,
  // };
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

  // factory Leg.fromJson(Map<String, dynamic> json) => Leg(
  //   distance: Distance.fromJson(json["distance"]),
  //   duration: Distance.fromJson(json["duration"]),
  //   endAddress: json["end_address"],
  //   endLocation: Northeast.fromJson(json["end_location"]),
  //   startAddress: json["start_address"],
  //   startLocation: Northeast.fromJson(json["start_location"]),
  //   steps: List<Step>.from(json["steps"].map((x) => Step.fromJson(x))),
  //   trafficSpeedEntry: List<dynamic>.from(json["traffic_speed_entry"].map((x) => x)),
  //   viaWaypoint: List<dynamic>.from(json["via_waypoint"].map((x) => x)),
  // );
  //
  // Map<String, dynamic> toJson() => {
  //   "distance": distance.toJson(),
  //   "duration": duration.toJson(),
  //   "end_address": endAddress,
  //   "end_location": endLocation.toJson(),
  //   "start_address": startAddress,
  //   "start_location": startLocation.toJson(),
  //   "steps": List<dynamic>.from(steps.map((x) => x.toJson())),
  //   "traffic_speed_entry": List<dynamic>.from(trafficSpeedEntry.map((x) => x)),
  //   "via_waypoint": List<dynamic>.from(viaWaypoint.map((x) => x)),
  // };
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

  // factory Distance.fromJson(Map<String, dynamic> json) => Distance(
  //   text: json["text"],
  //   value: json["value"],
  // );
  //
  // Map<String, dynamic> toJson() => {
  //   "text": text,
  //   "value": value,
  // };
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

  // factory Step.fromJson(Map<String, dynamic> json) => Step(
  //   distance: Distance.fromJson(json["distance"]),
  //   duration: Distance.fromJson(json["duration"]),
  //   endLocation: Northeast.fromJson(json["end_location"]),
  //   htmlInstructions: json["html_instructions"],
  //   polyline: Polyline.fromJson(json["polyline"]),
  //   startLocation: Northeast.fromJson(json["start_location"]),
  //   travelMode: travelModeValues.map[json["travel_mode"]]!,
  //   maneuver: json["maneuver"],
  // );
  //
  // Map<String, dynamic> toJson() => {
  //   "distance": distance.toJson(),
  //   "duration": duration.toJson(),
  //   "end_location": endLocation.toJson(),
  //   "html_instructions": htmlInstructions,
  //   "polyline": polyline.toJson(),
  //   "start_location": startLocation.toJson(),
  //   "travel_mode": travelModeValues.reverse[travelMode],
  //   "maneuver": maneuver,
  // };
}
@JsonSerializable()
class PolylineItem {
  String points;

  PolylineItem({
    required this.points,
  });
  factory PolylineItem.fromJson(Map<String, dynamic> json) => _$PolylineItemFromJson(json);

  Map<String, dynamic> toJson() => _$PolylineItemToJson(this);

  // factory Polyline.fromJson(Map<String, dynamic> json) => Polyline(
  //   points: json["points"],
  // );
  //
  // Map<String, dynamic> toJson() => {
  //   "points": points,
  // };
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
