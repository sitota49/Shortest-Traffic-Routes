import 'package:shortest_traffic_routes/traffic_app/models/mapDisplay.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
abstract class MapDisplayEvent extends Equatable {
  const MapDisplayEvent();
}


class MapDisplayLoad extends MapDisplayEvent {
  final String? status;
  final String? mode;
  final LatLng? centerLocation;
  final LatLng? startLocation;
  final LatLng? destinationLocation;
  final List<LatLng>? bestRoute;
  const MapDisplayLoad(this.status, this.mode, this.centerLocation, this.startLocation, this.destinationLocation, this.bestRoute);

  @override
  List<Object> get props => [];
}
