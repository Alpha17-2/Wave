import 'package:flutter/material.dart';

class PostModel {
  final String caption;
  final String image;
  final String uid;
  final String post_id;
  final List<String> likes;
  final List<dynamic> comments;

  PostModel(
      {required this.caption,
      required this.image,
      required this.comments,
      required this.uid,
      required this.post_id,
      required this.likes});

  Map<String, dynamic> toJson() {
    return {
      'caption': caption,
      'image': image,
      'uid': uid,
      'post_uid': post_id,
      'likes': likes,
      'comments': comments, 
    };
  }
}