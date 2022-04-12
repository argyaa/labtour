import 'package:flutter/material.dart';
import 'package:labtour/cubit/auth_cubit.dart';
import 'package:labtour/cubit/location_cubit.dart';
import 'package:labtour/cubit/page_cubit.dart';
import 'package:labtour/models/destinasi_model.dart';
import 'package:labtour/services/API/destinasi_service.dart';
import 'package:labtour/shared/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labtour/view/pages/lokasi_page.dart';
import 'package:labtour/view/widgets/wisata_card.dart';
import 'package:labtour/view/widgets/wisata_card_skeleton.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var location = context.watch<LocationCubit>().state;

    Widget dataError() {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Image.asset(
              'assets/image_data_error.png',
              width: 200,
              height: 165,
            ),
            SizedBox(height: 24),
            Text(
              "Gagal mendapatkan data",
              style: grey2TextStyle.copyWith(fontSize: 20),
            ),
            SizedBox(height: 24),
          ],
        ),
      );
    }

    Widget noData() {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Image.asset(
              'assets/image_nodata.png',
              width: 200,
              height: 165,
            ),
            SizedBox(height: 24),
            Text(
              "Tidak ada data",
              style: grey2TextStyle.copyWith(fontSize: 20),
            ),
            SizedBox(height: 24),
          ],
        ),
      );
    }

    Widget header() {
      return BlocBuilder<AuthCubit, AuthState>(
        builder: (context, auth) {
          if (auth is AuthSuccess) {
            return Container(
              margin: EdgeInsets.fromLTRB(24, 60, 24, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Halo, ${auth.user.username}",
                          style: grey1TextStyle.copyWith(
                              fontSize: 20, fontWeight: medium),
                        ),
                        SizedBox(height: 8),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        LokasiPage(auth.user.token)));
                          },
                          child: Row(
                            children: [
                              Image.asset('assets/icon_place.png',
                                  width: 16, height: 16),
                              SizedBox(width: 6),
                              Text(
                                location.toString(),
                                style: blackTextStyle.copyWith(fontSize: 16),
                              ),
                              Icon(Icons.arrow_drop_down)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(auth.user.image),
                  )
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );
    }

    Widget searchBox() {
      return GestureDetector(
        onTap: () {
          context.read<PageCubit>().setPage(1);
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(24, 40, 24, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          padding: EdgeInsets.all(16),
          height: 56,
          child: Row(
            children: [
              Image.asset('assets/icon_search.png', width: 24, height: 24),
              SizedBox(width: 16),
              Text(
                "Cari destinasi wisata",
                style: grey1TextStyle.copyWith(fontSize: 16),
              )
            ],
          ),
        ),
      );
    }

    Widget tipsBepergian() {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/tips');
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(24, 24, 24, 0),
          width: double.infinity,
          height: 95,
          decoration: BoxDecoration(
              color: bluelight, borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              SizedBox(width: 24),
              Expanded(
                child: Text(
                  "Pelajari Tips Bepergian\nSaat Pandemi",
                  style: blackTextStyle.copyWith(fontSize: 16),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    'assets/image_tips.png',
                    width: 115,
                    height: 79,
                  ),
                ],
              ),
              SizedBox(width: 15)
            ],
          ),
        ),
      );
    }

    Widget wisataPopuler() {
      return Container(
        margin: EdgeInsets.fromLTRB(24, 32, 24, 0),
        child: Column(
          children: [
            Row(
              children: [
                Text("Wisata Populer",
                    style: blackTextStyle.copyWith(
                        fontSize: 20, fontWeight: medium)),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/wisata-populer');
                  },
                  child: Text(
                    "Lihat semua",
                    style: blueTextStyle.copyWith(fontSize: 16),
                  ),
                )
              ],
            ),
            SizedBox(height: 24),
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is AuthSuccess) {
                  return FutureBuilder<List<DestinasiModel>>(
                      future: DestinasiService().getDestinasiPopuler(
                          city: location, token: state.user.token),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            var data = snapshot.data;
                            if (data.length > 0) {
                              return Column(
                                  children: data
                                      .map<Widget>((e) => WisataCard(
                                          destinasi: e, lokasi: location))
                                      .toList());
                            } else {
                              return noData();
                            }
                          } else {
                            return dataError();
                          }
                        }
                        return Column(
                          children: [1, 2, 3, 4, 5]
                              .map<Widget>((e) => WisataCardSkeleton())
                              .toList(),
                        );
                      });
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      );
    }

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Color(0xffFAFAFA),
          collapsedHeight: 90,
          flexibleSpace: header(),
        ),
        SliverAppBar(
          backgroundColor: Color(0xffFAFAFA),
          flexibleSpace: searchBox(),
          // expandedHeight: 200,
          collapsedHeight: 80,
          elevation: 0,
          pinned: true,
          floating: true,
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              tipsBepergian(),
              wisataPopuler(),
            ],
          ),
        ),
      ],
    );
  }
}
