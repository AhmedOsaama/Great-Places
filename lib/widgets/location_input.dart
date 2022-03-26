import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/helpers/location_helper.dart';
import 'package:great_places/screens/maps_screen.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function selectLocation;
  LocationInput(this.selectLocation);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _locationPreviewUrl = "";

  void _getLocationPreviewUrl(double lat, double long){
    String mapPreviewUrl = LocationHelper.generateLocationPreviewImage(lat, long);
    setState(() {
      _locationPreviewUrl = mapPreviewUrl;
    });
  }

  Future<void> _getCurrentLocation() async{
    final locationData =  await Location().getLocation();
    LatLng latLng = LatLng(locationData.latitude!, locationData.longitude!);
    widget.selectLocation(latLng);
    _getLocationPreviewUrl(locationData.latitude!, locationData.longitude!);
  }
  
  Future<void> _selectOnMap() async {
    final LatLng selectedLocation = await Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => MapsScreen(isSelecting: true,)));
    if(selectedLocation == null){
      return;
    }
    widget.selectLocation(selectedLocation);
    _getLocationPreviewUrl(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 250,
          alignment: Alignment.center,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: _locationPreviewUrl.isEmpty ? Text("No Location Chosen",) : Image.network(_locationPreviewUrl,fit: BoxFit.cover,width: double.infinity,),
        ),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(onPressed: _getCurrentLocation, icon: Icon(Icons.location_on), label: Text("Current Location")),
            FlatButton.icon(onPressed: _selectOnMap, icon: Icon(Icons.map), label: Text("Select on Map")),
          ],
        )
      ]
    );
  }
}
