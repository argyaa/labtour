import 'package:flutter/material.dart';
import 'package:labtour/cubit/auth_cubit.dart';
import 'package:labtour/cubit/location_cubit.dart';
import 'package:labtour/models/destinasi_model.dart';
import 'package:labtour/services/API/destinasi_service.dart';
import 'package:labtour/shared/theme.dart';
import 'package:labtour/view/widgets/wisata_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labtour/view/widgets/wisata_card_skeleton.dart';

class WisataPopulerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var location = context.watch<LocationCubit>().state;

    Widget dataError() {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.25),
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.25),
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

    Widget content() {
      return Container(
        margin: EdgeInsets.fromLTRB(24, 24, 24, 0),
        child: Column(children: [
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is AuthSuccess) {
                return FutureBuilder<List<DestinasiModel>>(
                    future: DestinasiService()
                        .getDestinasi(city: location, token: state.user.token),
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
        ]),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Wisata Populer",
          style: blackTextStyle,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          content(),
        ],
      ),
    );
  }
}
