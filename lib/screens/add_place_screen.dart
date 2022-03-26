import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/models/place.dart';
import 'package:great_places/providers/places.dart';
import 'package:great_places/widgets/image_input.dart';
import 'package:great_places/widgets/location_input.dart';
import 'package:provider/provider.dart';

class AddPlacesScreen extends StatefulWidget {
  static const routeName = '/add-place';

  @override
  _AddPlacesScreenState createState() => _AddPlacesScreenState();
}

class _AddPlacesScreenState extends State<AddPlacesScreen> {
  TextEditingController textEditingController = TextEditingController();
  File? pickedImage;
  LatLng? _pickedLocation;

  void _selectImage(File pickedImage){
    this.pickedImage = pickedImage;
  }

  void _selectLocation(LatLng location){
    _pickedLocation = location;
  }

  void _savePlace(){
    if(textEditingController.text.isEmpty || pickedImage == null || _pickedLocation == null) return;
    Provider.of<Places>(context,listen: false).addPlace(textEditingController.text, pickedImage!,_pickedLocation!);
    Navigator.of(context).pop();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a Place"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  TextField(
                    controller: textEditingController,
                    decoration: InputDecoration(labelText: "Title"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ImageInput(_selectImage),
                  ),
                  LocationInput(_selectLocation),
                ],
              ),
            ),
          ),
          RaisedButton.icon(
            onPressed: _savePlace,
            icon: Icon(Icons.add),
            label: Text("Add Place"),
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).accentColor,
          )
        ],
      ),
    );
  }
}
