import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:labtour/models/user_model.dart';

class CommentModel {
  String id;
  String message;
  double rating;
  DateTime created;
  int userId;
  UserModel user;

  CommentModel(
      {this.message,
      this.created,
      this.rating,
      this.id,
      this.user,
      this.userId});

  CommentModel.fromJson(String id, Map<String, dynamic> json) {
    this.id = id;
    message = json['message'];
    created = (json['created'] as Timestamp).toDate();
    userId = json['user_id'];
    rating = json['rating'];
    user = UserModel.fromJson(json['user']);
  }
}
