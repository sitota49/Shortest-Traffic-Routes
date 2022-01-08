import 'package:flutter/material.dart';
import 'package:shortest_traffic_routes/traffic_app/repository/map_display_repository.dart';
import 'package:shortest_traffic_routes/traffic_app/screens/mainpage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shortest_traffic_routes/traffic_app/blocs/map_display_bloc.dart';
import 'package:shortest_traffic_routes/traffic_app/blocs/map_display_event.dart';
import 'package:shortest_traffic_routes/traffic_app/blocs/map_display_state.dart';
import 'package:shortest_traffic_routes/traffic_app/data_provider/map_display_data_provider.dart';
import 'package:http/http.dart' as http;

class MyApp extends StatelessWidget {
  static final httpClient = http.Client();

  MyApp({Key? key}) : super(key: key);

  final mapDisplayRepository = MapDisplayRepository(
      dataProvider: MapDisplayDataProvider(
    httpClient: MyApp.httpClient,
  ));
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  MapDisplayBloc(mapDisplayRepository: mapDisplayRepository)
                    ..add(
                      MapDisplayLoad(),
                    )),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MainPage(),
        ));
  }
}
