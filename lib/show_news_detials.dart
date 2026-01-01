import 'package:core_project/View/Widget/comman/comman_Image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube_view/flutter_youtube_view.dart';
import 'package:nb_utils/nb_utils.dart';

import 'Model/HomeComponantModel/NewsModel.dart';
import 'Utill/Comman.dart';
import 'View/Screen/DashBoard/DashBoardSCreen.dart';
import 'View/Widget/HomeWidgets/NewsWidget.dart';
import 'helper/date_converter.dart';
import 'helper/text_style.dart';

class ShowNewsDetials extends StatelessWidget {
  final NewsModel newsModel;

  const ShowNewsDetials({super.key, required this.newsModel});

  @override
  Widget build(BuildContext context) {
    final isEn = condation(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      body: CustomScrollView(
        slivers: [
          /// ===== HERO SECTION =====
          SliverAppBar(
            expandedHeight: 320,
            pinned: true,
            backgroundColor: Colors.black,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  newsModel.videoUrl != ""
                      ? FlutterYoutubeView(
                    scaleMode: YoutubeScaleMode.fitWidth,
                    params: YoutubeParam(
                      videoId: extractYouTubeVideoId(newsModel.videoUrl ?? ""),
                      autoPlay: false,
                      showUI: true,
                    ),
                  )
                      : cachedImage(
                    newsModel.imageUrl,
                    fit: BoxFit.cover,
                  ),

                  /// Gradient Overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.2),
                          Colors.black.withOpacity(0.8),
                        ],
                      ),
                    ),
                  ),

                  /// Title
                  Positioned(
                    bottom: 20,
                    left: 16,
                    right: 16,
                    child: Text(
                      isEn ? newsModel.nameEn : newsModel.nameAr,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyle.bold14White.copyWith(
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          /// ===== CONTENT =====
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Date (اختياري)
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                        const SizedBox(width: 6),
                        Text(
                          formatDate(newsModel?.createdDate??"").toString(),
                          style: secondaryTextStyle(size: 12),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    /// Description
                    Text(
                      isEn ? newsModel.descriptionEn : newsModel.descriptionAr,
                      style: CustomTextStyle.regular14Black.copyWith(
                        height: 1.8,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String formatDate(String dateString) {
  final date = DateTime.parse(dateString);

  return "${date.day}/${date.month}/${date.year}";
}
