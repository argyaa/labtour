import 'package:flutter/material.dart';
import 'package:labtour/cubit/comment_cubit.dart';
import 'package:labtour/shared/theme.dart';
import 'package:labtour/view/widgets/komentar_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labtour/view/widgets/komentar_card_skeleton.dart';

class AllComment extends StatefulWidget {
  final String id;
  AllComment(this.id);

  @override
  _AllCommentState createState() => _AllCommentState();
}

class _AllCommentState extends State<AllComment> {
  @override
  void initState() {
    context.read<CommentCubit>().fetchComment(widget.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget komentar() {
      return BlocBuilder<CommentCubit, CommentState>(
        builder: (context, state) {
          if (state is CommentSuccess) {
            return Container(
              margin: EdgeInsets.all(24),
              child: Column(
                children: state.comment.map((e) => KomentarCard(e)).toList(),
              ),
            );
          }
          return Container(
            margin: EdgeInsets.all(24),
            child: Column(
              children:
                  [1, 2, 3, 4, 5].map((e) => KomentarCardSkeleton()).toList(),
            ),
          );
        },
      );
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Semua Komentar",
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
          backgroundColor: Colors.white,
        ),
        body: ListView(
          children: [
            komentar(),
          ],
        ));
  }
}
