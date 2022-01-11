import 'package:shortest_traffic_routes/traffic_app/models/mapDisplay.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

abstract class MapDisplayEvent extends Equatable {
  const MapDisplayEvent();
}

class MapDisplayLoad extends MapDisplayEvent {

  const MapDisplayLoad();

  @override
  List<Object> get props => [];
}
