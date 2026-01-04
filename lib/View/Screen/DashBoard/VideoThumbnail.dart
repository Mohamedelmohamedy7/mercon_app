import 'dart:typed_data';

import 'package:core_project/View/Widget/comman/comman_Image.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:flutter/material.dart';

Future<Uint8List?> generateThumbnail(String url) async {
  return await VideoThumbnail.thumbnailData(
    video: url,
    imageFormat: ImageFormat.PNG,
    maxWidth: 300,
    quality: 75,
  );
}

String? convertUrlToId(String url) {
  final Uri? uri = Uri.tryParse(url);
  if (uri == null) {
    return null;
  }
  // Check for standard URL with query parameter 'v'
  if (uri.queryParameters.containsKey('v')) {
    return uri.queryParameters['v'];
  }
  // Check for short URL format (youtu.be)
  if (uri.pathSegments.isNotEmpty) {
    return uri.pathSegments.first;
  }
  return null;
}

String getThumbnailUrl(String videoId, {String quality = 'mqdefault'}) {
  return 'https://img.youtube.com/vi/$videoId/0.jpg';
}

class YoutubeThumbnailWidget extends StatelessWidget {
  final String youtubeUrl;

  const YoutubeThumbnailWidget({Key? key, required this.youtubeUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String? videoId = convertUrlToId(youtubeUrl);

    if (videoId == null) {
      return Center(
          child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: cachedImage("assets/images/youtube.jpg",
            width: 160, fit: BoxFit.fill),
      ));
    }

    final String thumbnailUrl = getThumbnailUrl(videoId, quality: 'sddefault');

    return

      Container(
        width: 160,
        child: Stack(
          fit:
          StackFit.expand,
          children: [
          Image.network(
          thumbnailUrl,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(child: CircularProgressIndicator());
          },
          errorBuilder: (context, error, stackTrace) {
            return const Center(child: Icon(Icons.error));
          },
        ),
            const Center(
              child: Icon(
                Icons
                    .play_circle_fill,
                color: Colors
                    .white,
                size: 40,
              ),
            ),
          ],
        ),
      );

  }
}

// Helper functions (convertUrlToId and getThumbnailUrl) go here
