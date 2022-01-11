import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class QueryChanged extends SearchEvent {
  final String query;

  const QueryChanged({required this.query});

  @override
  List<Object> get props => [];
}