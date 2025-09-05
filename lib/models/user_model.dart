class User {
  final String id;
  final String username;
  final String name;
  final String profileImageUrl;
  final String bio;
  final int posts;
  final int followers;
  final int following;
  final bool isVerified;

  User({
    required this.id,
    required this.username,
    required this.name,
    required this.profileImageUrl,
    required this.bio,
    required this.posts,
    required this.followers,
    required this.following,
    this.isVerified = false,
  });
}
