import 'dart:convert';

import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

class Location {
  final String name;
  final String lat;
  final String log;
  Location({required this.name, required this.lat, required this.log});
}

final location = loc.Location();

Future<Location?> getLocation() async {
  final status = await Permission.location.status;
  if (status.isDenied) {
    await Permission.location.request();
  } else {
    final locationData = await location.getLocation();

    print(locationData.latitude);
    print(locationData.longitude);

    final placeMarks = await placemarkFromCoordinates(
        double.parse(locationData.latitude.toString()),
        double.parse(locationData.longitude.toString()));

    print(placeMarks[3].name);
    return Location(
        name: placeMarks[3].name.toString(),
        lat: locationData.latitude.toString(),
        log: locationData.longitude.toString());
  }
  return Location(name: 'Cairo', lat: '30.3481899', log: '31.7624285');
}

Future<Location> getNamedLocation(String cityName) async {
  Uri url = Uri.parse(
      'https://raw.githubusercontent.com/dr5hn/countries-states-cities-database/master/cities.json');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final responseData = json.decode(response.body) as List;
    for (int i = 0; i < responseData.length; i++) {
      if (responseData[i]['name'].toString().toLowerCase() == cityName) {
        return Location(
            name: responseData[i]['name'].toString(),
            lat: responseData[i]['latitude'].toString(),
            log: responseData[i]['longitude'].toString());
      }
    }
  }

  return Location(name: 'Egypt', lat: '30.3481899', log: '31.7624285');
}
