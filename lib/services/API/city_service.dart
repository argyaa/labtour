import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:labtour/models/city_model.dart';

class CityService {
  String baseUrl = "http://labtour.lazywakeup.my.id/api";

  Future<List<CityModel>> getCity({String token}) async {
    var url = "$baseUrl/cities";
    var headers = {'Authorization': token};

    var response = await http.get(Uri.parse(url), headers: headers);
    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      print("data $data");

      // List<CityModel> city = [];

      // for (var item in data) {
      //   city.add(CityModel.fromJson(item));
      // }

      List<CityModel> city = data.map((e) => CityModel.fromJson(e)).toList();

      return city;
    } else {
      throw Exception("Gagal get city");
    }
  }
}
