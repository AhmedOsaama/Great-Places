import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/place.dart';

class MapsScreen extends StatefulWidget {
  final Location initialLocation;
  final bool isSelecting;

  MapsScreen({this.initialLocation = const Location(latitude: 37.422, longitude: -122.324),this.isSelecting = false});

  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  LatLng? _pickedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Maps"),
        actions: [
          IconButton(onPressed: _pickedLocation != null ? () => Navigator.of(context).pop(_pickedLocation) : null, icon: Icon(Icons.check)),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
              widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
              zoom: 16,
        ),
        onTap: widget.isSelecting ? (position) {
          setState(() {
            _pickedLocation = position;
          });
        } : null,
        markers: _pickedLocation != null ? { Marker(markerId: MarkerId('m1'),position: _pickedLocation!) } : {Marker(markerId: MarkerId('m2'),position: LatLng( widget.initialLocation.latitude, widget.initialLocation.longitude))},
      ),
    );
  }
}
