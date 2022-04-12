import 'dart:async';

import 'package:flutter/material.dart';
import 'package:labtour/cubit/auth_cubit.dart';
import 'package:labtour/cubit/location_cubit.dart';
import 'package:labtour/shared/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(Duration(seconds: 1), () async {
      final pref = await SharedPreferences.getInstance();
      if (pref.containsKey('authData')) {
        await context.read<AuthCubit>().getCurrentUser();
        await context.read<LocationCubit>().getInitCity();
        Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, '/sign-in', (route) => false);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo_splash.png',
              width: 120,
              height: 120,
            ),
            SizedBox(height: 32),
            Text(
              "Labtour",
              style: whiteTextStyle.copyWith(fontSize: 34, fontWeight: medium),
            )
          ],
        ),
      ),
    );
  }
}
