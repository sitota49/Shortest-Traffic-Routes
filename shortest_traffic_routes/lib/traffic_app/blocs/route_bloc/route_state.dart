import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';
import 'package:shortest_traffic_routes/traffic_app/models/map_display.dart';

class RouteState extends Equatable {
  const RouteState();

  @override
  List<Object> get props => [];
}

class RouteInitial extends RouteState {}

class RouteLoading extends RouteState {}

class RouteSuccess extends RouteState {
  final  MapDisplay mapDisplay;
  const RouteSuccess({required this.mapDisplay});

  @override
  List<Object> get props => [mapDisplay];
}

class RouteFailure extends RouteState {
  final String message;
  const RouteFailure({required this.message});

  @override
  List<Object> get props => [message];
}
