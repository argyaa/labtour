import 'package:flutter/material.dart';
import 'package:labtour/cubit/city_cubit.dart';
import 'package:labtour/cubit/location_cubit.dart';
import 'package:labtour/shared/theme.dart';
import 'package:labtour/view/widgets/lokasi_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labtour/view/widgets/lokasi_item_skeleton.dart';

class LokasiPage extends StatefulWidget {
  final String token;
  LokasiPage(this.token);

  @override
  _LokasiPageState createState() => _LokasiPageState();
}

class _LokasiPageState extends State<LokasiPage> {
  @override
  void initState() {
    context.read<CityCubit>().fetchCity(widget.token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var location = context.watch<LocationCubit>().state;
    // List<String> kota = [
    //   'Aceh',
    //   'Bandung',
    //   'Cirebon',
    //   'Depok',
    //   'Jakarta',
    //   'Kalimantan',
    //   'Lamongan',
    //   'Palembang',
    //   'Yogyakarta',
    // ];

    Widget myLocationButton() {
      return Container(
        padding: EdgeInsets.all(24),
        child: ElevatedButton(
          onPressed: () async {
            await context.read<LocationCubit>().getInitCity();
            Navigator.pop(context);
          },
          child: Text("Gunakan Lokasi Saya"),
        ),
      );
    }

    Widget loading() {
      return Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      );
    }

    Widget content() {
      return BlocBuilder<CityCubit, CityState>(
        builder: (context, state) {
          if (state is CitySuccess) {
            print("length city ${state.city.length}");
            return Container(
              margin: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: state.city.map((e) => LokasiItem(e)).toList(),
              ),
            );
          }
          return Container(
            margin: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
                  .map((e) => LokasiItemSkeleton())
                  .toList(),
            ),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Pilih Lokasi",
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
      bottomNavigationBar:
          location == 'loading' ? loading() : myLocationButton(),
      body: ListView(
        children: [
          SizedBox(height: 16),
          content(),
        ],
      ),
    );
  }
}
