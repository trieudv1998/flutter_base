import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/domain/enum/load_status.dart';
import 'package:flutter_base/presentation/pages/home/cubit/home_cubit.dart';
import 'package:flutter_base/presentation/routes/route_name.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeCubit _homeCubit;
  CancelToken? _cancelToken;
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(21.030797, 105.786903);

  @override
  void initState() {
    super.initState();
    _cancelToken = CancelToken();
    _homeCubit = BlocProvider.of<HomeCubit>(context);
  }

  @override
  void dispose() {
    super.dispose();
    _cancelToken?.cancel();
    _cancelToken = null;
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        compassEnabled: true,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        zoomControlsEnabled: false,
        zoomGesturesEnabled: true,
        mapType: MapType.normal,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,

        ),
      )
    );
  }
}
