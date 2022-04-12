import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:labtour/cubit/auth_cubit.dart';
import 'package:labtour/cubit/comment_cubit.dart';
import 'package:labtour/cubit/mycomment_cubit.dart';
import 'package:labtour/shared/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class AddComment extends StatefulWidget {
  final String name, id;
  final double rating;
  AddComment({this.name, this.id, this.rating = 0.0});

  @override
  _AddCommentState createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {
  double tempRating;
  TextEditingController commentController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    showAlertDialog() {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Buang draf?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text('Buang'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          (widget.name.length >= 20)
              ? widget.name.substring(0, 20) + "..."
              : widget.name,
          style: blackTextStyle,
        ),
        leading: IconButton(
          icon: Icon(Icons.close, color: black),
          onPressed: () {
            showAlertDialog();
          },
        ),
        elevation: 0,
        actions: [
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is AuthSuccess) {
                return TextButton(
                  onPressed: () async {
                    context.read<CommentCubit>().addComment(
                          id: widget.id,
                          comment: commentController.text,
                          rating: tempRating ?? widget.rating,
                          user: state.user,
                        );
                    context.read<MycommentCubit>().fetchmycomment(
                          id: widget.id,
                          userId: state.user.id,
                        );
                    context.read<CommentCubit>().fetchComment(widget.id);
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Kirim",
                    style: blueTextStyle.copyWith(fontSize: 16),
                  ),
                );
              }

              return TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                },
                child: Text(
                  "Kirim",
                  style: blueTextStyle.copyWith(fontSize: 16),
                ),
              );
            },
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(24, 24, 24, 0),
        child: Column(
          children: [
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is AuthSuccess) {
                  return Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(state.user.image),
                      ),
                      SizedBox(width: 16),
                      Text(
                        state.user.username,
                        style: grey1TextStyle.copyWith(fontSize: 16),
                      ),
                    ],
                  );
                }
                return Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          "https://reqres.in/img/faces/1-image.jpg"),
                    ),
                    SizedBox(width: 16),
                    Text(
                      "M Khatami",
                      style: grey1TextStyle.copyWith(fontSize: 16),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 24),
            Center(
              child: RatingBar.builder(
                initialRating: widget.rating,
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
                  setState(() {
                    tempRating = rating;
                  });
                },
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 32, 0, 0),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: grey1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextFormField(
                controller: commentController,
                autofocus: true,
                maxLines: 8,
                decoration: InputDecoration.collapsed(
                    hintText: "Ceritakan pengalaman anda"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
