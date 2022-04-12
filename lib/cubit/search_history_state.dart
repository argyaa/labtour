part of 'search_history_cubit.dart';

abstract class SearchHistoryState extends Equatable {
  const SearchHistoryState();

  @override
  List<Object> get props => [];
}

class SearchHistoryInitial extends SearchHistoryState {}

class SearchHistoryLoading extends SearchHistoryState {}

class SearchHistorySuccess extends SearchHistoryState {
  final List<SearchHistoryModel> history;

  SearchHistorySuccess(this.history);

  List<Object> get props => [history];
}

class SearchHistoryFailed extends SearchHistoryState {
  final String error;
  SearchHistoryFailed(this.error);

  @override
  List<Object> get props => [error];
}
