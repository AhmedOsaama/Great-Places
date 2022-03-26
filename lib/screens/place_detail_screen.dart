import 'package:flutter/material.dart';
import 'package:great_places/screens/maps_screen.dart';
import 'package:provider/provider.dart';
import '../models/place.dart';
import '../providers/places.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = '/place-detail';
  @override
  Widget build(BuildContext context) {
    String id = ModalRoute.of(context)!.settings.arguments as String;
    Place place = Provider.of<Places>(context).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Column(
        children: [
          Container(width: double.infinity,height: 300,child: Image.file(place.image,fit: BoxFit.cover,),),
          SizedBox(height: 10,),
          Text(place.location!.address!),
          FlatButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => MapsScreen(
                            initialLocation: Location(
                                latitude: place.location!.latitude,
                                longitude: place.location!.longitude),
                          ))),
              child: Text("View on Map"))
        ],
      ),
    );
  }
}
