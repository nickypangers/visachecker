import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:visachecker/common/credentials/mapbox.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapBoxCredentails mapBoxCredentails = MapBoxCredentails();

  MapboxMapController? mapController;

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MapboxMap(
      accessToken: mapBoxCredentails.publicToken,
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: LatLng(0, 0),
        zoom: 10.0,
      ),
      styleString: mapBoxCredentails.styleString,
    );
  }
}
