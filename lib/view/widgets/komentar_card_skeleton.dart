import 'package:flutter/material.dart';
import 'package:labtour/shared/theme.dart';

class KomentarCardSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 24),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: loading,
              ),
              SizedBox(width: 16),
              Container(
                color: loading,
                child: Text(
                  "M Khatamiii",
                  style: TextStyle(color: Colors.transparent),
                ),
              )
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Container(
                color: loading,
                child: Text(
                  "27/12/2021.............................",
                  style: TextStyle(color: Colors.transparent),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Container(
            color: loading,
            width: double.infinity,
            child: Text(
              "Tempat yang menarik untuk refreshing bersama keluarga",
              style: TextStyle(color: Colors.transparent),
            ),
          )
        ],
      ),
    );
  }
}
