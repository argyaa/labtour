import 'package:flutter/material.dart';
import 'package:labtour/cubit/location_cubit.dart';
import 'package:labtour/models/city_model.dart';
import 'package:labtour/shared/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LokasiItem extends StatelessWidget {
  final CityModel city;
  LokasiItem(this.city);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        context.read<LocationCubit>().setCity(city.name);
        Navigator.pop(context);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              city.name,
              style: blackTextStyle.copyWith(fontSize: 16),
            ),
            SizedBox(height: 8),
            Divider(),
          ],
        ),
      ),
    );
  }
}
