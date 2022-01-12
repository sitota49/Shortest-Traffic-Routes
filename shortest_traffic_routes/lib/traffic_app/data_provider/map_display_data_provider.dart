import 'dart:convert';
import 'dart:io';
import 'package:shortest_traffic_routes/traffic_app/models/map_display.dart';

import 'package:http/http.dart' as http;

class MapDisplayDataProvider {
  final http.Client httpClient;
  final _baseurl = '10.0.2.2:3000';
  // final _baseurl= 'localhost:3000';
  MapDisplayDataProvider({required this.httpClient});

  Future<MapDisplay> getMapDisplay() async {
    try {
      final response = await httpClient.get(Uri.http(_baseurl, "/map_display"));

      if (response.statusCode == 200) {
        final mapDisplay = jsonDecode(response.body);
        return MapDisplay.fromJson(mapDisplay);
      } else {
        throw Exception("Error");
      }
    } on SocketException catch (_) {
      rethrow;
    } on HttpException catch (_) {
      rethrow;
    }
  }

  // Future<Category> getCategoryById(String category_id) async {
  //   final response =
  //       await httpClient.get(Uri(path: '$_baseUrl/Category/${category_id}'));

  //   if (response.statusCode == 200) {
  //     final Category = jsonDecode(response.body);
  //     return Category.fromJson(Category);
  //   } else {
  //     throw Exception('Failed to load Category by Id');
  //   }
  // }
}
