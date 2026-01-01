// import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:core_project/View/Screen/Services/ServicesCategories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_youtube_view/flutter_youtube_view.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../../Provider/HomeProvider.dart';
import '../../../Utill/Comman.dart';
import '../../../helper/EnumLoading.dart';
import '../../../helper/text_style.dart';
import '../../../show_news_detials.dart';
import '../comman/comman_Image.dart';

class NewsWidget extends StatefulWidget {
  const NewsWidget({
    super.key,
  });

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  // late CachedVideoPlayerController _videoPlayerController,
  //     _videoPlayerController2,
  //     _videoPlayerController3;
  //
  // late CustomVideoPlayerController _customVideoPlayerController;
  // late CustomVideoPlayerWebController _customVideoPlayerWebController;
  //
  // final CustomVideoPlayerSettings _customVideoPlayerSettings =
  // const CustomVideoPlayerSettings(showSeekButtons: true);
  // String videoUrlLandscape =
  //     "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4";
  // String videoUrlPortrait =
  //     'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4';
  // String longVideo =
  //     "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";
  //
  // String video720 =
  //     "https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_10mb.mp4";
  //
  // String video480 =
  //     "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4";
  //
  // String video240 =
  //     "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4";
  // final CustomVideoPlayerWebSettings _customVideoPlayerWebSettings =
  // CustomVideoPlayerWebSettings(
  //   src: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
  // );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _videoPlayerController = CachedVideoPlayerController.network(
    //   longVideo,
    // )..initialize().then((value) => setState(() {}));
    // _videoPlayerController2 = CachedVideoPlayerController.network(video240);
    // _videoPlayerController3 = CachedVideoPlayerController.network(video480);
    // _customVideoPlayerController = CustomVideoPlayerController(
    //   context: context,
    //   videoPlayerController: _videoPlayerController,
    //   customVideoPlayerSettings: _customVideoPlayerSettings,
    //   additionalVideoSources: {
    //     "240p": _videoPlayerController2,
    //     "480p": _videoPlayerController3,
    //     "720p": _videoPlayerController,
    //   },
    // );
    //
    // _customVideoPlayerWebController = CustomVideoPlayerWebController(
    //   webVideoPlayerSettings: _customVideoPlayerWebSettings,
    // );
  }

  @override
  void dispose() {
    // _customVideoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, model, _) {
      if (model.status == LoadingStatus.LOADING) {
        return Align(
          alignment: AlignmentDirectional.topStart,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
            child: AnimationLimiter(
              child: ListView.separated(
                  shrinkWrap: true,
                  padding:
                      const EdgeInsets.only(bottom: 0, left: 20, right: 20),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(seconds: 1),
                        child: SlideAnimation(
                            verticalOffset: 50.0,
                            child:
                                FadeInAnimation(child: buildShimmer(context))));
                  },
                  separatorBuilder: (context, index) => 0.height,
                  itemCount: 10),
            ),
          ),
        );
      } else {
        return model.newsList.length > 0
            ? Align(
                alignment: AlignmentDirectional.topStart,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                  child: AnimationLimiter(
                    child: ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(bottom: 10),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(seconds: 1),
                              child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                      child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ShowNewsDetials(
                                              newsModel: model.newsList[index],
                                            ),
                                          ));
                                    },
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Container(
                                                  height: 100,
                                                  child: model.newsList[index]
                                                              .videoUrl !=
                                                          ""
                                                      ? ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          child: cachedImage(
                                                              "assets/images/youtube.jpg",
                                                              width: 160,
                                                              fit: BoxFit.fill),
                                                        )
                                                      : cachedImage(
                                                          model.newsList[index]
                                                              .imageUrl,
                                                          width: 140,
                                                          fit: BoxFit.fill),
                                                ),
                                              ),
                                            ),
                                            10.width,
                                            Expanded(
                                              flex: 3,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    currentLangIsEng(context)
                                                        ? model.newsList[index]
                                                            .nameEn
                                                        : model.newsList[index]
                                                            .nameAr,
                                                    style: CustomTextStyle
                                                        .bold14black
                                                        .copyWith(
                                                            color: black,
                                                            fontSize: 14),
                                                  ),
                                                  Text(
                                                    currentLangIsEng(context)
                                                        ? model.newsList[index]
                                                            .descriptionEn
                                                        : model.newsList[index]
                                                            .descriptionAr,
                                                    style: CustomTextStyle
                                                        .semiBold12Black
                                                        .copyWith(
                                                            color: grey,
                                                            fontSize: 9.5),
                                                    maxLines: 5,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),

                                                  // GestureDetector(
                                                  //   child:   Text("مشاهدة الفيديو" ,    style: CustomTextStyle
                                                  //       .semiBold12Black
                                                  //       .copyWith(
                                                  //       color: grey,
                                                  //       fontSize: 9.5),),
                                                  //   onTap: () {
                                                  //       _customVideoPlayerController.setFullscreen(true);
                                                  //       _customVideoPlayerController.videoPlayerController.play();
                                                  //       showDialogFunction();
                                                  //   },
                                                  // )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ))));
                        },
                        separatorBuilder: (context, index) => 0.height,
                        itemCount: model.newsList.length),
                  ),
                ),
              )
            : SizedBox();
      }
    });
  }
}

String extractYouTubeVideoId(String url) {
  final uri = Uri.parse(url);
  if (uri.host.contains('youtube.com')) {
    return uri.queryParameters['v'] ?? '';
  } else if (uri.host.contains('youtu.be')) {
    return uri.pathSegments.isNotEmpty ? uri.pathSegments[0] : '';
  }
  return '';
}
