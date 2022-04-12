import 'package:bloc/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationCubit extends Cubit<String> {
  LocationCubit() : super('');

  void setCity(String city) {
    var splitText = city.split(' ');
    splitText.removeWhere((e) => e == 'Kota');
    splitText.removeWhere((e) => e == 'City');
    splitText.removeWhere((e) => e == 'Kabupaten');
    splitText.removeWhere((e) => e == 'Wisata');
    if (splitText.length > 1) {
      var kota = splitText.join(" ");
      emit(kota);
    } else {
      emit(splitText[0]);
    }
  }

  Future<void> getInitCity() async {
    emit("loading");
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'Please enable Your Location Service');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
          msg:
              'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      // List<Placemark> placemarks =
      //     await placemarkFromCoordinates(-6.595038, 106.816635);
      Placemark place = placemarks[0];
      print(place);
      setCity(place.subAdministrativeArea);

      // setState(() {
      //   currentposition = position;
      //   currentAddress =
      //       "${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}";
      // });
    } catch (e) {
      print(e);
    }
  }
}
