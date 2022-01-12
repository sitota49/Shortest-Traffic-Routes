import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:shortest_traffic_routes/traffic_app/blocs/map_display_bloc.dart';
import 'package:shortest_traffic_routes/traffic_app/blocs/marker_bloc_event_state.dart';
import '../blocs/map_display_state.dart';
import 'component/current_location.dart';
import 'component/destination_search_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final MapController mapController;
  List<Marker> markers = [];
  bool routeShown = false;

  @override
  Widget build(BuildContext context) {
    var destinationSearchBar = DestinationSearchBar(
      mapController: mapController,
    );
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(title: const Text('Best Route calculator')),
        body: BlocListener<MarkerBloc, MarkerState>(
          listener: (context, state) {
            if (state is MarkerChangedSuccess) {
              setState(() {
                if (markers.length > 1) {
                  markers.remove(markers.last);
                }
                markers.add(state.marker);
              });
            }
          },
          child: Stack(
            children: <Widget>[
              BlocBuilder<MapDisplayBloc, MapDisplayState>(
                builder: (context, state) {
                  if (state is MapDisplayLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is MapDisplayLoadFailure) {
                    return Center(
                      child: Column(
                        children: [
                          const Icon(Icons.face),
                          Text(state.message),
                        ],
                      ),
                    );
                  } else if (state is MapDisplayLoadSuccess) {
                    markers = state.mapDisplay.markers;
                    return FlutterMap(
                      mapController: mapController,
                      options: MapOptions(
                        maxZoom: 18,
                        center: state.mapDisplay.centerLocation,
                        zoom: 16,
                      ),
                      layers: [
                        TileLayerOptions(
                            urlTemplate:
                                'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                            subdomains: ['a', 'b', 'c']),
                        // PolylineLayerOptions(
                        //   polylines: [
                        //     Polyline(
                        //         points: points, strokeWidth: 4.0, color: Colors.blue),
                        //   ],
                        // ),
                        MarkerLayerOptions(markers: markers)
                      ],
                    );
                  }
                  return Container();
                },
              ),
              Positioned(child: destinationSearchBar),

              // walking mode and driving mode ============================
              Positioned(
                bottom: 15,
                left: 15,
                child: Column(
                  children: [
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: FloatingActionButton(
                        child: const Icon(Icons.directions_walk),
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: FloatingActionButton(
                        child: const Icon(Icons.directions_car),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),

              // current location and show route===============================
              Positioned(
                bottom: 15,
                right: 15,
                child: Column(
                  children: [
                    CurrentLocation(mapController: mapController),
                    const SizedBox(
                      height: 10,
                    ),
                    (routeShown)
                    ? SizedBox(
                      width: 40,
                      height: 40,
                      child: FloatingActionButton(
                        child: const Icon(
                          Icons.cancel,
                          color: Colors.red,
                        ),
                        onPressed: () {},
                      ),
                    )
                    : const SizedBox(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  @override
  void dispose() {
    BlocProvider.of<MapDisplayBloc>(context).close();
    super.dispose();
  }
}
