import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:labtour/models/destinasi_model.dart';
import 'package:labtour/services/API/destinasi_service.dart';

part 'destinasi_state.dart';

class DestinasiCubit extends Cubit<DestinasiState> {
  DestinasiCubit() : super(DestinasiInitial());

  void fetchDestinasi({String token, String city}) async {
    try {
      emit(DestinasiLoading());
      List<DestinasiModel> destinasi = await DestinasiService().getDestinasi(
        token: token,
        city: city,
      );
      emit(DestinasiSuccess(destinasi));
    } catch (e) {
      emit(DestinasiFailed(e.toString()));
    }
  }

  void fetchDestinasiPopuler({String token, String city}) async {
    try {
      emit(DestinasiLoading());
      List<DestinasiModel> destinasi =
          await DestinasiService().getDestinasiPopuler(
        token: token,
        city: city,
      );
      emit(DestinasiSuccess(destinasi));
    } catch (e) {
      emit(DestinasiFailed(e.toString()));
    }
  }
}
