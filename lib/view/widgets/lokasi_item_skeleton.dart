import 'package:flutter/material.dart';
import 'package:labtour/shared/theme.dart';

class LokasiItemSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: loading,
            child: Text(
              "tessssssssssssst",
              style: TextStyle(
                color: Colors.transparent,
              ),
            ),
          ),
          SizedBox(height: 8),
          Divider(),
        ],
      ),
    );
  }
}
