import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:shortest_traffic_routes/traffic_app/models/map_display.dart';
import 'package:shortest_traffic_routes/traffic_app/blocs/map_display_state.dart';
import 'package:shortest_traffic_routes/traffic_app/blocs/map_display_event.dart';
import 'package:shortest_traffic_routes/traffic_app/repository/map_display_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class MapDisplayBloc extends Bloc<MapDisplayEvent, MapDisplayState> {
  final MapDisplayRepository mapDisplayRepository;

  MapDisplayBloc({required this.mapDisplayRepository})
      : super(MapDisplayLoading()) {
    on<MapDisplayLoad>(_mapDisplayLoad);
  }

  // implementation for the event to load map
  Future<void> _mapDisplayLoad(
      MapDisplayLoad event, Emitter<MapDisplayState> emit) async {
    emit(MapDisplayLoading());
    try {
      //api call
      var location = Location();
      var currentLocation = await location.getLocation();

      var currentMarker = Marker(
          width: 80.0,
          height: 80.0,
          rotate: true,
          point: LatLng(currentLocation.latitude!, currentLocation.longitude!),
          builder: (ctx) => const Icon(
                Icons.location_pin,
                color: Colors.blue,
                size: 30,
              ),
          anchorPos: AnchorPos.align(AnchorAlign.center));

      MapDisplay mapDisplay = MapDisplay(
          status: 'loaded',
          mode: 'driving',
          centerLocation:
              LatLng(currentLocation.latitude!, currentLocation.longitude!),
          startLocation: LatLng(9.032902334542289, 38.76340274677532),
          destinationLocation: LatLng(9.040441993521377, 38.76207682720006),
          bestRoute: <LatLng>[
            LatLng(9.032902334542289, 38.76340274677532),
            LatLng(9.040441993521377, 38.76207682720006),
          ],
          markers: [
            currentMarker
          ]);

      emit(MapDisplayLoadSuccess(mapDisplay));
    } catch (e) {
      emit(MapDisplayLoadFailure(message: e.toString()));
    }
  }
}
