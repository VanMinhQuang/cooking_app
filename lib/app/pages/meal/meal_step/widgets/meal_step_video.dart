import 'package:cooking_project/core/styles/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class StepVideo extends StatefulWidget {
  final String videoUrl;

  const StepVideo({super.key, required this.videoUrl});

  @override
  State<StepVideo> createState() => _StepVideoState();
}

class _StepVideoState extends State<StepVideo> {
  VideoPlayerController? _controller;
  Future<void>? _initializeVideoPlayerFuture;
  FileInfo? _cachedFileInfo;

  @override
  void initState() {
    super.initState();
    _loadVideo();
  }

  Future<void> _loadVideo() async {
    final fileInfo = await DefaultCacheManager().getFileFromCache(widget.videoUrl);
    FileInfo? videoFileInfo = fileInfo;
    videoFileInfo ??= await DefaultCacheManager().downloadFile(widget.videoUrl);
    setState(() {
      _cachedFileInfo = videoFileInfo;
      _controller = VideoPlayerController.file(videoFileInfo!.file);
      _initializeVideoPlayerFuture = _controller!.initialize();
      _controller!.setLooping(true);
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _controller == null
              ? const Center(child: CircularProgressIndicator())
              : FutureBuilder(
                  future: _initializeVideoPlayerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(16.sp),
                        child: AspectRatio(
                          aspectRatio: _controller!.value.aspectRatio,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _controller!.value.isPlaying
                                    ? _controller!.pause()
                                    : _controller!.play();
                              });
                            },
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                VideoPlayer(_controller!),
                                VideoProgressIndicator(_controller!, allowScrubbing: true),
                                Center(
                                  child: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 400),
                                    switchInCurve: Curves.elasticOut,
                                    switchOutCurve: Curves.easeIn,
                                    transitionBuilder:
                                        (Widget child, Animation<double> animation) {
                                      return ScaleTransition(
                                        scale: animation,
                                        child: FadeTransition(
                                          opacity: animation,
                                          child: child,
                                        ),
                                      );
                                    },
                                    child: _controller!.value.isPlaying
                                        ? const SizedBox(key: ValueKey('empty'))
                                        : Container(
                                            key: const ValueKey('play'),
                                            decoration: BoxDecoration(
                                              color: Colors.black.withOpacity(0.4),
                                              shape: BoxShape.circle,
                                            ),
                                            padding: EdgeInsets.all(16),
                                            child: Icon(
                                              Icons.play_arrow,
                                              color: Colors.white,
                                              size: 64,
                                            ),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
        ],
      ),
    );
  }
}
