import 'package:flutter/material.dart';
import 'package:flutter_douyin/widgets/input_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class VideoComment extends StatefulWidget {
  final Function changeCommentHeight;
  final double screenHeight;

  const VideoComment(
      {super.key,
      required this.changeCommentHeight,
      required this.screenHeight});

  @override
  State<VideoComment> createState() => _VideoComment();
}

class _VideoComment extends State<VideoComment> {
  final GlobalKey _globalKey = GlobalKey();
  bool openFullScreen = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      child: SizedBox(
        key: _globalKey,
        height:
            MediaQuery.of(context).size.height * (openFullScreen ? 0.95 : 0.7),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                height: 36,
                decoration: const BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Color.fromRGBO(0, 0, 0, .2)))),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 24,
                  child: Stack(
                    children: [
                      const Align(
                        child: Text(
                          '6.6万条评论',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 10),
                        ),
                      ),
                      openFullScreen
                          ? const Text('')
                          : Positioned(
                              bottom: 8,
                              right: 15,
                              child: Container(
                                padding: const EdgeInsets.only(left: 10),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.black,
                                    size: 18,
                                  ),
                                ),
                              ))
                    ],
                  ),
                )),
            Expanded(
                child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: ListView.builder(
                itemCount: 6,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    margin: const EdgeInsets.only(bottom: 15),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 0.065.sw,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 0.06.sw,
                              backgroundColor: Colors.white,
                              backgroundImage: const NetworkImage(
                                  'https://i1.hdslb.com/bfs/face/cff5c0a548b4b98f7e8630b86c3240304fa49801.jpg@60w_60h_1c_1s_!web-avatar-comment.webp'),
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.only(left: 6),
                              width: MediaQuery.of(context).size.width - 0.3.sw,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    '视觉',
                                    style: TextStyle(color: Colors.black45),
                                  ),
                                  const Text(
                                    '愿各位看官，皆遇良人，前程似锦，未来可期.愿各位看官，皆遇良人，前程似锦，未来可期.',
                                    style: TextStyle(
                                        color: Colors.black, height: 1.2),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            '05-10 · 广东',
                                            style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 12),
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 10),
                                            child: const Text(
                                              '回复',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black54),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.favorite_border,
                                                color: Colors.black45,
                                                size: 18,
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    left: 2, right: 16),
                                                child: const Text(
                                                  '233',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black38),
                                                ),
                                              )
                                            ],
                                          ),
                                          const Icon(
                                            Icons.heart_broken_outlined,
                                            color: Colors.black45,
                                            size: 18,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: const [
                                      Text(
                                        '----展开66条回复',
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 12),
                                      ),
                                      Icon(
                                        Icons.expand_more,
                                        color: Colors.black54,
                                      )
                                    ],
                                  )
                                ],
                              ))
                        ]),
                  );
                },
              ),
            )),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 1.0,
                    color: Color(0xffeeeeee),
                  ),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                height: 36,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: const Color(0xfff1f2f3),
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.grey,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          child: InkWell(
                              onTap: () async {
                                await showMaterialModalBottomSheet(
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
                                  // barrierColor: Colors.transparent,
                                  backgroundColor: Colors.white,
                                  builder: (context) {
                                    return const InputWidget();
                                  },
                                );
                              },
                              child: const Text(
                                '善语结善缘，恶言伤人心',
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xff888888)),
                              )),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            debugPrint('add_image');
                          },
                          child: const Icon(Icons.alternate_email_rounded,
                              color: Colors.grey),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: InkWell(
                            onTap: () {
                              debugPrint('add_image');
                            },
                            child: const Icon(Icons.emoji_emotions_outlined,
                                color: Colors.grey),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            debugPrint('add_image');
                          },
                          child: const Icon(Icons.add_circle_outline,
                              color: Colors.grey),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),

      /// 移动操作
      onPointerMove: (PointerMoveEvent pointerMoveEvent) {
        final offset =
            (_globalKey.currentContext?.findRenderObject() as RenderBox)
                .localToGlobal(Offset.zero);
        widget.changeCommentHeight(offset.dy);
      },
      onPointerUp: (event) {
        final offset =
            (_globalKey.currentContext?.findRenderObject() as RenderBox)
                .localToGlobal(Offset.zero);
        if (offset.dy / widget.screenHeight < 0.7) {
          widget.changeCommentHeight(offset.dy, hideComment: false);
        }
      },
    );
  }
}
