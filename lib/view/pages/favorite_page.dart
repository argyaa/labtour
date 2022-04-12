import 'package:flutter/material.dart';
import 'package:labtour/cubit/favorite_cubit.dart';
import 'package:labtour/cubit/page_cubit.dart';
import 'package:labtour/shared/theme.dart';
import 'package:labtour/view/widgets/wisata_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labtour/view/widgets/wisata_card_skeleton.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    context.read<FavoriteCubit>().fetchFavorite();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget noData() {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.25),
            Image.asset(
              'assets/image_nodata.png',
              width: 200,
              height: 165,
            ),
            SizedBox(height: 24),
            Text(
              "Belum ada Favorit",
              style: grey2TextStyle.copyWith(fontSize: 20),
            ),
            SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                context.read<PageCubit>().setPage(0);
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                decoration: BoxDecoration(
                    color: blue, borderRadius: BorderRadius.circular(5)),
                child: Text(
                  "Eksplor Wisata",
                  style:
                      whiteTextStyle.copyWith(fontSize: 14, fontWeight: medium),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget content() {
      return BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteSuccess) {
            if (state.destinasi.length == 0) return noData();
            return Container(
              margin: EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: Column(
                children: state.destinasi
                    .map((e) => WisataCard(destinasi: e))
                    .toList(),
              ),
            );
          }

          return Container(
            margin: EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: Column(
              children:
                  [1, 2, 3, 4, 5].map((e) => WisataCardSkeleton()).toList(),
            ),
          );
        },
      );
    }

    return Scaffold(
      body: ListView(
        children: [
          content(),
        ],
      ),
    );
  }
}
