import 'package:flutter/material.dart';
import 'package:labtour/cubit/search_history_cubit.dart';
import 'package:labtour/cubit/searchbox_cubit.dart';
import 'package:labtour/shared/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labtour/view/pages/result_search_page.dart';
import 'package:labtour/view/widgets/list_tile_search_item.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController =
      TextEditingController(text: '');

  @override
  void initState() {
    context.read<SearchHistoryCubit>().fetchHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var state = context.watch<SearchboxCubit>().state;

    void clearText() {
      context.read<SearchboxCubit>().setText("");
      searchController.text = "";
    }

    Widget noData() {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            Image.asset(
              'assets/image_nodata.png',
              width: 200,
              height: 165,
            ),
            SizedBox(height: 24),
            Text(
              "Belum ada Pencarian",
              style: grey2TextStyle.copyWith(fontSize: 20),
            ),
          ],
        ),
      );
    }

    Widget searchBox() {
      return Container(
        margin: EdgeInsets.fromLTRB(24, 30, 24, 0),
        padding: EdgeInsets.all(12),
        height: 56,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Image.asset('assets/icon_search.png', width: 24, height: 24),
            SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                controller: searchController,
                autofocus: true,
                textInputAction: TextInputAction.search,
                style: blackTextStyle.copyWith(fontSize: 16),
                decoration: InputDecoration.collapsed(
                    hintText: 'Search Classic Style',
                    hintStyle: grey1TextStyle.copyWith(fontSize: 14)),
                onChanged: (value) {
                  context.read<SearchboxCubit>().setText(value);
                },
                onFieldSubmitted: (value) {
                  print("Controller ${searchController.text}");
                  context
                      .read<SearchHistoryCubit>()
                      .insertHistory(searchController.text);
                  context.read<SearchHistoryCubit>().fetchHistory();
                  clearText();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResultSearchPage(value)));
                },
              ),
            ),
            SizedBox(width: 10),
            state.length > 0
                ? IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      clearText();
                    })
                : Container(),
          ],
        ),
      );
    }

    Widget historyData() {
      return Container(
        margin: EdgeInsets.fromLTRB(24, 24, 24, 0),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Pencarian Terakhir Anda",
                style: grey1TextStyle.copyWith(fontSize: 16)),
            SizedBox(height: 16),
            BlocBuilder<SearchHistoryCubit, SearchHistoryState>(
              builder: (context, state) {
                if (state is SearchHistorySuccess) {
                  if (state.history.length == 0) return noData();
                  if (state.history.length < 6) {
                    return Column(
                        children: state.history
                            .map((e) => ListTileSearch(e))
                            .toList());
                  } else {
                    return Column(
                      children: [
                        for (var i = 0; i <= 5; i++)
                          ListTileSearch(state.history[i]),
                      ],
                    );
                  }
                }

                return Center(child: CircularProgressIndicator());
              },
            )
          ],
        ),
      );
    }

    return ListView(
      children: [
        searchBox(),
        historyData(),
      ],
    );
  }
}
