import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:labtour/models/comment_model.dart';
import 'package:labtour/models/user_model.dart';

class CommentService {
  CollectionReference _commentRef =
      FirebaseFirestore.instance.collection('comments');

  Future<List<CommentModel>> fetchComment(String id) async {
    try {
      QuerySnapshot result = await _commentRef
          .doc(id)
          .collection('review')
          .orderBy('created', descending: true)
          .get();

      List<CommentModel> comment = result.docs.map((e) {
        return CommentModel.fromJson(e.id, e.data());
      }).toList();

      return comment;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<List<CommentModel>> fetchMyComment(String id, int userId) async {
    try {
      QuerySnapshot result = await _commentRef
          .doc(id)
          .collection('review')
          .where('user_id', isEqualTo: userId)
          .get();

      print(result);

      List<CommentModel> comment = result.docs.map((e) {
        return CommentModel.fromJson(e.id, e.data());
      }).toList();
      return comment;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<void> deleteMycomment(String id, String docId) async {
    try {
      await _commentRef.doc(id).collection('review').doc(docId).delete();
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<void> addComment(
      {String id, String comment, double rating, UserModel user}) async {
    try {
      await _commentRef.doc(id).collection('review').add({
        'message': comment,
        'rating': rating,
        'user_id': user.id,
        'user': user.toJson(),
        'created': Timestamp.now(),
      });
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
