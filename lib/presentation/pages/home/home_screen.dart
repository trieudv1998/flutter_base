// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_base/presentation/pages/home/cubit/home_cubit.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// import '../../../core/domain/utils/share_preferrences.dart';
// import '../../routes/route_name.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   late HomeCubit _homeCubit;
//   CancelToken? _cancelToken;
//   late GoogleMapController mapController;
//
//   List<Map<String, double>>? mapPoints;
//   GoogleMapController? _mapController;
//   Set<Marker> _markers = {};
//   Polyline? _polyline;
//
//   @override
//   void initState() {
//     super.initState();
//     _cancelToken = CancelToken();
//     _homeCubit = BlocProvider.of<HomeCubit>(context);
//     _loadMapPoints();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _cancelToken?.cancel();
//     _cancelToken = null;
//   }
//
//   Future<void> _loadMapPoints() async {
//     mapPoints = await SharedPreferencesHelper.getPointsList();
//     if (mapPoints != null) {
//       _addMarkersAndPolyline();
//     }
//     setState(() {});
//   }
//
//   void _addMarkersAndPolyline() {
//     if (mapPoints != null && mapPoints!.length >= 2) {
//       for (var i = 0; i < mapPoints!.length; i++) {
//         _markers.add(Marker(
//           markerId: MarkerId('point${i + 1}'),
//           position: LatLng(mapPoints![i]['lat']!, mapPoints![i]['lon']!),
//           visible: false,
//         ));
//       }
//       _polyline = Polyline(
//         polylineId: PolylineId('route'),
//         points: mapPoints!.map((point) => LatLng(point['lat']!, point['lon']!)).toList(),
//         color: Colors.blue,
//         width: 5,
//       );
//     }
//   }
//
//   Future<void> _drawRoute(LatLng origin, LatLng destination) async {
//     final directions = await _getDirections(origin, destination);
//     if (directions != null) {
//       final points = _decodePolyline(directions['routes'][0]['overview_polyline']['points']);
//       setState(() {
//         _polyline = Polyline(
//           polylineId: PolylineId('route'),
//           points: points,
//           color: Colors.blue,
//           width: 5,
//         );
//       });
//       await SharedPreferencesHelper.savePointsList(points.map((point) => {
//         'lat': point.latitude,
//         'lon': point.longitude,
//       }).toList());
//     }
//   }
//
//   Future<Map<String, dynamic>?> _getDirections(LatLng origin, LatLng destination) async {
//     final dio = Dio();
//     final response = await dio.get(
//       'https://maps.googleapis.com/maps/api/directions/json',
//       queryParameters: {
//         'origin': '${origin.latitude},${origin.longitude}',
//         'destination': '${destination.latitude},${destination.longitude}',
//         'key': 'AIzaSyAgdgBJdiCBuMc8kQiUSD2aUK0IJm59HBU',
//         'mode': 'driving',
//         'alternatives': 'true', // Yêu cầu trả về nhiều tuyến đường
//       },
//     );
//     if (response.statusCode == 200) {
//       print("alo");
//       print(response.data);
//       return response.data;
//     }
//     return null;
//   }
//
//   List<LatLng> _decodePolyline(String polyline) {
//     List<LatLng> points = [];
//     int index = 0, len = polyline.length;
//     int lat = 0, lng = 0;
//
//     while (index < len) {
//       int b, shift = 0, result = 0;
//       do {
//         b = polyline.codeUnitAt(index++) - 63;
//         result |= (b & 0x1f) << shift;
//         shift += 5;
//       } while (b >= 0x20);
//       int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
//       lat += dlat;
//
//       shift = 0;
//       result = 0;
//       do {
//         b = polyline.codeUnitAt(index++) - 63;
//         result |= (b & 0x1f) << shift;
//         shift += 5;
//       } while (b >= 0x20);
//       int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
//       lng += dlng;
//
//       points.add(LatLng(lat / 1E5, lng / 1E5));
//     }
//
//     return points;
//   }
//
//   void _onMapTapped(LatLng position) async {
//     if (_markers.length < 2) {
//       setState(() {
//         _markers.add(Marker(
//           markerId: MarkerId('point${_markers.length + 1}'),
//           position: position,
//         ));
//       });
//
//       if (_markers.length == 2) {
//         final markerList = _markers.toList();
//         await _drawRoute(markerList[0].position, markerList[1].position);
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(
//             child: GoogleMap(
//               onMapCreated: (controller) {
//                 _mapController = controller;
//               },
//               initialCameraPosition: const CameraPosition(
//                 target: LatLng(10.762622, 106.660172), // Default location
//                 zoom: 10,
//               ),
//               markers: _markers,
//               polylines: _polyline != null ? {_polyline!} : {},
//               onTap: _onMapTapped,
//             ),
//           ),
//           if (mapPoints != null)
//             Expanded(
//               child: ListView.builder(
//                 itemCount: mapPoints!.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text(
//                       'Point ${index + 1}: (${mapPoints![index]['lat']}, ${mapPoints![index]['lon']})',
//                     ),
//                   );
//                 },
//               ),
//             ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: () {
//           Navigator.of(context).pushNamed(
//             RouteName.safeAreaScreen,
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/application/models/direction.dart';
import 'package:flutter_base/core/application/models/get_direction.dart';
import 'package:flutter_base/core/domain/configs/app_configs.dart';
import 'package:flutter_base/presentation/pages/home/cubit/home_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/domain/utils/share_preferrences.dart';
import '../../routes/route_name.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeCubit _homeCubit;
  CancelToken? _cancelToken;
  late GoogleMapController mapController;

  List<Map<String, double>>? mapPoints;
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {}; // Khởi tạo Set để lưu các Polyline
  // Khởi tạo một Set rỗng để lưu các Polyline
  List<List<LatLng>> routePointsList = [];

  @override
  void initState() {
    super.initState();
    _cancelToken = CancelToken();
    _homeCubit = BlocProvider.of<HomeCubit>(context);
    _loadMapPoints();
  }

  @override
  void dispose() {
    super.dispose();
    _cancelToken?.cancel();
    _cancelToken = null;
  }

  Future<void> _loadMapPoints() async {
    mapPoints = await SharedPreferencesHelper.getPointsList();
    if (mapPoints != null) {
      // Hiển thị tuyến đường đã lưu
      setState(() {
        _polylines = {
          Polyline(
            polylineId: PolylineId('saved_route'),
            points: mapPoints!
                .map((point) => LatLng(point['lat']!, point['lon']!))
                .toList(),
            color: Colors.blue,
            width: 5,
          ),
        };
      });
    }
  }

  void _addMarkersAndPolyline() {
    if (mapPoints != null && mapPoints!.length >= 2) {
      for (var i = 0; i < mapPoints!.length; i++) {
        _markers.add(Marker(
          markerId: MarkerId('point${i + 1}'),
          position: LatLng(mapPoints![i]['lat']!, mapPoints![i]['lon']!),
          visible: false,
        ));
      }
      _polylines = {
        Polyline(
          polylineId: PolylineId('route'),
          points: mapPoints!
              .map((point) => LatLng(point['lat']!, point['lon']!))
              .toList(),
          color: Colors.blue,
          width: 5,
        )
      };
    }
  }

  Future<void> _drawRoute(LatLng origin, LatLng destination) async {
    final directions = await _getDirections(origin, destination);
    if (directions != null) {
      final List<RouteItem> routes = directions.routes;
      routePointsList.clear(); // Làm sạch danh sách tuyến đường trước khi thêm mới

      for (int i = 0; i < routes.length; i++) {
        final points = _decodePolyline(routes[i].overview_polyline.points);
        routePointsList.add(points);

        setState(() {
          _polylines.add(Polyline(
            polylineId: PolylineId('route_$i'),
            points: points,
            color: Colors.grey, // Màu xám cho các tuyến đường khác
            width: 5,
          ));
        });
      }

      // Hiển thị danh sách các tuyến đường để người dùng chọn
      _showRouteSelection(routePointsList);
    }
  }

  void _showRouteSelection(List<List<LatLng>> routes) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView.builder(
          itemCount: routes.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Route ${index + 1}'),
              onTap: () {
                _onRouteSelected(routes[index]);
                Navigator.pop(context); // Đóng BottomSheet khi chọn xong
              },
            );
          },
        );
      },
    );
  }

  void _onRouteSelected(List<LatLng> points) async {
    setState(() {
      // Chỉ giữ lại tuyến đường đã chọn và xoá các tuyến đường còn lại
      _polylines = {
        Polyline(
          polylineId: PolylineId('selected_route'),
          points: points,
          color: Colors.blue, // Màu tuyến đường đã chọn
          width: 5,
        ),
      };
    });

    // Lưu tuyến đường đã chọn vào SharedPreferences
    await SharedPreferencesHelper.savePointsList(
      points
          .map((point) => {
        'lat': point.latitude,
        'lon': point.longitude,
      })
          .toList(),
    );
  }


  Future<dynamic> _getDirections(
      LatLng origin, LatLng destination) async {
    final directions = await _homeCubit.getDirections(
      queryParams: GetDirection(
        origin: '${origin.latitude},${origin.longitude}',
        destination: '${destination.latitude},${destination.longitude}',
        mode: 'driving',
        alternatives: "true",
        key: AppConfigs.apiKey,
      ),
      cancelToken: _cancelToken,
    );
    return directions;

  }

  List<LatLng> _decodePolyline(String polyline) {
    List<LatLng> points = [];
    int index = 0, len = polyline.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = polyline.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = polyline.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return points;
  }

  void _onMapTapped(LatLng position) async {
    if (_markers.length < 2) {
      setState(() {
        _markers.add(Marker(
          markerId: MarkerId('point${_markers.length + 1}'),
          position: position,
        ));
      });

      if (_markers.length == 2) {
        final markerList = _markers.toList();
        await _drawRoute(markerList[0].position, markerList[1].position);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps Example'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              if (routePointsList.isNotEmpty) {
                // Nếu có tuyến đường đã lưu, hiển thị lại tất cả trên bản đồ
                setState(() {
                  _polylines.clear(); // Xoá các tuyến đường hiện tại trên bản đồ
                  for (int i = 0; i < routePointsList.length; i++) {
                    _polylines.add(Polyline(
                      polylineId: PolylineId('route_$i'),
                      points: routePointsList[i],
                      color: Colors.grey,
                      width: 5,
                    ));
                  }
                });
                _showRouteSelection(routePointsList);
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: (controller) {
                _mapController = controller;
              },
              initialCameraPosition: const CameraPosition(
                target: LatLng(10.762622, 106.660172), // Default location
                zoom: 10,
              ),
              markers: _markers,
              polylines: _polylines,
              onTap: _onMapTapped,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(
            RouteName.safeAreaScreen,
          );
        },
      ),
    );
  }


}
