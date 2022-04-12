import 'package:bloc/bloc.dart';
import 'package:labtour/services/database/favorite_destinasi_db.dart';

class IsfavoriteCubit extends Cubit<bool> {
  IsfavoriteCubit() : super(false);

  void isFavorite(int id) async {
    bool isFavorite = await DatabaseFavorite.instance.isFavorite(id);
    emit(isFavorite);
  }
}
