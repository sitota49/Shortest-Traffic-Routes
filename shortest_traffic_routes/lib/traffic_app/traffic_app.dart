import 'package:flutter/material.dart';
import 'package:shortest_traffic_routes/traffic_app/blocs/marker_bloc_event_state.dart';
import 'package:shortest_traffic_routes/traffic_app/blocs/search_bloc/search_bloc.dart';
import 'package:shortest_traffic_routes/traffic_app/data_provider/place_data_provider.dart';
import 'package:shortest_traffic_routes/traffic_app/data_provider/route_data_provider.dart';
import 'package:shortest_traffic_routes/traffic_app/repository/map_display_repository.dart';
import 'package:shortest_traffic_routes/traffic_app/repository/place_repository.dart';
import 'package:shortest_traffic_routes/traffic_app/repository/route_repository.dart';
import 'package:shortest_traffic_routes/traffic_app/screens/mainpage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shortest_traffic_routes/traffic_app/blocs/map_display_bloc.dart';
import 'package:shortest_traffic_routes/traffic_app/blocs/map_display_event.dart';
import 'package:shortest_traffic_routes/traffic_app/data_provider/map_display_data_provider.dart';
import 'package:http/http.dart' as http;

import 'blocs/route_bloc/route_bloc.dart';

class MyApp extends StatelessWidget {
  static final httpClient = http.Client();

  MyApp({Key? key}) : super(key: key);

  // map Display repository
  final mapDisplayRepository = MapDisplayRepository(
    dataProvider: MapDisplayDataProvider(
      httpClient: MyApp.httpClient,
    ),
  );

  // place repository
  final placeRepository = PlaceRepository(
      dataProvider: PlaceDataProvider(httpClient: MyApp.httpClient));

  // route repository
  final routeRepository = RouteRepository(
      dataProvider: RouteDataProvider(httpClient: MyApp.httpClient));

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  MapDisplayBloc(mapDisplayRepository: mapDisplayRepository)
                    ..add(
                      const MapDisplayLoad(),
                    )),
          BlocProvider(
              create: (context) =>
                  SearchBloc(placeRepository: placeRepository)),
          BlocProvider(create: (context) => MarkerBloc()),
          BlocProvider(create: (context) => RouteBloc(routeRepository: routeRepository)),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MainPage(),
        ));
  }
}
