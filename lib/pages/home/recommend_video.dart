import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';

import 'package:flutter_douyin/pages/home/video/video_item.dart';

import 'package:lottie/lottie.dart';
import 'package:preload_page_view/preload_page_view.dart';

import '../../widgets/video_scroll_physics.dart';

import './mock.dart';

class Video extends StatefulWidget {
  const Video({Key? key}) : super(key: key);

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> with AutomaticKeepAliveClientMixin {
  List dataList = [];
  late PreloadPageController _pageController;
  UniqueKey _key = UniqueKey();
  @override
  void initState() {
    super.initState();
    _pageControllerinit();
    setState(() {
      dataList = list;
    });
  }

  @override
  void dispose() {
    _pageControllerDispose();
    super.dispose();
  }

  void _pageControllerDispose() {
    _pageController.dispose();
    _pageController.removeListener(_pageContainerListener);
  }

  void _pageControllerinit() {
    _pageController = PreloadPageController();
    _pageController.addListener(_pageContainerListener);
  }

  void _pageContainerListener() {
    if (_pageController.page?.round() == dataList.length - 2) {
      setState(() {
        dataList.addAll([...dataList]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomRefreshIndicator(
      builder: MaterialIndicatorDelegate(
        withRotation: false,
        builder: (context, controller) {
          return Lottie.asset('assets/lotties/tiktok-loader.json', width: 50);
        },
      ),
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1), () {
          dataList = dataList.reversed.toList();
          setState(() {
            _key = UniqueKey();
          });
        });
      },
      child: PreloadPageView.builder(
          key: _key,
          scrollDirection: Axis.vertical,
          controller: _pageController,
          physics: const VideoScrollPhysics(),
          preloadPagesCount: 5,
          onPageChanged: (value) {},
          itemCount: dataList.length,
          itemBuilder: (context, i) {
            return VideoItem(
              data: dataList[i],
              index: i,
              changeStateData: changeStateData,
            );
          }),
    );
  }

  void changeStateData(int index,
      {bool? isLike,
      int? likeCount,
      int? commentCount,
      int? shareCount,
      bool? isCollect}) {
    setState(() {
      if (isLike != null) {
        if (isLike) {
          dataList[index]['is_like'] = true;
          dataList[index]['like_count'] += 1;
        } else {
          dataList[index]['is_like'] = false;
          dataList[index]['like_count'] -= 1;
        }
        return;
      }
      if (isCollect != null) {
        if (isCollect) {
          dataList[index]['is_collect'] = true;
          dataList[index]['collect_count'] += 1;
        } else {
          dataList[index]['is_collect'] = false;
          dataList[index]['collect_count'] -= 1;
        }
        return;
      }
    });
  }

  @override
  bool get wantKeepAlive => true;
}
