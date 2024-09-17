import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/domain/constants/app_colors.dart';

class SafeAreaScreen extends StatefulWidget {
  const SafeAreaScreen({super.key});

  @override
  State<SafeAreaScreen> createState() => _SafeAreaScreenState();
}

class _SafeAreaScreenState extends State<SafeAreaScreen> {
  static final Completer<GoogleMapController> _controller = Completer();

  final Set<Polygon> _polygons = HashSet<Polygon>();
  final Set<Polyline> _polyLines = HashSet<Polyline>();

  bool _drawPolygonEnabled = false;
  List<LatLng> _userPolyLinesLatLngList = [];
  bool _clearDrawing = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _toggleDrawing() {
    _clearPolygons();
    setState(() => _drawPolygonEnabled = !_drawPolygonEnabled);
  }

  _onPanUpdate(DragUpdateDetails details) async {
    // To start draw new polygon every time.
    if (_clearDrawing) {
      _clearDrawing = false;
      _clearPolygons();
    }

    if (_drawPolygonEnabled) {
      late double x, y;
      if (Platform.isAndroid) {
        // It times in 3 without any meaning,
        // We think it's an issue with GoogleMaps package.
        x = details.globalPosition.dx * 3;
        y = details.globalPosition.dy * 3;
      } else if (Platform.isIOS) {
        x = details.globalPosition.dx;
        y = details.globalPosition.dy;
      }

      // Round the x and y.
      int xCoordinate = x.round();
      int yCoordinate = y.round();

      // Check if the distance between last point is not too far.
      // to prevent two fingers drawing.

      ScreenCoordinate screenCoordinate = ScreenCoordinate(x: xCoordinate, y: yCoordinate);

      final GoogleMapController controller = await _controller.future;
      LatLng latLng = await controller.getLatLng(screenCoordinate);

      try {
        // Add new point to list.
        _userPolyLinesLatLngList.add(latLng);

        _polyLines.removeWhere((polyline) => polyline.polylineId.value == 'user_polyline');
        _polyLines.add(
          Polyline(
            polylineId: PolylineId('user_polyline'),
            points: _userPolyLinesLatLngList,
            width: 4,
            color: Colors.blue,
          ),
        );
      } catch (e) {
        print(" error painting $e");
      }
      setState(() {});
    }
  }

  _onPanEnd(DragEndDetails details) async {
    if (_drawPolygonEnabled) {
      _polygons.removeWhere((polygon) => polygon.polygonId.value == 'user_polygon');
      _polygons.add(
        Polygon(
          polygonId: PolygonId('user_polygon'),
          points: _userPolyLinesLatLngList,
          strokeWidth: 4,
          strokeColor: Colors.blue,
          fillColor: Colors.blue.withOpacity(0.4),
        ),
      );
      setState(() {
        _clearDrawing = true;
      });
    }
  }

  _clearPolygons() {
    setState(() {
      _polyLines.clear();
      _polygons.clear();
      _userPolyLinesLatLngList.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Container(
            height: 40.w,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8.w),
              boxShadow: const <BoxShadow>[BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.08), blurRadius: 16.0, offset: Offset(0, 4))],
            ),
            child: Center(child: Text('Safe zone'))),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8.w),
              boxShadow: const <BoxShadow>[BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.08), blurRadius: 16.0, offset: Offset(0, 4))],
            ),
            child: Icon(Icons.arrow_back),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _toggleDrawing();
            },
            icon: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8.w),
                boxShadow: const <BoxShadow>[BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.08), blurRadius: 16.0, offset: Offset(0, 4))],
              ),
              child: Icon(Icons.edit),
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              // Google Map Widget
              GestureDetector(
                onPanUpdate: (_drawPolygonEnabled) ? _onPanUpdate : null,
                onPanEnd: (_drawPolygonEnabled) ? _onPanEnd : null,
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(21.030917, 105.786860),
                    zoom: 11,
                  ),
                  polygons: _polygons,
                  polylines: _polyLines,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
