import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:labtour/cubit/page_cubit.dart';
import 'package:labtour/shared/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabItem extends StatelessWidget {
  final String icon, detail;
  final int index;
  TabItem({this.icon, this.detail, this.index});
  @override
  Widget build(BuildContext context) {
    var state = context.watch<PageCubit>().state;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              color: state == index ? blue : grey1,
              width: 20,
            ),
            SizedBox(height: 3),
            Text(
              detail,
              style: GoogleFonts.dmSans(
                color: state == index ? blue : grey1,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            )
          ],
        ),
      ),
      onTap: () {
        context.read<PageCubit>().setPage(index);
      },
    );
  }
}
