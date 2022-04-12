import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:labtour/models/comment_model.dart';
import 'package:labtour/models/user_model.dart';
import 'package:labtour/services/API/comment_service.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  CommentCubit() : super(CommentInitial());

  void fetchComment(String id) async {
    try {
      emit(CommentLoading());

      List<CommentModel> comment = await CommentService().fetchComment(id);

      emit(CommentSuccess(comment));
    } catch (e) {
      emit(CommentFailed(e.toString()));
    }
  }

  void addComment(
      {String id, String comment, double rating, UserModel user}) async {
    try {
      await CommentService()
          .addComment(id: id, comment: comment, rating: rating, user: user);
    } catch (e) {
      emit(CommentFailed(e.toString()));
    }
  }
}
