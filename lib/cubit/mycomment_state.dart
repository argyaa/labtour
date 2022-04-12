part of 'mycomment_cubit.dart';

abstract class MycommentState extends Equatable {
  const MycommentState();

  @override
  List<Object> get props => [];
}

class MycommentInitial extends MycommentState {}

class MycommentLoading extends MycommentState {}

class MycommentSuccess extends MycommentState {
  final List<CommentModel> mycomment;

  MycommentSuccess(this.mycomment);

  List<Object> get props => [mycomment];
}

class MycommentFailed extends MycommentState {
  final String error;
  MycommentFailed(this.error);

  @override
  List<Object> get props => [error];
}
