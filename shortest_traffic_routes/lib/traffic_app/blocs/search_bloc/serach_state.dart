import 'package:equatable/equatable.dart';

class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class QueryInitial extends SearchState {}

class QueryProcessing extends SearchState {}

class QueryProcessSuccess extends SearchState {
  final dynamic searchResults;
  const QueryProcessSuccess({required this.searchResults});

  @override
  List<Object> get props => [searchResults];
}

class QueryProcessFailure extends SearchState {
  final String message;
  const QueryProcessFailure({required this.message});

  @override
  List<Object> get props => [];
}
