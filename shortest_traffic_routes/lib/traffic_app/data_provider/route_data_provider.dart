import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shortest_traffic_routes/traffic_app/models/map_display.dart';
import 'package:shortest_traffic_routes/traffic_app/models/place.dart';
import 'package:latlong2/latlong.dart';

class RouteDataProvider {
  final http.Client httpClient;
  // final _baseurl = 'photon.komoot.io/api/?q=';
  // final _baseurl= 'localhost:3000';
  RouteDataProvider({required this.httpClient});

  Future<MapDisplay> showRoute(LatLng startLocation, LatLng destination, String mode) async {
    try {
      // final response = await httpClient.get(Uri.http(_baseurl, query));
      // var url = Uri.https('photon.komoot.io', '/api/',{'q': query});
      // final response = await httpClient.get(url);
      // if (response.statusCode == 200) {
      //   Iterable jsonData = jsonDecode(response.body)['features'];
      //   var searchResults =
      //       List<LatLng>.from(jsonData.map((place) => Place.fromJson(place)));
      //   return searchResults;
      // } else {
      //   throw Exception("Error");
      // }

      Iterable points = [
        [38.7626389, 9.0377861],
        [38.7624508, 9.0377725],
        [38.7616172, 9.0377121],
        [38.7608394, 9.0373362],
        [38.760522, 9.0371828],
        [38.7601264, 9.0369917],
        [38.7595774, 9.0367257],
        [38.7593513, 9.036622],
        [38.7586829, 9.0362997],
        [38.7584708, 9.0362069],
        [38.7583249, 9.0361352],
        [38.7581953, 9.0360799],
        [38.7579433, 9.0363507],
        [38.7579218, 9.0363738],
        [38.7576969, 9.0366163],
        [38.7575773, 9.0367665],
        [38.7574264, 9.0369881],
        [38.7573516, 9.0371314],
        [38.7572541, 9.0373729],
        [38.7569806, 9.0383247],
        [38.7568626, 9.0387766],
        [38.7568306, 9.0389068],
        [38.7568231, 9.0389364],
        [38.756776, 9.0391218],
        [38.7567133, 9.0393114],
        [38.7566549, 9.0394528],
        [38.7566046, 9.0395498],
        [38.7565216, 9.0396485],
        [38.7563609, 9.0397478],
        [38.7562519, 9.0397962],
        [38.7561246, 9.039814],
        [38.7560172, 9.0398121],
        [38.7559159, 9.0397791],
        [38.7558295, 9.039722],
        [38.7557597, 9.0396386],
        [38.7556678, 9.0394946],
        [38.7556082, 9.0393723],
        [38.7555191, 9.0390861],
        [38.7554902, 9.0389457],
        [38.7554435, 9.0386175],
        [38.7554272, 9.0383803],
        [38.7554413, 9.0382186],
        [38.7554674, 9.0381213],
        [38.7555256, 9.038],
        [38.7553658, 9.0378925],
        [38.7549918, 9.0376407],
        [38.754862, 9.0375543],
        [38.7546729, 9.0374256],
        [38.7540752, 9.0370188],
        [38.7537959, 9.0368298],
        [38.7537438, 9.0367861],
        [38.7535757, 9.0366681],
        [38.7534956, 9.0366147],
        [38.7530467, 9.0363154],
        [38.7526249, 9.0360341],
        [38.7525769, 9.0360652],
        [38.7524978, 9.0361028],
        [38.7524196, 9.0361154],
        [38.7523409, 9.0361067],
        [38.7522674, 9.0360774],
        [38.752215, 9.0360395],
        [38.7521724, 9.0359911],
        [38.7521417, 9.0359347],
        [38.7521305, 9.035911],
        [38.7521211, 9.0358133],
        [38.7521303, 9.0357544],
        [38.7521516, 9.0356987],
        [38.7521799, 9.0356536],
        [38.7522162, 9.0356145],
        [38.7522876, 9.0355672]
      ];
      List<LatLng> newPoints = List<LatLng>.from(points.map((e) => LatLng(e[1], e[0])));
      return MapDisplay(mode: mode, bestRoute: newPoints);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
