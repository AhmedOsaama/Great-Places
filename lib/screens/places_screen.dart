import 'package:flutter/material.dart';
import 'package:great_places/providers/places.dart';
import 'package:great_places/screens/add_place_screen.dart';
import 'package:great_places/screens/place_detail_screen.dart';
import 'package:provider/provider.dart';

class PlacesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Great Places"),
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, AddPlacesScreen.routeName),
              icon: Icon(Icons.add)),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<Places>(context, listen: false).fetchPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<Places>(
                child: Center(child: Text("Got no places yet, add some!")),
                builder: (ctx, places, ch) => places.items.length <= 0
                    ? ch!
                    : ListView.builder(
                        itemCount: places.items.length,
                        itemBuilder: (ctx, i) => ListTile(
                            leading: CircleAvatar(
                              backgroundImage: FileImage(places.items[i].image),
                            ),
                            title: Text(places.items[i].title),
                            subtitle: Text(places.items[i].location!.address!),
                            onTap: () => Navigator.of(context).pushNamed(
                                PlaceDetailScreen.routeName,
                                arguments: places.items[i].id)))),
      ),
    );
  }
}
