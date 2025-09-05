import 'user_model.dart';

class Post {
  final String id;
  final User user;
  final String imageUrl;
  final String caption;
  final DateTime createdAt;
  final int likes;
  final int comments;
  final List<String> hashtags;
  final String location;
  final bool isSaved;

  Post({
    required this.id,
    required this.user,
    required this.imageUrl,
    required this.caption,
    required this.createdAt,
    required this.likes,
    required this.comments,
    this.hashtags = const [],
    this.location = '',
    this.isSaved = false,
  });
}
