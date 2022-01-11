import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shortest_traffic_routes/traffic_app/blocs/search_bloc/search_event.dart';
import 'package:shortest_traffic_routes/traffic_app/blocs/search_bloc/serach_state.dart';

import '../../repository/place_repository.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final PlaceRepository placeRepository;

  SearchBloc({required this.placeRepository}) : super(QueryInitial()) {
    on<QueryChanged>(_search);
  }
  // implementation for the event to load map
  Future<void> _search(QueryChanged event, Emitter<SearchState> emit) async {
    emit(QueryProcessing());
    try {
      print("query_bloc");
      var searchResults = await placeRepository.search(event.query);
      print(searchResults);
      emit(QueryProcessSuccess(searchResults: searchResults));
    } catch (e) {
      print(e.toString());
      emit(const QueryProcessFailure(
          message: "Network error please try again."));
    }
  }
}
