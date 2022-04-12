import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:labtour/models/destinasi_model.dart';
import 'package:labtour/services/database/favorite_destinasi_db.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());

  void fetchFavorite() async {
    try {
      emit(FavoriteLoading());
      List<DestinasiModel> destinasi =
          await DatabaseFavorite.instance.fetchFavorite();

      print("Favorite cubit");
      print(destinasi.length);

      emit(FavoriteSuccess(destinasi));
    } catch (e) {
      emit(FavoriteFailed(e.toString()));
    }
  }

  void insertFavorite(DestinasiModel destinasi) async {
    try {
      await DatabaseFavorite.instance.insertFavorite(destinasi);
    } catch (e) {
      emit(FavoriteFailed(e.toString()));
    }
  }

  void deleteFavorite(int id) async {
    try {
      await DatabaseFavorite.instance.deleteFavorite(id);
    } catch (e) {
      emit(FavoriteFailed(e.toString()));
    }
  }
}
