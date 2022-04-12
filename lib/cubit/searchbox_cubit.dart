import 'package:bloc/bloc.dart';

class SearchboxCubit extends Cubit<String> {
  SearchboxCubit() : super("");

  void setText(String text) {
    emit(text);
  }
}
