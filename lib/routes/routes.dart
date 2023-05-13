import 'package:flutter_douyin/main.dart';
import 'package:flutter_douyin/pages/preview_video/preview_video.dart';
import 'package:get/get.dart';

class AppPage {
  static final routes = [
    GetPage(
        name: '/preview_video',
        page: () => const PreviewVideo(),
        transition: Transition.rightToLeft),
    GetPage(
        name: '/home_page',
        page: () => const MyHomePage(),
        transition: Transition.leftToRight)
  ];
}
