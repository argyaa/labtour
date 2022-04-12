import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:labtour/models/user_model.dart';

class AuthService {
  String baseUrl = "http://labtour.lazywakeup.my.id/api";

  Future<UserModel> register(
      {String name, String username, String email, String password}) async {
    var url = "$baseUrl/register";
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'name': name,
      'username': username,
      'email': email,
      'password': password,
    });

    var response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      UserModel user = UserModel.fromJson(data['user']);
      user.token = "Bearer " + data['token'];

      return user;
    } else {
      throw Exception('Gagal Register');
    }
  }

  Future<UserModel> login({String email, String password}) async {
    var url = "$baseUrl/login";
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'email': email,
      'password': password,
    });

    var response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      UserModel user = UserModel.fromJson(data['user']);
      user.token = "Bearer " + data['token'];

      return user;
    } else {
      throw Exception('Email atau Password anda salah');
    }
  }

  Future<void> logout({String token}) async {
    var url = "$baseUrl/logout";
    var headers = {"Authorization": token};

    var response = await http.post(Uri.parse(url), headers: headers);
    print(response.body);
  }
}
