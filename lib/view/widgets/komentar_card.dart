import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:labtour/models/comment_model.dart';
import 'package:labtour/shared/theme.dart';
import 'package:intl/intl.dart';

class KomentarCard extends StatelessWidget {
  final CommentModel comment;
  KomentarCard(this.comment);

  String dateformat(DateTime time) {
    var newFormat = DateFormat("dd/MM/yyyy");
    String updatedDt = newFormat.format(time);
    return updatedDt;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 24),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(comment.user.image),
              ),
              SizedBox(width: 16),
              Text(
                comment.user.username,
                style: grey1TextStyle.copyWith(fontSize: 16),
              )
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Text(dateformat(comment.created)),
              Transform.scale(
                scale: 0.5,
                origin: Offset(-84.0, 0),
                child: RatingBar.builder(
                  initialRating: comment.rating,
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
              comment.message ?? "..",
              style: grey1TextStyle.copyWith(fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
