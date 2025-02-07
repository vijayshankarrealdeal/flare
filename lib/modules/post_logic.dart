import 'package:flutter/material.dart';
import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import '../models/post_model.dart';

class PostLogic with ChangeNotifier {
  final List<Post> _posts = [
    Post(
      username: 'user1',
      userAvatarUrl: 'https://via.placeholder.com/50',
      contentUrl:
          'https://images.pexels.com/photos/13727962/pexels-photo-13727962.jpeg?auto=compress&cs=tinysrgb&w=600',
      isVideo: false,
    ),
    Post(
      username: "user8",
      userAvatarUrl: 'https://via.placeholder.com/50',
      contentUrl:
          'https://videos.pexels.com/video-files/9710963/9710963-uhd_1440_2560_25fps.mp4',
      isVideo: true,
    ),
    Post(
      username: "user9",
      userAvatarUrl: 'https://via.placeholder.com/50',
      contentUrl:
          'https://videos.pexels.com/video-files/17147597/17147597-uhd_1440_2560_30fps.mp4',
      isVideo: true,
    ),
    Post(
      username: 'user2',
      userAvatarUrl: 'https://via.placeholder.com/50',
      contentUrl:
          'https://videos.pexels.com/video-files/4723044/4723044-hd_1080_1920_25fps.mp4',
      isVideo: true,
    ),
    Post(
      username: 'user3',
      userAvatarUrl: 'https://via.placeholder.com/50',
      contentUrl: 'https://via.placeholder.com/300/09f/fff.png',
      isVideo: false,
    ),
    Post(
      username: "user4",
      userAvatarUrl: 'https://via.placeholder.com/50',
      contentUrl:
          'https://www.dailyfunnyquote.com/wp-content/uploads/2018/12/24-best-Funny-Memes-images-and-Hilarious-Pictures-5.jpg',
      isVideo: false,
    ),
    Post(
      username: "user5",
      userAvatarUrl: 'https://via.placeholder.com/50',
      contentUrl:
          'https://www.dailyfunnyquote.com/wp-content/uploads/2018/12/24-best-Funny-Memes-images-and-Hilarious-Pictures-6.jpg',
      isVideo: false,
    ),
    Post(
      username: "user6",
      userAvatarUrl: 'https://via.placeholder.com/50',
      contentUrl:
          'https://videos.pexels.com/video-files/9165544/9165544-uhd_1440_2732_25fps.mp4',
      isVideo: true,
    ),
    Post(
      username: "user6",
      userAvatarUrl: 'https://via.placeholder.com/50',
      contentUrl:
          'https://images.pexels.com/photos/6983021/pexels-photo-6983021.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      isVideo: false,
    ),
    Post(
      username: "user6",
      userAvatarUrl: 'https://via.placeholder.com/50',
      contentUrl:
          'https://assets.mixkit.co/active_storage/video_items/100101/1720116057/100101-video-720.mp4',
      isVideo: true,
    ),
    Post(
      username: "user6",
      userAvatarUrl: 'https://via.placeholder.com/50',
      contentUrl:
          'https://videos.pexels.com/video-files/9745723/9745723-uhd_1440_2732_25fps.mp4',
      isVideo: true,
    ),
  ];

  /// Maximum number of active video controllers
  static const int _maxActiveControllers = 2;

  /// A map of contentUrl -> CachedVideoPlayerPlusController
  final Map<String, CachedVideoPlayerPlusController> _cachedControllers = {};

  /// Track last usage time for each controller, so we can remove the least recently used
  final Map<String, DateTime> _lastUsedTime = {};

  List<Post> get posts => _posts;

  bool hasController(String contentUrl) {
    return _cachedControllers.containsKey(contentUrl);
  }

  CachedVideoPlayerPlusController? getController(String contentUrl) {
    return _cachedControllers[contentUrl];
  }

  Future<CachedVideoPlayerPlusController?> initVideoController(
      Post post) async {
    if (!post.isVideo) return null;

    // Already exists?
    if (_cachedControllers.containsKey(post.contentUrl)) {
      _updateUsage(post.contentUrl);
      return _cachedControllers[post.contentUrl];
    }

    try {
      final controller = CachedVideoPlayerPlusController.networkUrl(
        Uri.parse(post.contentUrl),
        invalidateCacheIfOlderThan: const Duration(days: 30),
        videoPlayerOptions: VideoPlayerOptions(),
      );

      await controller.initialize();
      await controller.setLooping(true);

      _cachedControllers[post.contentUrl] = controller;
      _updateUsage(post.contentUrl);
      _cleanupExcessControllers();

      notifyListeners();
      return controller;
    } catch (e) {
      // Handle errors gracefully (network issues, etc.)
      debugPrint('Error initializing video: $e');
      return null;
    }
  }

  Future<void> playVideo(String contentUrl) async {
    final controller = _cachedControllers[contentUrl];
    if (controller == null) return;
    _updateUsage(contentUrl);

    try {
      if (!controller.value.isPlaying) {
        await controller.play();
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error playing video: $e');
    }
  }

  Future<void> pauseVideo(String contentUrl) async {
    final controller = _cachedControllers[contentUrl];
    if (controller == null) return;
    _updateUsage(contentUrl);

    try {
      if (controller.value.isPlaying) {
        await controller.pause();
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error pausing video: $e');
    }
  }

  /// Dispose a specific controller
  void disposeController(String contentUrl) {
    if (_cachedControllers.containsKey(contentUrl)) {
      try {
        _cachedControllers[contentUrl]?.dispose();
      } catch (e) {
        debugPrint('Error disposing video: $e');
      }
      _cachedControllers.remove(contentUrl);
      _lastUsedTime.remove(contentUrl);
      notifyListeners();
    }
  }

  /// Dispose ALL controllers
  void disposeAll() {
    for (var controller in _cachedControllers.values) {
      try {
        controller.dispose();
      } catch (e) {
        debugPrint('Error disposing video: $e');
      }
    }
    _cachedControllers.clear();
    _lastUsedTime.clear();
    notifyListeners();
  }

  /// Dispose controllers not in [indexes], e.g., for pages that are not visible
  void disposeControllersNotIn(List<int> visibleIndexes) {
    // Collect contentUrl from the posts that are still visible
    final visibleUrls = visibleIndexes
        .where((i) => i >= 0 && i < _posts.length)
        .map((i) => _posts[i].contentUrl)
        .toSet();

    // Any controller not in visibleUrls => dispose
    final keysToRemove = _cachedControllers.keys
        .where((key) => !visibleUrls.contains(key))
        .toList();

    for (final k in keysToRemove) {
      disposeController(k);
    }
  }

  /// Record that a controller was used
  void _updateUsage(String contentUrl) {
    _lastUsedTime[contentUrl] = DateTime.now();
  }

  /// If we exceed _maxActiveControllers, dispose the least recently used ones
  void _cleanupExcessControllers() {
    if (_cachedControllers.length <= _maxActiveControllers) return;

    // Sort by usage time ascending (oldest used first)
    final sortedByOldest = _lastUsedTime.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));

    final excessCount = _cachedControllers.length - _maxActiveControllers;
    for (int i = 0; i < excessCount; i++) {
      final oldestKey = sortedByOldest[i].key;
      disposeController(oldestKey);
    }
  }
}
