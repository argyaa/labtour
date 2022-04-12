import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labtour/cubit/auth_cubit.dart';
import 'package:labtour/models/destinasi_model.dart';
import 'package:labtour/shared/theme.dart';
import 'package:labtour/view/pages/detail_page.dart';

class WisataCard extends StatelessWidget {
  final DestinasiModel destinasi;
  final String lokasi;
  WisataCard({this.destinasi, this.lokasi});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthSuccess) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          DetailPage(destinasi, lokasi, state.user.id)));
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 24),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: destinasi.image,
                      height: MediaQuery.of(context).size.height * 0.18,
                      width: MediaQuery.of(context).size.width * 0.33,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        destinasi.city ?? lokasi,
                        style: grey2TextStyle.copyWith(
                            fontSize: 14, fontWeight: medium),
                      ),
                      SizedBox(height: 4),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                            (destinasi.name.length >= 50)
                                ? destinasi.name.substring(0, 50) + "..."
                                : destinasi.name,
                            style: blackTextStyle.copyWith(
                              fontSize: 18,
                            )),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: yellow,
                          ),
                          SizedBox(width: 4),
                          Text(
                            destinasi.rating,
                            style: yellowTextStyle.copyWith(
                                fontSize: 14, fontWeight: bold),
                          ),
                          SizedBox(width: 6),
                          CircleAvatar(
                            radius: 2,
                            backgroundColor: grey2,
                          ),
                          SizedBox(width: 6),
                          destinasi.kategoriRisk == "Resiko covid Tinggi"
                              ? Text(
                                  destinasi.kategoriRisk,
                                  style: redTextStyle.copyWith(
                                    fontSize: 13,
                                    fontWeight: bold,
                                  ),
                                )
                              : Text(
                                  destinasi.kategoriRisk,
                                  style: greenTextStyle.copyWith(
                                    fontSize: 13,
                                    fontWeight: bold,
                                  ),
                                ),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  )
                ],
              ),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
