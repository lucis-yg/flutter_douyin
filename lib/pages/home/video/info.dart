import 'package:flutter/material.dart';
import 'package:flutter_douyin/pages/home/video/scroll_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/text_expanded.dart';

class VideoInfo extends StatefulWidget {
  final String title;
  final String author;
  const VideoInfo({super.key, required this.title, required this.author});

  @override
  State<VideoInfo> createState() => _VideoInfo();
}

class _VideoInfo extends State<VideoInfo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 30,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 200,
                child: Text(
                  '@${widget.author}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.white,
                      height: 3.0,
                      fontSize: 0.04.sw,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width - 100,
                  child: BrnExpandableText(
                      textStyle: TextStyle(
                          height: 1.2, fontSize: 0.04.sw, color: Colors.white),
                      color: Colors.black,
                      text: widget.title,
                      maxLines: 3)),
              BrnNoticeBarWithButton(
                content: '@${widget.author}创建的原声',
                marquee: true,
                contentTextColor: Colors.white,
                backgroundColor: Colors.transparent,
              ),
            ],
          ),
        ));
  }
}
