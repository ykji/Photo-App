import 'dart:io';

import 'package:hive/hive.dart';
import 'package:photo_app_assignment/utils/string_values.dart';

part 'image_post.g.dart';
// g is generator

@HiveType(typeId: 0)  

class ImagePost {
  // data members
  @HiveField(0)
  String _imagePath;
  @HiveField(1)
  int _likes;
  @HiveField(2)
  List<String> _comments;
  @HiveField(3)
  bool _showComments;
  @HiveField(4)
  bool _typeComment;

  //constructors
  ImagePost(this._imagePath, this._likes, this._comments, this._showComments,
      this._typeComment);

  // getters
  String get image => _imagePath;
  int get likes => _likes;
  List<String> get comments => _comments;
  bool get showComments => _showComments;
  bool get typeComment => _typeComment;

  // setters
  set likes(x) {
    this._likes = x;
  }

  set typeComment(x) {
    this._typeComment = x;
  }

  set showComments(x) {
    this._showComments = x;
  }

}
