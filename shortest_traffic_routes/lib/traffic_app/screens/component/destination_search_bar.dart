import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:shortest_traffic_routes/traffic_app/blocs/marker_bloc_event_state.dart';
import 'package:shortest_traffic_routes/traffic_app/blocs/search_bloc/search_bloc.dart';
import 'package:shortest_traffic_routes/traffic_app/blocs/search_bloc/search_event.dart';
import 'package:shortest_traffic_routes/traffic_app/screens/mainpage.dart';

import '../../blocs/search_bloc/serach_state.dart';

// ignore: must_be_immutable
class DestinationSearchBar extends StatefulWidget {
  const DestinationSearchBar(
      {Key? key, required this.mapController, required this.main})
      : super(key: key);
  final MapController mapController;
  final MainPage main;

  @override
  _DestinationSearchBarState createState() =>
      // ignore: no_logic_in_create_state
      _DestinationSearchBarState(mapController: mapController);
}

class _DestinationSearchBarState extends State<DestinationSearchBar> {
  final MapController mapController;
  final floatingBarSearchController = FloatingSearchBarController();
  _DestinationSearchBarState({required this.mapController});
  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    String hint = 'Search destination address...';

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return FloatingSearchBar(
          height: 70,
          progress: (state is QueryProcessing),
          hint: hint,
          isScrollControlled: true,
          controller: floatingBarSearchController,
          // scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
          transitionDuration: const Duration(milliseconds: 400),
          transitionCurve: Curves.easeInOut,
          // physics: const BouncingScrollPhysics(),
          axisAlignment: isPortrait ? 0.0 : -1.0,
          openAxisAlignment: 0.0,
          width: isPortrait ? 500 : 400,
          debounceDelay: const Duration(milliseconds: 1000),
          onQueryChanged: (query) {
            BlocProvider.of<SearchBloc>(context)
                .add(QueryChanged(query: query));
            // Call your model, bloc, controller here.
          },
          // Specify a custom transition to be used for
          // animating between opened and closed stated.
          transition: ExpandingFloatingSearchBarTransition(),
          leadingActions: const [
            Icon(Icons.place),
          ],
          actions: [
            FloatingSearchBarAction(
              showIfOpened: false,
              child: CircularButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
            ),
            FloatingSearchBarAction.searchToClear(
              showIfClosed: false,
            ),
          ],
          builder: (context, transition) {
            if (state is QueryProcessFailure) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const Icon(Icons.face),
                  Text(state.message),
                ]),
              );
            } else if (state is QueryProcessSuccess) {
              if (state.searchResults.length > 0) {
                return ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.searchResults.length,
                      itemBuilder: (context, i) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              hint = state.searchResults[i].name;
                            });
                            super.widget.main.destinationPlace =
                                state.searchResults[i].latlng;
                            BlocProvider.of<MarkerBloc>(context).add(
                                MarkerChanged(
                                    place: state.searchResults[i].latlng));
                            floatingBarSearchController.close();
                            widget.mapController.move(
                              state.searchResults[i].latlng,
                              18,
                            );
                          },
                          child: ListTile(
                            leading: const Icon(Icons.place),
                            title: Text(state.searchResults[i].name),
                            subtitle: Text(
                                '${state.searchResults[i].state}, ${state.searchResults[i].country}'),
                          ),
                        );
                      },
                    ));
              } else {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child:
                      Column(mainAxisSize: MainAxisSize.min, children: const [
                    Icon(Icons.face),
                    Text("Sorry we couldn't find anything"),
                  ]),
                );
              }
            } else {
              return const SizedBox(
                height: 0,
                width: 0,
              );
            }
          },
        );
      },
    );
  }
}
