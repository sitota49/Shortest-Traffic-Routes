import 'package:latlong2/latlong.dart';
import 'package:shortest_traffic_routes/traffic_app/models/map_display.dart';
import '../data_provider/route_data_provider.dart';

class RouteRepository {
  final RouteDataProvider dataProvider;

  RouteRepository({required this.dataProvider});

  Future<MapDisplay> showRoute(LatLng startLoaction, LatLng destination, String mode) async {
    return await dataProvider.showRoute(startLoaction, destination, mode);
  }
}
