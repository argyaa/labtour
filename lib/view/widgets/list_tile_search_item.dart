import 'package:flutter/material.dart';
import 'package:labtour/cubit/search_history_cubit.dart';
import 'package:labtour/models/search_history_model.dart';
import 'package:labtour/shared/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labtour/view/pages/result_search_page.dart';

class ListTileSearch extends StatelessWidget {
  final SearchHistoryModel history;
  ListTileSearch(this.history);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ResultSearchPage(history.title)));
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        child: Row(
          children: [
            Expanded(
              child: Text(
                history.title,
                style: blackTextStyle.copyWith(fontSize: 16),
              ),
            ),
            IconButton(
                icon: Icon(
                  Icons.close,
                  size: 20,
                ),
                onPressed: () {
                  context.read<SearchHistoryCubit>().deleteHistory(history.id);
                  context.read<SearchHistoryCubit>().fetchHistory();
                })
          ],
        ),
      ),
    );
  }
}
