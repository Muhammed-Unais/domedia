import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:players_app/view/videos/play_screen/controller/video_controllers.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class PlayVideoScreen extends StatefulWidget {
  final List paths;
  final int index;
  final bool isModelorPath;

  const PlayVideoScreen(
      {super.key,
      required this.paths,
      required this.index,
      required this.isModelorPath});

  @override
  State<PlayVideoScreen> createState() => _PlayVideoScreenState();
}

class _PlayVideoScreenState extends State<PlayVideoScreen> {
  @override
  void initState() {
    Provider.of<VideoControllers>(context, listen: false).intializeVideo(
        index: widget.index,
        paths: widget.paths,
        isModelorPath: widget.isModelorPath);
    super.initState();
  }

  @override
  void dispose() {
    // Provider.of<VideoControllers>(context, listen: false).vidoeControllers();
    // Provider.of<VideoControllers>(context,listen: false).controllers!.dispose();
    // Provider.of<VideoControllers>(context,listen: false).controllers = null;
    // _controller!.pause();
    // _controller!.dispose();
    // _controller = null;
    super.dispose();
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }

  int count = 0;
  int pcount = 1;

//===================controlls lock button=============================
  Widget lockButton() {
    final vidController = Provider.of<VideoControllers>(context);
    return vidController.isShowVideoCntrl == true ||
            vidController.isLocked == true
        ? IconButton(
            onPressed: () => vidController.lockButtonfunction(),
            icon: vidController.isLocked == true
                ? Icon(
                    Icons.lock_outline,
                    color: Colors.white.withOpacity(0.5),
                    size: 20,
                  )
                : const Icon(
                    Icons.lock_open_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
          )
        : const SizedBox();
  }

//======================== Build Ui function=====================
  @override
  Widget build(BuildContext context) {
    final vidController = Provider.of<VideoControllers>(context, listen: false);
    final controller = vidController.controllers;
    return GestureDetector(
      onTap: () async {
        if (vidController.isLocked == true) return;
        if (pcount != count) {
          count++;
          await vidController.controllsVisibility();
          pcount++;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                //=======================Video playing area =======================
                controller != null && controller.value.isInitialized
                    ? Align(
                        alignment: Alignment.center,
                        child: AspectRatio(
                          aspectRatio: controller.value.aspectRatio,
                          child: VideoPlayer(controller),
                        ),
                      )
                    : const AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),

                //==================================Video Upper area=============================
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    color: vidController.isShowVideoCntrl == true
                        ? Colors.transparent.withAlpha(150)
                        : Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        vidController.isShowVideoCntrl == true
                            ? IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                              )
                            : const SizedBox(),
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 100 * 2),
                        vidController.isShowVideoCntrl == true
                            ? Text(
                                widget.isModelorPath == true
                                    ? widget.paths[vidController.isPlayingindex]
                                        .path
                                        .toString()
                                        .split('/')
                                        .last
                                    : widget.paths[vidController.isPlayingindex]
                                        .toString()
                                        .split('/')
                                        .last,
                                style: const TextStyle(color: Colors.white),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),

                //==============================Video Controllers Area =====================================
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    color: vidController.isShowVideoCntrl == true
                        ? Colors.transparent.withAlpha(150)
                        : Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        vidController.isShowVideoCntrl == true
                            ? controlls(context, controller!)
                            : const SizedBox(),
                        const SizedBox(
                          height: 12,
                        ),
                        controlerButtons(context, controller!),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

// =================VIDEO CONTROLLERS=============
  Widget controlls(BuildContext context, VideoPlayerController controller) {
    final vidController = Provider.of<VideoControllers>(context);
    return Container(
      width: MediaQuery.of(context).size.width / 1.03,
      decoration: BoxDecoration(
        border: Border.all(
            width: 0.5, color: Colors.white, style: BorderStyle.solid),
        borderRadius: const BorderRadius.all(
          Radius.circular(3),
        ),
      ),
      // height: 50,
      child: ValueListenableBuilder(
        valueListenable: controller,
        builder: (context, VideoPlayerValue value, _) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                vidController.videoDuration(value.position),
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.4,
                height: 12,
                child: VideoProgressIndicator(
                  padding: const EdgeInsets.only(bottom: 0),
                  colors: const VideoProgressColors(
                    backgroundColor: Colors.black,
                    playedColor: Colors.white,
                  ),
                  controller,
                  allowScrubbing: true,
                ),
              ),
              Text(
                vidController.videoDuration(controller.value.duration),
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget controlerButtons(context, VideoPlayerController controller) {
    final vidController = Provider.of<VideoControllers>(context);
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            lockButton(),
            vidController.isShowVideoCntrl == true
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          final index = vidController.isPlayingindex - 1;
                          if (index >= 0 && widget.paths.isNotEmpty) {
                            vidController.intializeVideo(
                                index: index,
                                isModelorPath: widget.isModelorPath,
                                paths: widget.paths);
                          }
                        },
                        icon: const Icon(
                          Icons.skip_previous,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),

                      SizedBox(
                        width: MediaQuery.of(context).size.width / 12,
                      ),
                      // ===========================Video Play and pause button=========================
                      IconButton(
                        onPressed: () async {
                          if (vidController.isPlaying) {
                            vidController.isPauseButton();
                            vidController.controllers!.pause();
                            await Future.delayed(const Duration(seconds: 5));
                            vidController.videoControllersShow();
                          } else {
                            vidController.isPlayButton();
                            vidController.controllers!.play();
                          }
                        },
                        icon: Icon(
                          vidController.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 12,
                      ),
                      IconButton(
                        onPressed: () {
                          final index = vidController.isPlayingindex + 1;
                          if (index <= widget.paths.length - 1) {
                            vidController.intializeVideo(
                                index: index,
                                isModelorPath: widget.isModelorPath,
                                paths: widget.paths);
                          }
                        },
                        icon: const Icon(
                          Icons.skip_next,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
            vidController.isShowVideoCntrl == true
                ? fullScreenRotate()
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget fullScreenRotate() {
    final vidController = Provider.of<VideoControllers>(context);
    return IconButton(
      onPressed: () {
        vidController.setlandScape();
        vidController.landscapeChange();
      },
      icon: const Icon(
        Icons.screen_rotation,
        color: Colors.white,
        size: 20,
      ),
    );
  }
}