import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

abstract class RouteEvent extends Equatable {
  const RouteEvent();
}

class ShowRoute extends RouteEvent {
  final LatLng startLocation;
  final LatLng destination;
  final String mode;

  const ShowRoute({required this.startLocation, required this.destination, required this.mode});

  @override
  List<Object> get props => [startLocation, destination, mode];
}
