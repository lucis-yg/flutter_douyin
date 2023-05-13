
import 'package:flutter/material.dart';



import 'package:flutter_douyin/pages/home/video/double_like.dart';
import 'package:flutter_douyin/pages/home/video/info.dart';
import 'package:flutter_douyin/pages/home/video/loading_progress.dart';
import 'package:flutter_douyin/pages/home/video/progress.dart';
import 'package:flutter_douyin/pages/home/video/rightbar.dart';
import 'package:flutter_douyin/pages/home/video/timelabel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:visibility_detector/visibility_detector.dart';
class VideoItem extends StatefulWidget {
  final dynamic data;
  final int index;
  final Function changeStateData;
  const VideoItem({
    super.key,
    required this.data,
    required this.index,
    required this.changeStateData,
  });
  @override
  State<VideoItem> createState() => _VideoItem();
}

class _VideoItem extends State<VideoItem> {
  bool hidePlayIcon = true;
  double aspectRatio = 1;
  late Duration duration;
  Duration position = Duration.zero;
  String changeTime = "00:00";
  bool timeLabelShow = false;
  double videoScreenRate = 1;
  bool isBuffering = true;
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  @override
  void initState() {
    super.initState();

    _videoPlayerController =
        VideoPlayerController.network(widget.data['video_url'])
          ..initialize().then((_) {
            setState(() {
              aspectRatio = _videoPlayerController.value.aspectRatio;
              duration = _videoPlayerController.value.duration;
              position = _videoPlayerController.value.position;
            });
            _chewieController = ChewieController(
                videoPlayerController: _videoPlayerController,
                aspectRatio: _videoPlayerController.value.aspectRatio,
                showControls: false,
                looping: true);
          });

    _videoPlayerController.addListener(_videoListener);
  }

  void setTimeChange(time) {
    setState(() {
      changeTime = time;
    });
    if (!timeLabelShow) {
      setState(() {
        timeLabelShow = true;
      });
    }
  }

  void setPosition(seekTime) {
    setState(() {
      _videoPlayerController.seekTo(Duration(seconds: seekTime.floor()));
      timeLabelShow = false;
    });
  }

  void _videoListener() {
    setState(() {
      position = _videoPlayerController.value.position;
      isBuffering = _videoPlayerController.value.isBuffering;
    });
  }

  void onSingleTap() {
    if (_videoPlayerController.value.isPlaying) {
      setState(() {
        hidePlayIcon = false;
      });
      _videoPlayerController.pause();
    } else {
      setState(() {
        hidePlayIcon = true;
      });
      _videoPlayerController.play();
    }
  }

  void changeRightBarData(
      {bool? isLike,
      bool? isCollect,
      bool? commentShow,
      int? likeCount,
      int? commentCount,
      int? shareCount,
      bool? hideComment,
      double? screenRate}) {
    if (isLike != null) {
      widget.changeStateData(widget.index, isLike: isLike);
      return;
    }
    if (isCollect != null) {
      widget.changeStateData(widget.index, isCollect: isCollect);
      return;
    }
    if (commentShow != null) {
      if (commentShow) {
        setState(() {
          if (hideComment != null && hideComment == false) {
            videoScreenRate = 0.36;
            return;
          }
          if (screenRate != null) {
            if (screenRate > 1) {
              videoScreenRate = 1.0;
            } else {
              videoScreenRate = screenRate + 0.06;
            }
          } else {
            videoScreenRate = 0.36;
          }
        });
      } else {
        setState(() {
          videoScreenRate = 1.0;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.data['id'].toString()),
      onVisibilityChanged: (info) {
        if (!mounted) return;

        if (info.visibleFraction == 0) {
          _videoPlayerController.pause();
        } else if (info.visibleFraction == 1) {
          setState(() {
            hidePlayIcon = true;
          });
          _videoPlayerController.play();
        }
      },
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: Duration(
                milliseconds: [0.36, 1].contains(videoScreenRate) ? 200 : 0),
            curve: Curves.linear,
            width: MediaQuery.of(context).size.width *
                (aspectRatio > 1 ? 1 : videoScreenRate),
            left: aspectRatio > 1
                ? 0
                : (MediaQuery.of(context).size.width *
                    (1 - videoScreenRate) /
                    2),
            height: MediaQuery.of(context).size.height * videoScreenRate,
            child: LikeGestureWidget(
                onSingleTap: onSingleTap,
                onAddFavorite: () => {},
                child: _videoPlayerController.value.isInitialized
                    ? Chewie(controller: _chewieController!)
                    : SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Icon(
                            Icons.tiktok,
                            color: Colors.grey,
                            size: 0.3.sw,
                          ),
                        ),
                      )),
          ),
          Positioned(
            child: Stack(
              children: [
                (hidePlayIcon || _videoPlayerController.value.isPlaying)
                    ? const Positioned(child: Center(child: Text('')))
                    : Positioned.fill(
                        child: Center(
                        child: SizedBox(
                          width: 0.2.sw,
                          height: 0.2.sw,
                          child: InkWell(
                            onTap: () => onSingleTap(),
                            child: Icon(
                              Icons.play_arrow,
                              color: const Color.fromRGBO(255, 255, 255, .6),
                              size: 0.25.sw,
                            ),
                          ),
                        ),
                      )),
                timeLabelShow
                    ? TimeLabel(duration: duration, changeTime: changeTime)
                    : VideoInfo(
                        author: widget.data['username'],
                        title: widget.data['title'],
                      ),
                _videoPlayerController.value.isInitialized
                    ? VideoProgress(
                        duration: duration,
                        position: position,
                        setTimeChange: setTimeChange,
                        setPosition: setPosition)
                    : const Text(''),
                RightBar(
                  avatar: widget.data['avatar'],
                  isPlaying:
                      (hidePlayIcon || _videoPlayerController.value.isPlaying),
                  changeRightBarData: changeRightBarData,
                  screenHeight: MediaQuery.of(context).size.height,
                  isLike: widget.data['is_like'],
                  isColl: widget.data['is_collect'],
                  likeCount: widget.data['like_count'],
                  commentCount: widget.data['comment_count'],
                  shareCount: widget.data['share_count'],
                  collectCount: widget.data['collect_count'],
                ),
                Positioned(
                    bottom: 56,
                    child: isBuffering
                        ? CustomLinearProgressIndicator(
                            width: MediaQuery.of(context).size.width,
                            height: 1,
                            value: 1,
                            color: const Color.fromRGBO(255, 255, 255, .5),
                          )
                        : const Text('')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
    _videoPlayerController.removeListener(_videoListener);
    _chewieController?.dispose();
  }
}
