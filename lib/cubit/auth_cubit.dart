import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:labtour/models/user_model.dart';
import 'package:labtour/services/API/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> register(
      {String name, String username, String email, String password}) async {
    try {
      emit(AuthLoading());

      UserModel user = await AuthService().register(
        name: name,
        username: username,
        email: email,
        password: password,
      );
      print(user);

      final sharedPref = await SharedPreferences.getInstance();
      final myMapSPref = json.encode({
        'user': user.toJson(),
      });
      sharedPref.setString('authData', myMapSPref);

      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  Future<void> login({String email, String password}) async {
    try {
      emit(AuthLoading());

      UserModel user = await AuthService().login(
        email: email,
        password: password,
      );
      print(user);

      final sharedPref = await SharedPreferences.getInstance();
      final myMapSPref = json.encode({
        'user': user.toJson(),
      });
      sharedPref.setString('authData', myMapSPref);

      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  Future<void> logout({String token}) async {
    try {
      emit(AuthLoading());
      await AuthService().logout(token: token);
      final pref = await SharedPreferences.getInstance();
      pref.clear();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  Future<void> getCurrentUser() async {
    emit(AuthLoading());
    final pref = await SharedPreferences.getInstance();
    final myData = json.decode(pref.get('authData')) as Map<String, dynamic>;
    UserModel user = UserModel.fromJson(myData['user']);
    emit(AuthSuccess(user));
  }
}
