import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../models/post_model.dart';
import '../modules/post_logic.dart';
import 'package:cached_video_player_plus/cached_video_player_plus.dart';

class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostLogic>(context, listen: false);

    return VisibilityDetector(
      key: Key(post.contentUrl),
      onVisibilityChanged: (visibilityInfo) async {
        if (!post.isVideo) return;
        final fractionVisible = visibilityInfo.visibleFraction;

        // Safety check to ensure the controller still exists
        if (!postProvider.hasController(post.contentUrl)) {
          return;
        }
        if (fractionVisible > 0.6) {
          // If largely visible, play
          await postProvider.playVideo(post.contentUrl);
        } else {
          // Partially visible => pause
          await postProvider.pauseVideo(post.contentUrl);
        }
      },
      child: Consumer<PostLogic>(
        builder: (context, provider, child) {
          final controller = provider.getController(post.contentUrl);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1) User info row
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(
                            post.userAvatarUrl,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(post.username),
                            Text(
                              post.username,
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Icon(CupertinoIcons.ellipsis_vertical),
                  ],
                ),
              ),
              // 2) The main content (video or image)
              Expanded(
                child: Stack(
                  fit: StackFit.loose,
                  children: [
                    Center(
                      child: post.isVideo
                          ? AspectRatio(
                              aspectRatio: _getAspectRatio(post, controller),
                              child: _buildVideoPlayer(controller))
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                child: CachedNetworkImage(
                                  fit: BoxFit.fitWidth,
                                  imageUrl: post.contentUrl,
                                ),
                              ),
                            ),
                    ),
                    const Positioned(
                      bottom: 12,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(CupertinoIcons.heart),
                            SizedBox(width: 16),
                            Icon(CupertinoIcons.chat_bubble),
                            SizedBox(width: 16),
                            Icon(CupertinoIcons.link),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // 3) Some action icons

              // // 4) Caption / other text
              // const Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 8.0),
              //   child: Text("Caption or description goes here..."),
              // ),
              // const Divider(thickness: 1),
            ],
          );
        },
      ),
    );
  }

  Widget _buildVideoPlayer(CachedVideoPlayerPlusController? controller) {
    if (controller == null) {
      // Not yet initialized or was disposed
      return const Center(child: CircularProgressIndicator());
    }
    if (!controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }
    return CachedVideoPlayerPlus(controller);
  }

  double _getAspectRatio(
      Post post, CachedVideoPlayerPlusController? controller) {
    // Use the actual video aspect ratio if available
    if (post.isVideo && controller != null && controller.value.isInitialized) {
      return controller.value.aspectRatio;
    }
    // Default 1:1 if it's an image or video not yet initialized
    return 1.0;
  }
}
