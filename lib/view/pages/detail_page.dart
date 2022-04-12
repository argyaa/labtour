import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:labtour/cubit/comment_cubit.dart';
import 'package:labtour/cubit/favorite_cubit.dart';
import 'package:labtour/cubit/isfavorite_cubit.dart';
import 'package:labtour/cubit/mycomment_cubit.dart';
import 'package:labtour/models/comment_model.dart';
import 'package:labtour/models/destinasi_model.dart';
import 'package:labtour/shared/theme.dart';
import 'package:labtour/view/pages/add_comment_page.dart';
import 'package:labtour/view/pages/all_comment_page.dart';
import 'package:labtour/view/widgets/komentar_card.dart';
import 'package:intl/intl.dart';
import 'package:labtour/view/widgets/komentar_card_skeleton.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  final DestinasiModel destinasi;
  final String lokasi;
  final int userId;
  DetailPage(
    this.destinasi,
    this.lokasi,
    this.userId,
  );

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    context.read<MycommentCubit>().fetchmycomment(
          id: widget.destinasi.id.toString(),
          userId: widget.userId,
        );
    context.read<CommentCubit>().fetchComment(widget.destinasi.id.toString());

    context.read<IsfavoriteCubit>().isFavorite(widget.destinasi.id);

    super.initState();
  }

  String dateformat(DateTime time) {
    var newFormat = DateFormat("dd/MM/yyyy");
    String updatedDt = newFormat.format(time);
    return updatedDt;
  }

  @override
  Widget build(BuildContext context) {
    var isFavorite = context.watch<IsfavoriteCubit>().state;

    hapusMyComment(String id) async {
      print("Hapusss");
      context.read<MycommentCubit>().deleteMyComment(
            id: widget.destinasi.id.toString(),
            docId: id,
          );
      context.read<MycommentCubit>().fetchmycomment(
            id: widget.destinasi.id.toString(),
            userId: widget.userId,
          );
      context.read<CommentCubit>().fetchComment(widget.destinasi.id.toString());
    }

    launchUrl(String url) async {
      var text = url.split(' ');
      var newText = text.join("+");
      // var newUrl = "https://www.google.com/maps/search/$newText";
      var newUrl = "https://www.google.com/maps/search/Orchid+Forest";
      try {
        if (await canLaunch(newUrl)) {
          launch(newUrl);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: red,
              content: Text(
                "Gagal",
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
      } catch (e) {
        print(e);
        print("cannot launch $url");
      }
    }

    Widget detailImage() {
      return Container(
        width: double.infinity,
        height: 246,
        margin: EdgeInsets.fromLTRB(24, 24, 24, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: NetworkImage(widget.destinasi.image == ''
                ? 'http://via.placeholder.com/150x150'
                : widget.destinasi.image),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.destinasi.kategoriRisk == "Resiko covid Tinggi"
                ? Container(
                    margin: EdgeInsets.all(12),
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: redlight,
                    ),
                    child: Text(
                      widget.destinasi.kategoriRisk,
                      style: redTextStyle.copyWith(fontWeight: bold),
                    ),
                  )
                : Container(
                    margin: EdgeInsets.all(12),
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: greenlight,
                    ),
                    child: Text(
                      widget.destinasi.kategoriRisk,
                      style: greenTextStyle.copyWith(fontWeight: bold),
                    ),
                  )
          ],
        ),
      );
    }

    Widget title() {
      return Container(
        margin: EdgeInsets.fromLTRB(24, 24, 24, 0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.destinasi.name,
                      style: blackTextStyle.copyWith(
                          fontSize: 24, fontWeight: medium)),
                  Row(
                    children: [
                      Text(
                        widget.destinasi.city ?? widget.lokasi,
                        style: grey1TextStyle.copyWith(fontSize: 16),
                      ),
                      SizedBox(width: 8),
                      CircleAvatar(
                        radius: 2,
                        backgroundColor: grey2,
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.star,
                        color: yellow,
                      ),
                      SizedBox(width: 4),
                      Text(
                        widget.destinasi.rating,
                        style: yellowTextStyle.copyWith(
                            fontSize: 16, fontWeight: medium),
                      )
                    ],
                  )
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_outline,
                color: isFavorite ? red : grey1,
              ),
              onPressed: () {
                if (isFavorite) {
                  context
                      .read<FavoriteCubit>()
                      .deleteFavorite(widget.destinasi.id);
                  context
                      .read<IsfavoriteCubit>()
                      .isFavorite(widget.destinasi.id);
                  context.read<FavoriteCubit>().fetchFavorite();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: blue,
                      content: Text(
                        "Berhasil terhapus di Favorit",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                } else {
                  context
                      .read<FavoriteCubit>()
                      .insertFavorite(widget.destinasi);
                  context
                      .read<IsfavoriteCubit>()
                      .isFavorite(widget.destinasi.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: blue,
                      content: Text(
                        "Berhasil tersimpan di Favorit",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
              },
            )
          ],
        ),
      );
    }

    Widget jamOperasional() {
      return Container(
        margin: EdgeInsets.fromLTRB(24, 24, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Jam Operasional",
              style: blackTextStyle.copyWith(fontSize: 20, fontWeight: medium),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Image.asset(
                  'assets/icon_time.png',
                  width: 24,
                  height: 24,
                ),
                SizedBox(width: 8),
                Text(
                  widget.destinasi.weekday,
                  style: blackTextStyle.copyWith(fontSize: 16),
                )
              ],
            )
          ],
        ),
      );
    }

    Widget nilaiTempatIni() {
      return Container(
        margin: EdgeInsets.fromLTRB(24, 24, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nilai tempat ini",
              style: blackTextStyle.copyWith(fontSize: 20, fontWeight: medium),
            ),
            SizedBox(height: 4),
            Text(
              "berikan penilaian anda mengenai tempat ini",
              style: grey1TextStyle.copyWith(fontWeight: medium),
            ),
            SizedBox(height: 16),
            Center(
              child: RatingBar.builder(
                initialRating: 0,
                minRating: 0,
                direction: Axis.horizontal,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 10.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: yellow,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddComment(
                        name: widget.destinasi.name,
                        rating: rating,
                        id: widget.destinasi.id.toString(),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddComment(
                      name: widget.destinasi.name,
                      id: widget.destinasi.id.toString(),
                    ),
                  ),
                );
              },
              child: Text(
                "Tulis Komentar anda",
                style: blueTextStyle.copyWith(fontSize: 16),
              ),
            ),
          ],
        ),
      );
    }

    Widget penilaianAnda(List<CommentModel> comment) {
      return Container(
        margin: EdgeInsets.fromLTRB(24, 24, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Penilaian anda",
              style: blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: medium,
              ),
            ),
            SizedBox(height: 16),
            Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(comment[0].user.image),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          comment[0].user.username ?? "nama",
                          style: grey1TextStyle.copyWith(fontSize: 16),
                        ),
                      ),
                      PopupMenuButton(
                          icon: Icon(Icons.more_vert),
                          onSelected: (newValue) async {
                            if (newValue == 1) {
                              hapusMyComment(comment[0].id);
                            }
                          },
                          itemBuilder: (_) => [
                                PopupMenuItem(
                                  child: Text("Hapus"),
                                  value: 1,
                                )
                              ])
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text(dateformat(comment[0].created)),
                      Transform.scale(
                        scale: 0.5,
                        origin: Offset(-84.0, 0),
                        child: RatingBar.builder(
                          initialRating: comment[0].rating,
                          minRating: 0,
                          direction: Axis.horizontal,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: yellow,
                          ),
                          onRatingUpdate: null,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    child: Text(
                      comment[0].message ?? "..",
                      style: grey1TextStyle.copyWith(fontSize: 16),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    }

    Widget noData() {
      return Center(
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 30, 0, 50),
          child: Text(
            "Belum ada komentar",
            style: grey1TextStyle,
          ),
        ),
      );
    }

    Widget dataKomentar(List<CommentModel> comment) {
      if (comment.length < 4) {
        return Container(
          margin: EdgeInsets.only(bottom: 24),
          child: Column(
            children: [
              Column(
                children: comment.map((e) => KomentarCard(e)).toList(),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AllComment(widget.destinasi.id.toString())));
                },
                child: Text(
                  "Lihat semua komentar",
                  style: blueTextStyle.copyWith(fontSize: 16),
                ),
              ),
            ],
          ),
        );
      } else {
        return Container(
          margin: EdgeInsets.only(bottom: 24),
          child: Column(
            children: [
              for (var i = 0; i < 4; i++) KomentarCard(comment[i]),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/semua-komentar');
                },
                child: Text(
                  "Lihat semua komentar",
                  style: blueTextStyle.copyWith(fontSize: 16),
                ),
              ),
            ],
          ),
        );
      }
    }

    Widget dataKomentarLoading() {
      return Container(
        margin: EdgeInsets.only(bottom: 24),
        child: Column(
          children: [
            for (var i = 1; i <= 3; i++) KomentarCardSkeleton(),
          ],
        ),
      );
    }

    Widget komentar() {
      return Container(
        margin: EdgeInsets.fromLTRB(24, 24, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Komentar",
              style: blackTextStyle.copyWith(fontSize: 20, fontWeight: medium),
            ),
            SizedBox(height: 16),
            BlocBuilder<CommentCubit, CommentState>(
              builder: (context, state) {
                if (state is CommentSuccess) {
                  if (state.comment.length == 0) return noData();
                  return dataKomentar(state.comment);
                }
                return dataKomentarLoading();
              },
            ),
          ],
        ),
      );
    }

    Widget pergiSekarang() {
      return GestureDetector(
        onTap: () {
          launchUrl(widget.destinasi.name);
        },
        behavior: HitTestBehavior.translucent,
        child: Container(
          margin: EdgeInsets.all(24),
          height: 55,
          width: double.infinity,
          decoration: BoxDecoration(
              color: blue, borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Text(
              "Pergi Sekarang",
              style: whiteTextStyle.copyWith(fontSize: 16),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              "Detail",
              style: blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: medium,
              ),
            ),
            centerTitle: true,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            floating: true,
            backgroundColor: Colors.white,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              detailImage(),
              title(),
              jamOperasional(),
              BlocBuilder<MycommentCubit, MycommentState>(
                builder: (context, state) {
                  if (state is MycommentSuccess) {
                    if (state.mycomment.length == 0) return nilaiTempatIni();
                    print("My comment berhasil");
                    return penilaianAnda(state.mycomment);
                  }

                  return nilaiTempatIni();
                },
              ),
              komentar(),
              pergiSekarang(),
            ]),
          ),
        ],
      ),
    );
  }
}
