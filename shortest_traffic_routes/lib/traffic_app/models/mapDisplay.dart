//category model
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

@immutable
class MapDisplay extends Equatable {
  const MapDisplay({
    this.status,
    this.mode,
    this.centerLocation,
    this.startLocation,
    this.destinationLocation,
    this.bestRoute,

  });

  final String? status;
  final String? mode;
  final LatLng? centerLocation;
  final LatLng? startLocation;
  final LatLng? destinationLocation;
  final List<LatLng>? bestRoute;

  List<Object?> get props =>
      [status, mode, centerLocation, startLocation, destinationLocation, bestRoute];

  factory MapDisplay.fromJson(Map<String, dynamic> json) {
    return MapDisplay(
        status:json['status'],
        mode: json['mode'],
        centerLocation: json['centerLocation'],
        startLocation: json['startLocation'],
        destinationLocation: json['destinationLocation'],
        bestRoute: json['bestRoute']
    );
  }
}
