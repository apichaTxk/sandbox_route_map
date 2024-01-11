import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class AddRouteMaps extends StatefulWidget {
  const AddRouteMaps({super.key});

  @override
  State<AddRouteMaps> createState() => _AddRouteMapsState();
}

class _AddRouteMapsState extends State<AddRouteMaps> {
  GoogleMapController? _controller;
  Location _location = Location();
  List<LatLng> _routePoints = [];
  bool _isPlottingRoute = true;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maps'),
        backgroundColor: Colors.blue,
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
        polylines: {
          Polyline(
            polylineId: PolylineId('route'),
            color: Colors.blue,
            points: _routePoints,
          ),
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(0.0, 0.0),
          zoom: 16,
        ),
        myLocationEnabled: true,
        onTap: (LatLng point) {
          if (_isPlottingRoute) {
            _addRoutePoint(point);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_isPlottingRoute) {
            _stopPlottingRoute();
          } else {
            _showAllRoutes();
          }
        },
        child: Icon(_isPlottingRoute ? Icons.stop : Icons.show_chart),
      ),
    );
  }

  Future<void> _getLocation() async {
    try {
      var currentLocation = await _location.getLocation();
      _controller?.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(
            currentLocation.latitude ?? 0.0,
            currentLocation.longitude ?? 0.0,
          ),
        ),
      );
    } catch (e) {
      print("Error getting current location: $e");
    }
  }

  void _addRoutePoint(LatLng point) {
    setState(() {
      _routePoints.add(point);
    });
  }

  void _stopPlottingRoute() {
    setState(() {
      _isPlottingRoute = false;
    });
  }

  void _showAllRoutes() {
    // นำ _routePoints ไปใช้ต่อตามต้องการ
    print('All routes: $_routePoints');
  }
}
