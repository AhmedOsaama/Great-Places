import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/helpers/location_helper.dart';
import '../helpers/db_helper.dart';
import '../models/place.dart';

class Places with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findById(String id){
    return _items.firstWhere((place) => place.id == id);
  }

  Future<void> addPlace(
      String title, File pickedImage, LatLng pickedLocation) async {
    final address = await LocationHelper.getLatLongAddress(
        pickedLocation.latitude, pickedLocation.longitude);
    Location location = Location(
        latitude: pickedLocation.latitude,
        longitude: pickedLocation.longitude,
        address: address);
    Place place = Place(
        id: DateTime.now().toString(),
        title: title,
        image: pickedImage,
        location: location);

    _items.add(place);
    DBhelper.insert('places', {
      'id': place.id,
      'title': place.title,
      'image': place.image.path,
      'loc_lat': place.location!.latitude,
      'loc_long': place.location!.longitude,
      'address': place.location!.address,
    });
    notifyListeners();
  }

  Future<void> fetchPlaces() async {
    List<Map<String, dynamic>> dataList = await DBhelper.getData('places');
    _items = dataList
        .map((place) => Place(
            id: place['id'],
            title: place['title'],
            image: File(place['image']),
            location: Location(
                address: place['address'],
                latitude: place['loc_lat'],
                longitude: place['loc_long'])
    ))
        .toList();
    notifyListeners();
  }
}
