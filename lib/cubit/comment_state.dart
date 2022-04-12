part of 'comment_cubit.dart';

abstract class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object> get props => [];
}

class CommentInitial extends CommentState {}

class CommentLoading extends CommentState {}

class CommentSuccess extends CommentState {
  final List<CommentModel> comment;

  CommentSuccess(this.comment);

  List<Object> get props => [comment];
}

class CommentFailed extends CommentState {
  final String error;
  CommentFailed(this.error);

  @override
  List<Object> get props => [error];
}
