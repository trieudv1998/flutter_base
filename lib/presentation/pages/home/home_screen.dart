import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
  Polyline? _polyline;

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
      _addMarkersAndPolyline();
    }
    setState(() {});
  }

  void _addMarkersAndPolyline() {
    if (mapPoints != null && mapPoints!.length >= 2) {
      for (var i = 0; i < mapPoints!.length; i++) {
        _markers.add(Marker(
          markerId: MarkerId('point${i + 1}'),
          position: LatLng(mapPoints![i]['lat']!, mapPoints![i]['lon']!),
        ));
      }
      _polyline = Polyline(
        polylineId: PolylineId('route'),
        points: mapPoints!.map((point) => LatLng(point['lat']!, point['lon']!)).toList(),
        color: Colors.blue,
        width: 5,
      );
    }
  }

  void _onMapTapped(LatLng position) async {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId('point${_markers.length + 1}'),
        position: position,
      ));
    });

    final markerList = _markers.toList();
    final pointsList = markerList.map((marker) => {
      'lat': marker.position.latitude,
      'lon': marker.position.longitude,
    }).toList();

    await SharedPreferencesHelper.savePointsList(pointsList);
    _addMarkersAndPolyline();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              polylines: _polyline != null ? {_polyline!} : {},
              onTap: _onMapTapped,
            ),
          ),
          if (mapPoints != null)
            Expanded(
              child: ListView.builder(
                itemCount: mapPoints!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      'Point ${index + 1}: (${mapPoints![index]['lat']}, ${mapPoints![index]['lon']})',
                    ),
                  );
                },
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
