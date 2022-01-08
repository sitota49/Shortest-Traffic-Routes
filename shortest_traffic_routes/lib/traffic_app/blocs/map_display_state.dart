import 'package:shortest_traffic_routes/traffic_app/models/mapDisplay.dart';
import 'package:equatable/equatable.dart';

class MapDisplayState extends Equatable {
  const MapDisplayState();

  @override
  List<Object> get props => [];
}

class MapDisplayLoading extends MapDisplayState {}

class MapDisplayLoadSuccess extends MapDisplayState {
  final MapDisplay mapDisplay;

  const MapDisplayLoadSuccess(this.mapDisplay);


  @override
  List<Object> get props => [mapDisplay];
}

class MapDisplayLoadFailure extends MapDisplayState {
 const  MapDisplayLoadFailure();

  @override
  List<Object> get props => [];
}

