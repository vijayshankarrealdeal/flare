class Post {
  final String username;
  final String userAvatarUrl;
  final String contentUrl; // Could be image or video
  final bool isVideo;

  Post({
    required this.username,
    required this.userAvatarUrl,
    required this.contentUrl,
    required this.isVideo,
  });
}