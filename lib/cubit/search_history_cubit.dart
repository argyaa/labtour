import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:labtour/models/search_history_model.dart';
import 'package:labtour/services/database/search_history_db.dart';

part 'search_history_state.dart';

class SearchHistoryCubit extends Cubit<SearchHistoryState> {
  SearchHistoryCubit() : super(SearchHistoryInitial());

  void fetchHistory() async {
    try {
      emit(SearchHistoryLoading());
      List<SearchHistoryModel> history =
          await DatabaseSearchHistory.instance.fetchHistory();
      emit(SearchHistorySuccess(history));
    } catch (e) {
      print("Error $e");
      emit(SearchHistoryFailed(e.toString()));
    }
  }

  void insertHistory(String value) async {
    await DatabaseSearchHistory.instance.insertHistory(value);
  }

  void deleteHistory(int id) async {
    await DatabaseSearchHistory.instance.deleteHistory(id);
  }
}
