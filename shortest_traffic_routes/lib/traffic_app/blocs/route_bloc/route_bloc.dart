import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shortest_traffic_routes/traffic_app/blocs/route_bloc/route_event.dart';
import 'package:shortest_traffic_routes/traffic_app/blocs/route_bloc/route_state.dart';
import '../../repository/route_repository.dart';

class RouteBloc extends Bloc<RouteEvent, RouteState> {
  final RouteRepository routeRepository;

  RouteBloc({required this.routeRepository}) : super(RouteInitial()) {
    on<ShowRoute>(_showRoute);
  }
  // implementation for the event to load map
  Future<void> _showRoute(ShowRoute event, Emitter<RouteState> emit) async {
    emit(RouteLoading());
    try {
      var mapDisplay = await routeRepository.showRoute(
          event.startLocation, event.destination, event.mode);
      emit(RouteSuccess(mapDisplay: mapDisplay));
    } catch (e) {
      // emit(const RouteFailure(
      //     message: "Network error please try again."));
      emit(RouteFailure(message: e.toString()));
    }
  }
}
