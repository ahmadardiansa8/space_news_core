import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/article_model.dart';

class FavoriteService {

  Future<void> addFavorite(
      Article article) async {

    final uid =
        FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection("favorites")
        .add({

      "uid": uid,
      "articleId": article.id,
      "title": article.title,
      "imageUrl": article.imageUrl,
      "newsSite": article.newsSite,
      "summary": article.summary,
    });
  }
}