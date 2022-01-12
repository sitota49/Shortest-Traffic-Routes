import 'package:shortest_traffic_routes/traffic_app/models/map_display.dart';
import 'package:shortest_traffic_routes/traffic_app/data_provider/map_display_data_provider.dart';

class MapDisplayRepository {
  final MapDisplayDataProvider dataProvider;

  MapDisplayRepository({required this.dataProvider});

  Future<MapDisplay> getMapDisplay() async {
    return await dataProvider.getMapDisplay();
  }
}
