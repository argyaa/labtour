import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labtour/cubit/page_cubit.dart';
import 'package:labtour/shared/theme.dart';
import 'package:labtour/view/widgets/bottom_nav_item.dart';

import 'favorite_page.dart';
import 'home_page.dart';
import 'profile_page.dart';
import 'search_page.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget customBottomNav() {
      return ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
        child: BottomAppBar(
          color: Colors.white,
          clipBehavior: Clip.antiAlias,
          child: Container(
            color: Colors.white,
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TabItem(
                  icon: "assets/icon_nav_home_unactive.png",
                  index: 0,
                  detail: "Beranda",
                ),
                TabItem(
                  icon: "assets/icon_nav_search_unactive.png",
                  index: 1,
                  detail: "Cari",
                ),
                TabItem(
                  icon: "assets/icon_nav_favorite_unactive.png",
                  index: 2,
                  detail: "Favorit",
                ),
                TabItem(
                  icon: "assets/icon_nav_profile_unactive.png",
                  index: 3,
                  detail: "Profil",
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget favoriteAppbar() {
      return AppBar(
        title: Text(
          "Favorit anda",
          style: blackTextStyle,
        ),
        centerTitle: true,
        backgroundColor: Color(0xffFAFAFA),
        elevation: 0,
      );
    }

    Widget profilAppbar() {
      return AppBar(
        title: Text(
          "Profil anda",
          style: blackTextStyle,
        ),
        centerTitle: true,
        backgroundColor: Color(0xffFAFAFA),
        elevation: 0,
      );
    }

    // ignore: missing_return
    Widget buildAppbar(int index) {
      switch (index) {
        case 2:
          return favoriteAppbar();
          break;
        case 3:
          return profilAppbar();
          break;
      }
    }

    Widget buildContent(int index) {
      switch (index) {
        case 0:
          return HomePage();
          break;
        case 1:
          return SearchPage();
          break;
        case 2:
          return FavoritePage();
          break;
        case 3:
          return ProfilePage();
          break;
        default:
          return HomePage();
      }
    }

    return BlocBuilder<PageCubit, int>(
      builder: (context, index) {
        return Scaffold(
          appBar: buildAppbar(index),
          backgroundColor: Color(0xffFAFAFA),
          bottomNavigationBar: customBottomNav(),
          body: buildContent(index),
        );
      },
    );
  }
}
