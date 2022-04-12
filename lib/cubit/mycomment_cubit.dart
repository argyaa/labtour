import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:labtour/models/comment_model.dart';
import 'package:labtour/services/API/comment_service.dart';

part 'mycomment_state.dart';

class MycommentCubit extends Cubit<MycommentState> {
  MycommentCubit() : super(MycommentInitial());

  void fetchmycomment({String id, int userId}) async {
    try {
      emit(MycommentLoading());

      List<CommentModel> mycomment =
          await CommentService().fetchMyComment(id, userId);

      emit(MycommentSuccess(mycomment));
    } catch (e) {
      emit(MycommentFailed(e.toString()));
    }
  }

  void deleteMyComment({String id, String docId}) async {
    try {
      await CommentService().deleteMycomment(id, docId);
      emit(MycommentInitial());
    } catch (e) {
      emit(MycommentFailed(e.toString()));
    }
  }
}
