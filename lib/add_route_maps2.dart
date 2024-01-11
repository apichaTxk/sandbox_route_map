import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddRouteMaps2 extends StatefulWidget {
  const AddRouteMaps2({super.key});

  @override
  State<AddRouteMaps2> createState() => _AddRouteMaps2State();
}

class _AddRouteMaps2State extends State<AddRouteMaps2> {
  GoogleMapController? _mapController;
  Position? _currentPosition;
  List<LatLng> _routePoints = [
    LatLng(13.938500, 100.516884),
    LatLng(13.938535, 100.517135),
    LatLng(13.938565, 100.517307),
    LatLng(13.938584, 100.517476),
    LatLng(13.938600, 100.517615),
    LatLng(13.938611, 100.517710),
    LatLng(13.938597, 100.517747),
    LatLng(13.938568, 100.517755),
    LatLng(13.938534, 100.517765),
    LatLng(13.938501, 100.517776),
    LatLng(13.938469, 100.517785),
    LatLng(13.938415, 100.517808),
  ];
  bool _routingMap = false;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_routingMap ? 'Recording' : 'Maps 2'),
        backgroundColor: _routingMap ? Colors.yellow : Colors.blue,
      ),
      body: _currentPosition == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      _currentPosition?.latitude ?? 0.0,
                      _currentPosition?.longitude ?? 0.0,
                    ),
                    zoom: 17.0,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    setState(() {
                      _mapController = controller;
                    });
                  },
                  myLocationEnabled: true,
                  polylines: {
                    Polyline(
                      polylineId: PolylineId('route'),
                      color: Colors.blue,
                      points: _routePoints,
                    ),
                  },
                ),
                Positioned(
                  bottom: 16.0,
                  left: 16.0,
                  child: Row(
                    children: [
                      FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            _routingMap = !_routingMap;
                          });
                        },
                        backgroundColor: _routingMap ? Colors.red : Colors.blue,
                        child: Icon(
                          _routingMap ? Icons.close : Icons.route,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  void _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      _currentPosition = position;
    });
  }
}
