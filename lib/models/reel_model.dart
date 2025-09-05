import 'user_model.dart';

class Reel {
  final String id;
  final User user;
  final String videoUrl;
  final String thumbnailUrl;
  final String caption;
  final String audio;
  final int likes;
  final int comments;
  final int shares;
  final DateTime createdAt;
  
  Reel({
    required this.id,
    required this.user,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.caption,
    required this.audio,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.createdAt,
  });
}
