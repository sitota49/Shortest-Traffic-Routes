import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

// event======================
abstract class MarkerEvent extends Equatable {
  const MarkerEvent();
}

class MarkerChanged extends MarkerEvent {
  final LatLng place;

  const MarkerChanged({required this.place});

  @override
  List<Object> get props => [place];
}

// state==========================
abstract class MarkerState extends Equatable {
  const MarkerState();

  @override
  List<Object> get props => [];
}

class MarkerInitial extends MarkerState {}

class MarkerChangedSuccess extends MarkerState {
  final Marker marker;
  const MarkerChangedSuccess({required this.marker});

  @override
  List<Object> get props => [marker];
}

// bloc================================

class MarkerBloc extends Bloc<MarkerEvent, MarkerState> {
  MarkerBloc() : super(MarkerInitial()) {
    on<MarkerChanged>(_addMarker);
  }
  // implementation for the event to load map
  Future<void> _addMarker(
      MarkerChanged event, Emitter<MarkerState> emit) async {
    var destinationMarker = Marker(
        width: 80.0,
        height: 80.0,
        rotate: true,
        point: event.place,
        builder: (ctx) => const Icon(
              Icons.location_pin,
              color: Color.fromARGB(255, 98, 233, 102),
              size: 45,
            ),
        anchorPos: AnchorPos.align(AnchorAlign.center));

    emit(MarkerChangedSuccess(marker: destinationMarker));
  }
}
