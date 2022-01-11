import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

@immutable
class Place extends Equatable {
  const Place(
      {required this.name, this.country, this.latlng, this.state});

  final String? name;
  final String? state;
  final String? country;
  final LatLng? latlng;

  @override
  List<Object?> get props => [
        name,
        state,
        country,
        latlng
      ];

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
        name: json['properties']['name'],
        country: json['properties']['country'],
        state: json['properties']['state'],
        latlng: LatLng(json["geometry"]["coordinates"][1], json["geometry"]["coordinates"][0]));
  }
}
