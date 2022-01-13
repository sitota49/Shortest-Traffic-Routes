import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:location/location.dart';
import 'package:shortest_traffic_routes/traffic_app/blocs/map_display_bloc.dart';
import 'package:shortest_traffic_routes/traffic_app/blocs/marker_bloc_event_state.dart';
import 'package:shortest_traffic_routes/traffic_app/blocs/route_bloc/route_event.dart';
import '../blocs/map_display_state.dart';
import '../blocs/route_bloc/route_bloc.dart';
import '../blocs/route_bloc/route_state.dart';
import 'component/current_location.dart';
import 'component/destination_search_bar.dart';
import 'package:latlong2/latlong.dart';

// ignore: must_be_immutable
class MainPage extends StatefulWidget {
  LatLng? destinationPlace;
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final MapController mapController;
  List<Marker> markers = [];
  bool routeShown = false;
  late String? mode;

  @override
  Widget build(BuildContext context) {
    var destinationSearchBar = DestinationSearchBar(
      mapController: mapController,
      main: super.widget,
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
            alignment: Alignment.center,
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
                    markers = state.mapDisplay.markers!;
                    return BlocConsumer<RouteBloc, RouteState>(
                      listener: (context, routeState) async {
                        if (routeState is RouteSuccess) {
                          setState(() {
                            routeShown = true;
                            mode = routeState.mapDisplay.mode;
                          });

                          var location = Location();
                          var currentLocation = await location.getLocation();
                          mapController.move(
                            LatLng(currentLocation.latitude!,
                                currentLocation.longitude!),
                            18,
                          );
                        }
                      },
                      builder: (context, routeState) {
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
                            MarkerLayerOptions(markers: markers),
                            (routeState is RouteSuccess)
                                ? PolylineLayerOptions(polylines: [
                                    Polyline(
                                        points:
                                            routeState.mapDisplay.bestRoute!,
                                        strokeWidth: 8.0,
                                        color: Colors.red),
                                  ])
                                : PolylineLayerOptions(polylines: [])
                          ],
                        );
                      },
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
                    Container(
                      decoration: routeShown && mode == "walking"
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.red, width: 2.5))
                          : const BoxDecoration(),
                      width: 40,
                      height: 40,
                      child: FloatingActionButton(
                        child: const Icon(Icons.directions_walk),
                        onPressed: routeShown && mode == "walking"
                            ? null
                            : () async {
                                // implementation
                                if (super.widget.destinationPlace != null) {
                                  var location = Location();
                                  var currentLocation =
                                      await location.getLocation();
                                  BlocProvider.of<RouteBloc>(context).add(
                                      ShowRoute(
                                          startLocation:
                                              LatLng(currentLocation.latitude!,
                                                  currentLocation.longitude!),
                                          destination:
                                              super.widget.destinationPlace!,
                                          mode: "walking"));
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: const Text(
                                            "Please set the destination address first."),
                                        actions: [
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("ok")),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: routeShown && mode == "driving"
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.red, width: 2.5))
                          : const BoxDecoration(),
                      width: 40,
                      height: 40,
                      child: FloatingActionButton(
                          child: const Icon(Icons.directions_car),
                          onPressed: routeShown && mode == "driving"
                              ? null
                              : () async {
                                  // implementation
                                  if (super.widget.destinationPlace != null) {
                                    var location = Location();
                                    var currentLocation =
                                        await location.getLocation();
                                    BlocProvider.of<RouteBloc>(context).add(
                                        ShowRoute(
                                            startLocation: LatLng(
                                                currentLocation.latitude!,
                                                currentLocation.longitude!),
                                            destination:
                                                super.widget.destinationPlace!,
                                            mode: "driving"));
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: const Text(
                                              "Please set the destination address first."),
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("ok")),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                }),
                    ),
                  ],
                ),
              ),

              // current location and cancel route ===============================
              Positioned(
                bottom: 15,
                right: 15,
                child: Column(
                  children: [
                    CurrentLocation(mapController: mapController),
                    const SizedBox(
                      height: 10,
                    ),
                    // cancel route icon ============================

                    // (routeShown)
                    //     ? SizedBox(
                    //         width: 40,
                    //         height: 40,
                    //         child: FloatingActionButton(
                    //           child: const Icon(
                    //             Icons.cancel,
                    //             color: Colors.red,
                    //           ),
                    //           onPressed: () {},
                    //         ),
                    //       )
                    //     : const SizedBox(),
                  ],
                ),
              ),

              // error or loading route setup======================================
              Positioned(
                child: BlocListener<RouteBloc, RouteState>(
                  listener: (context, state) {
                    if (state is RouteFailure) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Text(state.message),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("cancel"),
                                ),
                              ],
                            );
                          });
                    }
                  },
                  child: BlocBuilder<RouteBloc, RouteState>(
                    builder: (context, routeState) {
                      if (routeState is RouteLoading) {
                        return Container(
                          color: const Color.fromARGB(40, 0, 0, 0),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child:
                              const Center(child: CircularProgressIndicator()),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ),
              ),
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
