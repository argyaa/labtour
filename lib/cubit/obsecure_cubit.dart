import 'package:bloc/bloc.dart';

class ObsecureCubit extends Cubit<bool> {
  ObsecureCubit() : super(true);

  void setView(value) {
    emit(value);
  }
}
