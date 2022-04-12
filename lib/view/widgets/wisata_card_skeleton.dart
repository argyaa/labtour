import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labtour/shared/theme.dart';

class WisataCardSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 24),
      child: Row(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.18,
            width: MediaQuery.of(context).size.width * 0.33,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: loading),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: loading,
                child: Text(
                  "testtttttttt",
                  style: TextStyle(color: Colors.transparent),
                ),
              ),
              SizedBox(height: 4),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                color: loading,
                child: Text(
                  "destinasi.name",
                  style: TextStyle(color: Colors.transparent, fontSize: 18),
                ),
              ),
              SizedBox(height: 8),
              Container(
                color: loading,
                child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.transparent,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "4.9",
                      style: TextStyle(color: Colors.transparent),
                    ),
                    SizedBox(width: 6),
                    CircleAvatar(
                      radius: 2,
                      backgroundColor: Colors.transparent,
                    ),
                    SizedBox(width: 6),
                    Text(
                      "destinasi",
                      style: TextStyle(color: Colors.transparent),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          )
        ],
      ),
    );
  }
}
