import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labtour/view/pages/main_page.dart';
import 'package:labtour/view/pages/sign_in_page.dart';
import 'package:labtour/view/pages/sign_up_page.dart';
import 'package:labtour/view/pages/splash_page.dart';
import 'package:labtour/view/pages/tips_page.dart';
import 'package:labtour/view/pages/wisata_populer_page.dart';

import 'cubit/auth_cubit.dart';
import 'cubit/city_cubit.dart';
import 'cubit/comment_cubit.dart';
import 'cubit/favorite_cubit.dart';
import 'cubit/isfavorite_cubit.dart';
import 'cubit/location_cubit.dart';
import 'cubit/mycomment_cubit.dart';
import 'cubit/obsecure_cubit.dart';
import 'cubit/page_cubit.dart';
import 'cubit/search_history_cubit.dart';
import 'cubit/searchbox_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PageCubit()),
        BlocProvider(create: (context) => ObsecureCubit()),
        BlocProvider(create: (context) => SearchboxCubit()),
        BlocProvider(create: (context) => SearchHistoryCubit()),
        BlocProvider(create: (context) => LocationCubit()),
        BlocProvider(create: (context) => CityCubit()),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => CommentCubit()),
        BlocProvider(create: (context) => MycommentCubit()),
        BlocProvider(create: (context) => FavoriteCubit()),
        BlocProvider(create: (context) => IsfavoriteCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => SplashPage(),
          '/sign-in': (context) => SignInPage(),
          '/sign-up': (context) => SignUpPage(),
          '/main': (context) => MainPage(),
          '/tips': (context) => TipsPage(),
          '/wisata-populer': (context) => WisataPopulerPage(),
        },
      ),
    );
  }
}
