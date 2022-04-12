import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:labtour/models/destinasi_model.dart';

class DestinasiService {
  String baseUrl = "http://labtour.lazywakeup.my.id/api";

  Future<List<DestinasiModel>> getDestinasi({String token, String city}) async {
    var url = "$baseUrl/tour/tour-by-city-covid/$city";
    var headers = {'Authorization': token};

    var response = await http.get(Uri.parse(url), headers: headers);
    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);

      List<DestinasiModel> destinasi =
          data.map((e) => DestinasiModel.fromJson(e)).toList();

      return destinasi;
    } else {
      throw Exception("Gagal get destinasi");
    }
  }

  Future<List<DestinasiModel>> getDestinasiPopuler(
      {String token, String city}) async {
    var url = "$baseUrl/tour/tour-by-popular/$city";
    var headers = {'Authorization': token};

    var response = await http.get(Uri.parse(url), headers: headers);
    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);

      List<DestinasiModel> destinasi =
          data.map((e) => DestinasiModel.fromJson(e)).toList();

      return destinasi;
    } else {
      throw Exception("Gagal get destinasi");
    }
  }

  Future<List<DestinasiModel>> searchDestinasi(
      {String token, String value}) async {
    var url = "$baseUrl/search?q=$value";
    var headers = {'Authorization': token};

    var response = await http.get(Uri.parse(url), headers: headers);
    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      if (data.length > 0) {
        List<DestinasiModel> destinasi =
            data.map((e) => DestinasiModel.fromJson(e)).toList();

        return destinasi;
      } else {
        return [];
      }
    } else {
      throw Exception("Gagal get destinasi");
    }
  }
}
