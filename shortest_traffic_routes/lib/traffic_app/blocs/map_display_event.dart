import 'package:equatable/equatable.dart';

abstract class MapDisplayEvent extends Equatable {
  const MapDisplayEvent();
}

class MapDisplayLoad extends MapDisplayEvent {

  const MapDisplayLoad();

  @override
  List<Object> get props => [];
}
