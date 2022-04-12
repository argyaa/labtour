import 'package:flutter/material.dart';
import 'package:labtour/shared/theme.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TipsPage extends StatefulWidget {
  @override
  _TipsPageState createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Tips Bepergian",
          style: blackTextStyle,
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: WebView(
        initialUrl:
            'https://amari.itb.ac.id/10-tips-aman-melakukan-perjalanan-di-masa-pandemi-pengendara-kendaraan-pribadi-dan-penumpang-shuttle-wajib-tahu/',
      ),
    );
  }
}
