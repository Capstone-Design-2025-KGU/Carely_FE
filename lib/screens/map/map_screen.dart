import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPages extends StatefulWidget {
  static String id = 'map-page';
  const MapPages({super.key});

  @override
  State<MapPages> createState() => _MapPagesState();
}

class _MapPagesState extends State<MapPages> {
  static const LatLng _Seoul = LatLng(37.5665, 126.9780);
  static const LatLng _Seoul1 = LatLng(37.5651, 126.9895);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(target: _Seoul, zoom: 14),
        markers: {
          const Marker(
            markerId: MarkerId('_currentLocation'),
            icon: BitmapDescriptor.defaultMarker,
            position: _Seoul,
          ),
        },
      ),
    );
  }
}
