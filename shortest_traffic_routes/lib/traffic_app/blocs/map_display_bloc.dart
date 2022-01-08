import 'package:shortest_traffic_routes/traffic_app/models/mapDisplay.dart';
import 'package:shortest_traffic_routes/traffic_app/blocs/map_display_event.dart';
import 'package:shortest_traffic_routes/traffic_app/blocs/map_display_state.dart';
import 'package:shortest_traffic_routes/traffic_app/repository/map_display_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';

class MapDisplayBloc extends Bloc<MapDisplayEvent, MapDisplayState> {
  final MapDisplayRepository mapDisplayRepository;

  MapDisplayBloc({required this.mapDisplayRepository})
      : super(MapDisplayLoading());

  @override
  Stream<MapDisplayState> mapEventToState(MapDisplayEvent event) async* {
    if (event is MapDisplayLoad) {
      yield MapDisplayLoading();
      try {
        //api call
        MapDisplay mapDisplay = MapDisplay( 
          status: 'loaded', 
          mode:'driving', 
          centerLocation: LatLng(9.032902334542289, 38.56340274677532),
          startLocation: LatLng(9.032902334542289, 38.76340274677532),
          destinationLocation:LatLng(9.040441993521377, 38.76207682720006),
          bestRoute: <LatLng>[
            LatLng(9.032902334542289, 38.76340274677532),
            LatLng(9.040441993521377, 38.76207682720006),
          ]
          );

        yield MapDisplayLoadSuccess(mapDisplay);
      } catch (error) {
        yield MapDisplayLoadFailure();
      }
    }
  }
}
