import 'package:shortest_traffic_routes/traffic_app/models/place.dart';
import '../data_provider/place_data_provider.dart';

class PlaceRepository {
  final PlaceDataProvider dataProvider;

  PlaceRepository({required this.dataProvider});

  Future<List<Place>> search(String query) async {
    return await dataProvider.search(query);
  }
}
