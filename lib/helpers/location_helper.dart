import 'package:http/http.dart' as http;
import 'dart:convert';

const MAPS_API_KEY = '-------------------------------------';

class LocationHelper {
  static String generateLocationPreviewImage(
      double latitude, double longitude) {
    // return "https://maps.googleapis.com/maps/api/staticmap?center=Brooklyn+Bridge,New+York,NY&zoom=13&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:S%7C40.702147,-74.015794&markers=color:green%7Clabel:G%7C40.711614,-74.012318&markers=color:red%7Clabel:C%7C40.718217,-73.998284&key=$MAPS_API_KEY";
    return "https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=13&size=600x500&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=$MAPS_API_KEY";
  }

  static Future<String> getLatLongAddress(
      double latitude, double longitude) async {
    final url = Uri.parse(
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$MAPS_API_KEY");
    try {
        final response = await http.get(url);
        final result = json.decode(response.body);
        return result['results'][0]['formatted_address'];
    } catch (error) {
        throw error;
    }
  }
}
