import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SafeAreaScreen extends StatefulWidget {
  const SafeAreaScreen({super.key});

  @override
  State<SafeAreaScreen> createState() => _SafeAreaScreenState();
}

class _SafeAreaScreenState extends State<SafeAreaScreen> {
  late GoogleMapController mapController;

  List<Map<String, double>>? mapPoints;
  GoogleMapController? _mapController;

  bool isDrawing = false;
  List<Polygon> polygons = [];
  List<Offset> points = []; // List of points in Offset

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Converts List<Offset> to List<LatLng>
  Future<List<LatLng>> _convertOffsetsToLatLngs() async {
    List<LatLng> latLngs = [];
    if (_mapController == null) return latLngs;

    for (Offset offset in points) {
      ScreenCoordinate screenCoordinate = ScreenCoordinate(
        x: offset.dx.toInt(),
        y: offset.dy.toInt(),
      );

      // Convert screen coordinates to LatLng
      LatLng latLng = await _mapController!.getLatLng(screenCoordinate);
      latLngs.add(latLng);
    }
    return latLngs;
  }

  // Add polygon to Google Map using converted LatLng points
  Future<void> _addPolygon() async {
    if (points.isEmpty || _mapController == null) return;

    List<LatLng> latLngs = await _convertOffsetsToLatLngs();
    setState(() {
      polygons.add(Polygon(
        polygonId: PolygonId('polygon_${polygons.length}'),
        points: latLngs,
        strokeColor: Colors.blue,
        fillColor: Colors.blue.withOpacity(0.3),
        strokeWidth: 4,
      ));

      points.clear(); // Clear the points after adding the polygon
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Google Map Widget
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(21.030817, 105.786882),
              zoom: 11,
            ),
            polygons: Set.from(polygons),
            onMapCreated: (controller) {
              _mapController = controller;
            },
          ),

          // Draw Polygon on top of the map
          if (isDrawing)
            GestureDetector(
              onPanStart: (details) {
                setState(() {
                  points = [details.localPosition];
                });
              },
              onPanUpdate: (details) {
                setState(() {
                  points.add(details.localPosition);
                });
              },
              onPanEnd: (details) {
                setState(() {
                  points.add(points.first); // Close the polygon
                  isDrawing = false;
                });
                _addPolygon(); // Add the polygon to the map
              },
              child: CustomPaint(
                painter: PolygonPainter(points),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed: () {
          setState(() {
            isDrawing = true;
          });
        },
      ),

    );
  }
}

// Custom Painter to display polygon drawing on screen
class PolygonPainter extends CustomPainter {
  final List<Offset> points;

  PolygonPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) return;

    Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    Path path = Path()..moveTo(points[0].dx, points[0].dy);
    for (var point in points) {
      path.lineTo(point.dx, point.dy);
    }
    path.close(); // Close the path to form the polygon
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
