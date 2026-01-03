import 'package:core_project/View/Widget/comman/comman_Image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube_view/flutter_youtube_view.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import 'Model/HomeComponantModel/NewsModel.dart';
import 'Utill/Comman.dart';
import 'View/Screen/DashBoard/DashBoardSCreen.dart';
import 'View/Widget/HomeWidgets/NewsWidget.dart';
import 'helper/date_converter.dart';
import 'helper/text_style.dart';

class ShowNewsDetials extends StatefulWidget {
  final NewsModel newsModel;

  const ShowNewsDetials({super.key, required this.newsModel});

  @override
  State<ShowNewsDetials> createState() => _ShowNewsDetialsState();
}

class _ShowNewsDetialsState extends State<ShowNewsDetials> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
     _controller = YoutubePlayerController.fromVideoId(
      videoId: widget.newsModel.videoUrl!
          .replaceFirst("https://www.youtube.com/watch?v=", ""),
      params: const YoutubePlayerParams(
        origin: "https://www.youtube-nocookie.com",
        mute: false,
        showControls: true,
        showFullscreenButton: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEn = condation(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      bottomNavigationBar: callCenterBottom(context),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight:widget.newsModel.videoUrl?.isEmpty == true ? 300 : 0,
            pinned: true,
            backgroundColor: Colors.black,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace:widget.newsModel.videoUrl?.isEmpty == true ? FlexibleSpaceBar(
              background: cachedImage(
              widget.newsModel.imageUrl,
              fit: BoxFit.cover
                              ),
            ):SizedBox(),
          ),
          SliverToBoxAdapter(
            child: widget.newsModel.videoUrl != null && widget.newsModel.videoUrl!.isNotEmpty
                ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: YoutubePlayer(
                controller: _controller,
                aspectRatio: 16 / 9,
              ),
            )
                : SizedBox.shrink(),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                        SizedBox(width: 6),
                        Text(formatDate(widget.newsModel.createdDate ?? ""),
                            style: secondaryTextStyle(size: 12)),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      isEn ? widget.newsModel.descriptionEn : widget.newsModel.descriptionAr,
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
