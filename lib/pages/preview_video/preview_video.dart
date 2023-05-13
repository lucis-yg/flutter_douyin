import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_douyin/pages/home/video/video_item.dart';

import 'package:flutter_douyin/widgets/input_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:preload_page_view/preload_page_view.dart';

import '../../widgets/video_scroll_physics.dart';

import './mock.dart';

class PreviewVideo extends StatefulWidget {
  const PreviewVideo({Key? key}) : super(key: key);

  @override
  State<PreviewVideo> createState() => _PreviewVideoState();
}

class _PreviewVideoState extends State<PreviewVideo> {
  List dataList = [];
  late PreloadPageController _pageController;
  @override
  void initState() {
    super.initState();

    _pageControllerinit();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarIconBrightness: Brightness.light));

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
    _pageController =
        PreloadPageController(initialPage: Get.arguments['index']);
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
    return Material(
      color: Colors.black,
      child: Stack(children: [
        PreloadPageView.builder(
            scrollDirection: Axis.vertical,
            controller: _pageController,
            physics: const VideoScrollPhysics(),
            preloadPagesCount: 2,
            onPageChanged: (value) {},
            itemCount: dataList.length,
            itemBuilder: (context, i) {
              return VideoItem(
                data: dataList[i],
                index: i,
                changeStateData: changeStateData,
              );
            }),
        Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_back_ios_sharp,
                      color: Colors.white,
                      size: .08.sw,
                    ),
                  ),
                  Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width - 120,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: const Color.fromRGBO(255, 255, 255, .3)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.search,
                              color: Colors.white54,
                            ),
                            Text(
                              '搜你想看的',
                              style: TextStyle(
                                  color: Colors.white54, fontSize: 12),
                            ),
                          ],
                        ),
                        Row(
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(right: 6),
                              child: Text(
                                '|',
                                style: TextStyle(color: Colors.white54),
                              ),
                            ),
                            Text(
                              '搜索',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.white70),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Icon(
                    Icons.headset_rounded,
                    color: Colors.white,
                    size: .08.sw,
                  ),
                ],
              ),
            )),
        Positioned(
            bottom: 10,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 120,
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        showMaterialModalBottomSheet(
                          useRootNavigator: true,
                          animationCurve: Curves.linear,
                          closeProgressThreshold: 0.8,
                          duration: const Duration(milliseconds: 200),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0)),
                          ),
                          context: context,
                          barrierColor: Colors.transparent,
                          backgroundColor: Colors.white,
                          builder: (context) {
                            return const InputWidget();
                          },
                        );
                      },
                      child: const Text(
                        '善语结善缘，恶言伤人心',
                        style:
                            TextStyle(color: Color.fromRGBO(255, 255, 255, .6)),
                      ),
                    ),
                  ),
                  const Icon(Icons.alternate_email,
                      color: Color.fromRGBO(255, 255, 255, .6)),
                  const Icon(Icons.emoji_emotions_outlined,
                      color: Color.fromRGBO(255, 255, 255, .6)),
                  const Icon(Icons.add_circle_outline,
                      color: Color.fromRGBO(255, 255, 255, .6))
                ],
              ),
            )),
      ]),
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
}
