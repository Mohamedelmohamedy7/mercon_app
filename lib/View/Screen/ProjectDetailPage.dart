import 'package:core_project/View/Widget/comman/comman_Image.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../../helper/ImagesConstant.dart';
import '../../helper/text_style.dart';
import '../Widget/comman/CustomAppBar.dart';
import 'DashBoard/DashBoardSCreen.dart';
import 'DashBoard/HomeScreen.dart';

class ProjectDetailPage extends StatefulWidget {
  final Project project;
  final String videoId; // YouTube video id

  const ProjectDetailPage(
      {super.key, required this.project, required this.videoId});

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController.fromVideoId(
      videoId: widget.videoId,
      params: const YoutubePlayerParams(
        origin: "https://www.youtube-nocookie.com",
        mute: false,
        showControls: true,
        showFullscreenButton: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final details = widget.project.details;

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: callCenterBottom(context),
        backgroundColor: Colors.grey[100],
        appBar: CustomAppBar(
          needBack: true,
          title: widget.project.title,
          fontSize: 16,
          backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // YouTube Video

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.32,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.project.images.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {

                      _controller = YoutubePlayerController.fromVideoId(
                        videoId: widget.videoId,
                        params: const YoutubePlayerParams(
                          origin: "https://www.youtube-nocookie.com",
                          mute: false,
                          showControls: true,
                          showFullscreenButton: true,
                        ),
                      );
                      return _buildVideoItem(context);
                    }
                    final imageUrl = widget.project.images[index - 1];
                    return _buildImageItem(imageUrl);
                  },
                ),
              ),

              // ClipRRect(
              //   borderRadius: BorderRadius.circular(12),
              //   child: SizedBox(
              //     width: double.infinity,
              //     height: MediaQuery.of(context).size.height * 0.35,
              //     child: YoutubePlayer(
              //       controller: _controller,
              //       aspectRatio: 16 / 9,
              //     ),
              //   ),
              // ),
              const SizedBox(height: 16),

              // Description
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 0,
                margin: const EdgeInsets.symmetric(vertical: 1),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    widget.project.desc,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ),
              ),

              const SizedBox(height: 5),

              // Location & Type
              if (details.location != null || details.type != null)
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (details.location != null)
                          Row(
                            children: [
                              Icon(Icons.location_on,
                                  size: 18,
                                  color: Theme.of(context).primaryColor),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  details.location!,
                                  style: const TextStyle(
                                      fontSize: 13, color: Colors.black54),
                                ),
                              ),
                            ],
                          ),
                        if (details.type != null) const SizedBox(height: 4),
                        if (details.type != null)
                          Row(
                            children: [
                              Icon(Icons.business_center,
                                  size: 18,
                                  color: Theme.of(context).primaryColor),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  details.type!,
                                  style: const TextStyle(
                                      fontSize: 13, color: Colors.black54),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),

              const SizedBox(height: 5),

              // Optional Details
              if ([
                details.size,
                details.area,
                details.units,
                details.investment,
                details.greenSpaces
              ].any((element) => element != null))
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Details",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          if (details.size != null)
                            Text("Size: ${details.size!}",
                                style: const TextStyle(fontSize: 13)),
                          if (details.area != null)
                            Text("Area: ${details.area!}",
                                style: const TextStyle(fontSize: 13)),
                          if (details.units != null)
                            Text("Units: ${details.units!}",
                                style: const TextStyle(fontSize: 13)),
                          if (details.investment != null)
                            Text("Investment: ${details.investment!}",
                                style: const TextStyle(fontSize: 13)),
                          if (details.greenSpaces != null)
                            Text("Green Spaces: ${details.greenSpaces!}",
                                style: const TextStyle(fontSize: 13)),
                        ],
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 16),

              // Partners
              if (details.partners != null && details.partners!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Partners",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    SizedBox(
                      height: 36,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: details.partners!.length,
                        itemBuilder: (_, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: Chip(
                              label: Text(details.partners![index],
                                  style: CustomTextStyle.semiBold12Black
                                      .copyWith(
                                          fontSize: 12,
                                          color:
                                              Theme.of(context).primaryColor)),
                              avatar: Icon(Icons.business,
                                  size: 16,
                                  color: Theme.of(context).primaryColor),
                              side: BorderSide(
                                  color: Theme.of(context).primaryColor),
                              backgroundColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.3),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),

              const SizedBox(height: 16),

              // Features
              if (details.features != null && details.features!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Features",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    SizedBox(
                      height: 36,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: details.features!.length,
                        itemBuilder: (_, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: Chip(
                              avatar: Icon(Icons.check_circle,
                                  size: 16,
                                  color: Theme.of(context).primaryColor),
                              label: Text(details.features![index],
                                  style: CustomTextStyle.semiBold12Black
                                      .copyWith(
                                          fontSize: 12,
                                          color:
                                              Theme.of(context).primaryColor)),
                              side: BorderSide(
                                  color: Theme.of(context).primaryColor),
                              backgroundColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.3),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),

              const SizedBox(height: 16),

              // Amenities
              if (details.amenities != null && details.amenities!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Amenities",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    SizedBox(
                      height: 36,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: details.amenities!.length,
                        itemBuilder: (_, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: Chip(
                              avatar: Icon(Icons.star,
                                  size: 16,
                                  color: Theme.of(context).primaryColor),
                              label: Text(details.amenities![index],
                                  style: CustomTextStyle.semiBold12Black
                                      .copyWith(
                                          fontSize: 12,
                                          color:
                                              Theme.of(context).primaryColor)),
                              side: BorderSide(
                                  color: Theme.of(context).primaryColor),
                              backgroundColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.3),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageItem(String imageUrl) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: cachedImage(
          imageUrl,
          width: 260,
          fit: BoxFit.cover,

        ),
      ),
    );
  }
  //
  // Widget _buildVideoItem(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.only(right: 12),
  //     child: ClipRRect(
  //       borderRadius: BorderRadius.circular(12),
  //       child: SizedBox(
  //         width: MediaQuery.of(context).size.width * 0.8,
  //         child: YoutubePlayer(
  //           controller: _controller,
  //           aspectRatio: 16 / 9,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildVideoItem(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: RepaintBoundary(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: YoutubePlayer(
              controller: _controller,
              aspectRatio: 16 / 9,
            ),
          ),
        ),
      ),
    );
  }

}
