import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:labtour/models/city_model.dart';
import 'package:labtour/services/API/city_service.dart';

part 'city_state.dart';

class CityCubit extends Cubit<CityState> {
  CityCubit() : super(CityInitial());

  void fetchCity(String token) async {
    try {
      emit(CityLoading());
      List<CityModel> city = await CityService().getCity(token: token);
      print("berhasil");
      emit(CitySuccess(city));
    } catch (e) {
      emit(CityFailed(e.toString()));
    }
  }
}
