part of 'city_cubit.dart';

abstract class CityState extends Equatable {
  const CityState();

  @override
  List<Object> get props => [];
}

class CityInitial extends CityState {}

class CityLoading extends CityState {}

class CitySuccess extends CityState {
  final List<CityModel> city;

  CitySuccess(this.city);

  List<Object> get props => [city];
}

class CityFailed extends CityState {
  final String error;
  CityFailed(this.error);

  @override
  List<Object> get props => [error];
}
