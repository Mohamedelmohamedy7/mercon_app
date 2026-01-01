import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../Provider/VisitorProvider.dart';
import '../../Utill/AnimationWidget.dart';
import '../../Utill/Comman.dart';
import '../../Utill/LoaderWidget/loader_widget.dart';
import '../../Utill/validator.dart';
import '../../helper/EnumLoading.dart';
import '../../helper/ImagesConstant.dart';
import '../../helper/SnackBarScreen.dart';
import '../../helper/color_resources.dart';
import '../../helper/text_style.dart';
import '../Widget/comman/CustomAppBar.dart';
import '../Widget/comman/comman_Image.dart';

class ComplaintsandSuggestions extends StatefulWidget {
  const ComplaintsandSuggestions({Key? key}) : super(key: key);

  @override
  _ComplaintsandSuggestionsState createState() =>
      _ComplaintsandSuggestionsState();
}

class _ComplaintsandSuggestionsState extends State<ComplaintsandSuggestions> {
  TextEditingController messageController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  File? _selectedVideo;
  String? videoString;

  Future<void> _pickVideo() async {
    final pickedFile =
        await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedVideo = File(pickedFile.path);
      });
    }
  }

  File? imageOfComplaints_and_Suggestions;

  Future pickImageCBack(context, File? neededSelect, int selected) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      setState(() {
        imageOfComplaints_and_Suggestions = File(image.path);
      });
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed to pick image: $e');
      }
    }
    print(neededSelect == null);
  }

  Future pickImageFront(context, File? neededSelect, int selected) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      setState(() {
        imageOfComplaints_and_Suggestions = File(image.path);
      });
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed to pick image: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: CustomAppBar(
            needBack: true,
            title: "Complaints_and_Suggestions".tr(),
            backgroundImage: AssetImage(ImagesConstants.backgroundImage),
          ),
          body: Container(
              //color: BACKGROUNDCOLOR,
              height: MediaQuery.of(context).size.height,
              child: CustomAnimatedWidget(
                  child: Form(
                key: _globalKey,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Theme.of(context).primaryColor)),
                        child: textFormField("write_Complaints_and_Suggestions",
                            messageController, textFieldSvg("message.svg"),
                            maxLines: 6,
                            validation: (value) =>
                                Validator.defaultValidator(value),
                            autoFoucs: false),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(10))),
                            context: context,
                            builder: (ctx) => Container(
                                  margin: const EdgeInsets.all(40),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            Navigator.pop(ctx);
                                            pickImageCBack(
                                                context,
                                                imageOfComplaints_and_Suggestions,
                                                0);
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.camera,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                tr("Select From Camera"),
                                                style: CustomTextStyle
                                                    .semiBold14grey,
                                              ),
                                            ],
                                          )),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Divider(),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(ctx);
                                          pickImageFront(
                                              context,
                                              imageOfComplaints_and_Suggestions,
                                              0);
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.photo_camera_back_outlined,
                                              color:
                                                  Theme.of(context).primaryColor,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              tr("Select From Gallery"),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ));
                      },
                      child: imageOfComplaints_and_Suggestions != null
                          ? Container(
                             padding: EdgeInsets.symmetric(horizontal: 15),
                             height: 220,
                              width: MediaQuery.of(context).size.width,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  imageOfComplaints_and_Suggestions!,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: DottedBorder(
                                borderType: BorderType.RRect,
                                radius: Radius.circular(10),
                                strokeWidth: 1.5,
                                dashPattern: [6, 3],
                                // Change the values to adjust the length and spacing of the dots
                                color: Theme.of(context).primaryColor,
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      Lottie.asset('assets/images/addImage.json',
                                          width: 100, height: 100, repeat: false),
                                      Text(
                                        "add_image".tr(),
                                        style: CustomTextStyle.bold14black
                                            .copyWith(
                                                fontWeight: FontWeight.w600),
                                      ).paddingOnly(left: 40),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (_selectedVideo != null)
                      SizedBox(
                        height: 220,
                        width: 360,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: VideoPlayerWidget(videoFile: _selectedVideo!)),
                      ),
                    if (_selectedVideo == null && videoString == null)
                      GestureDetector(
                        onTap: _pickVideo,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: Radius.circular(10),
                            strokeWidth: 1.5,
                            dashPattern: [6, 3],
                            // Change the values to adjust the length and spacing of the dots
                            color: Theme.of(context).primaryColor,
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  Lottie.asset('assets/images/uploadVideo.json',
                                      fit: BoxFit.cover,
                                      width: 120,
                                      height: 130,
                                      repeat: false),
                                  Text(
                                    "add_video".tr(),
                                    style: CustomTextStyle.bold14black
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ).paddingOnly(left: 40),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Consumer<VisitorProvider>(
                        builder: (context, model, _) {
                          if (model.status == LoadingStatus.LOADING) {
                            return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [LoaderWidget()]);
                          } else {
                            return InkWell(
                              onTap: () {
                                if (_globalKey.currentState!.validate()) {
                                  model
                                      .sendMessageToSecurity(
                                          messageController.text, context)
                                      .then((value) {
                                    if (value["message"] == "Notifcation Sent") {
                                      showAwesomeSnackbar(
                                        context,
                                        'Success!',
                                        '${value["message"]}',
                                        contentType: ContentType.success,
                                      );
                                      messageController.clear();
                                      setState(() {});
                                    }
                                  });
                                }
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                width: w(context),
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: lightGray,
                                      offset: Offset(0.0, 2.0),
                                      blurRadius: 4.0, // Specify the blur radius
                                    ),
                                  ],
                                ),
                                child: Center(
                                    child: Text(
                                  "sendRequest".tr(),
                                  style: CustomTextStyle.semiBold12Black,
                                )),
                              ),
                            );
                          }
                        },
                      ),
                    )
                  ]),
                ),
              )))),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final File videoFile;

  const VideoPlayerWidget({super.key, required this.videoFile});

  @override
  // ignore: library_private_types_in_public_api
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.videoFile);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return SizedBox(
            height: 400,
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  VideoPlayer(_controller),
                  // Play/Pause button
                  InkWell(
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.3)),
                      child: Center(
                        child: Icon(
                          _controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          size: 50.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        if (_controller.value.isPlaying) {
                          _controller.pause();
                        } else {
                          _controller.play();
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
