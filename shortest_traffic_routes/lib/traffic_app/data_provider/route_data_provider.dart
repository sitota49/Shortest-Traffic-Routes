import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shortest_traffic_routes/traffic_app/models/map_display.dart';
import 'package:latlong2/latlong.dart';

class RouteDataProvider {
  final http.Client httpClient;
  // final _baseurl = 'photon.komoot.io/api/?q=';
  final _baseUrl = '192.168.0.6:8000';
  RouteDataProvider({required this.httpClient});

  Future<MapDisplay> showRoute(
      LatLng startLocation, LatLng destination, String mode) async {
    try {
      final response = await httpClient.post(Uri.http(_baseUrl, '/mainapp/'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(<String, dynamic>{
            "startLocation": [startLocation.latitude, startLocation.longitude],
            "destination": [destination.latitude, destination.longitude],
            'mode': mode,
          }));

      if (response.statusCode == 200) {
        Iterable points = jsonDecode(response.body)['bestRoute'];
        List<LatLng> newPoints =
            List<LatLng>.from(points.map((e) => LatLng(e[0], e[1])));
        return MapDisplay(mode: mode, bestRoute: newPoints);
      } else {
        throw Exception("Network error. please try again.");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
