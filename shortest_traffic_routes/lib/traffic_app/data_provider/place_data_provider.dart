import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shortest_traffic_routes/traffic_app/models/place.dart';

class PlaceDataProvider {
  final http.Client httpClient;
  // final _baseurl = 'photon.komoot.io/api/?q=';
  // final _baseurl= 'localhost:3000';
  PlaceDataProvider({required this.httpClient});

  Future<List<Place>> search(String query) async {
    try {
      // final response = await httpClient.get(Uri.http(_baseurl, query));
      var url = Uri.https('photon.komoot.io', '/api/',{'q': query});
      final response = await httpClient.get(url);
      if (response.statusCode == 200) {
        Iterable jsonData = jsonDecode(response.body)['features'];
        var searchResults =
            List<Place>.from(jsonData.map((place) => Place.fromJson(place)));
        return searchResults;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
