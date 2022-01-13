import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shortest_traffic_routes/traffic_app/models/map_display.dart';
import 'package:latlong2/latlong.dart';

class RouteDataProvider {
  final http.Client httpClient;
  // final _baseurl = 'photon.komoot.io/api/?q=';
  final _baseUrl = '192.168.0.8:8000';
  RouteDataProvider({required this.httpClient});

  Future<MapDisplay> showRoute(
      LatLng startLocation, LatLng destination, String mode) async {
    try {
      final response = await httpClient.post(Uri.http(_baseUrl, '/mainapp/'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(<String, dynamic>{
            "startLocation": [9.0377861, 38.7626389],
            "destination": [9.0355672, 38.7522876],
            'mode': "walking",
          }));

      if (response.statusCode == 200) {
        Iterable points = jsonDecode(response.body)['bestRoute'];
        List<LatLng> newPoints =
            List<LatLng>.from(points.map((e) => LatLng(e[0], e[1])));
        return MapDisplay(mode: mode, bestRoute: newPoints);
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
