part of 'destinasi_cubit.dart';

abstract class DestinasiState extends Equatable {
  const DestinasiState();

  @override
  List<Object> get props => [];
}

class DestinasiInitial extends DestinasiState {}

class DestinasiLoading extends DestinasiState {}

class DestinasiSuccess extends DestinasiState {
  final List<DestinasiModel> destinasi;

  DestinasiSuccess(this.destinasi);

  List<Object> get props => [destinasi];
}

class DestinasiFailed extends DestinasiState {
  final String error;
  DestinasiFailed(this.error);

  @override
  List<Object> get props => [error];
}
