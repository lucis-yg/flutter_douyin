import 'package:flutter/material.dart';
import 'package:flutter_douyin/pages/home/video/rotate_music_pic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:like_button/like_button.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import './comment.dart';

class RightBar extends StatefulWidget {
  final bool isLike;
  final bool isColl;
  final int likeCount;
  final int commentCount;
  final int shareCount;
  final int collectCount;
  final double screenHeight;
  final Function changeRightBarData;
  final bool isPlaying;
  final String avatar;
  const RightBar(
      {super.key,
      required this.screenHeight,
      required this.isLike,
      required this.likeCount,
      required this.commentCount,
      required this.shareCount,
      required this.changeRightBarData,
      required this.isColl,
      required this.collectCount,
      required this.isPlaying,
      required this.avatar});

  @override
  State<RightBar> createState() => _RightBar();
}

class _RightBar extends State<RightBar> {
  @override
  void initState() {
    super.initState();
  }

  void changeCommentHeight(double height, {bool? hideComment}) {
    widget.changeRightBarData(
        commentShow: true,
        screenRate: (height / widget.screenHeight),
        hideComment: hideComment);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 80,
      right: 10,
      child: Column(
        children: [
          SizedBox(
              height: 80,
              child: InkWell(
                onTap: () {
                  debugPrint('点击了头像');
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 0.065.sw,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 0.06.sw,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(widget.avatar),
                      ),
                    ),
                    Positioned(
                        bottom: 0.02.sw,
                        child: InkWell(
                          onTap: () {
                            debugPrint('点击了关注');
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 0.02.sw,
                              ),
                              Positioned(
                                  child: Icon(
                                Icons.add_circle,
                                color: Colors.redAccent,
                                size: 0.06.sw,
                              ))
                            ],
                          ),
                        ))
                  ],
                ),
              )),
          LikeButton(
            size: 0.1.sw,
            isLiked: widget.isLike,
            circleColor: const CircleColor(
                start: Color.fromRGBO(248, 48, 88, 1),
                end: Color.fromRGBO(248, 48, 88, 1)),
            bubblesColor: const BubblesColor(
              dotPrimaryColor: Color.fromRGBO(248, 48, 88, 1),
              dotSecondaryColor: Color.fromRGBO(248, 48, 88, 1),
            ),
            onTap: (bool isLiked) async {
              widget.changeRightBarData(isLike: !isLiked);
              return !isLiked;
            },
            likeBuilder: (bool isLiked) {
              return AnimatedCrossFade(
                duration: const Duration(milliseconds: 200),
                crossFadeState: isLiked
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                firstChild: Icon(
                  Icons.favorite,
                  color: const Color.fromRGBO(248, 48, 88, 1),
                  size: 0.1.sw,
                ),
                secondChild: Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 0.1.sw,
                ),
              );
            },
            likeCountAnimationType: LikeCountAnimationType.all,
            countPostion: CountPostion.bottom,
            likeCount: 665,
            countDecoration: (Widget count, int? likeCount) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 26,
                    child: Text(
                      widget.likeCount == 0
                          ? '喜欢'
                          : widget.likeCount.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  )
                ],
              );
            },
          ),
          InkWell(
            onTap: () {
              widget.changeRightBarData(commentShow: true, screenRate: 0.3);
              Future result = showMaterialModalBottomSheet(
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
                  return VideoComment(
                      changeCommentHeight: changeCommentHeight,
                      screenHeight: widget.screenHeight);
                },
              );
              result.then((value) {
                widget.changeRightBarData(commentShow: false);
              });
              debugPrint('评论');
            },
            child: Column(
              children: [
                Icon(
                  Icons.mode_comment,
                  color: Colors.white,
                  size: 0.1.sw,
                ),
                SizedBox(
                  height: 26,
                  child: Text(
                    widget.commentCount == 0
                        ? '评论'
                        : widget.commentCount.toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                )
              ],
            ),
          ),
          LikeButton(
            size: 0.1.sw,
            isLiked: widget.isColl,
            circleColor: const CircleColor(
                start: Color.fromRGBO(251, 184, 3, 1),
                end: Color.fromRGBO(251, 184, 3, 1)),
            bubblesColor: const BubblesColor(
              dotPrimaryColor: Color.fromRGBO(251, 184, 3, 1),
              dotSecondaryColor: Color.fromRGBO(251, 184, 3, 1),
            ),
            onTap: (bool isLiked) async {
              widget.changeRightBarData(isCollect: !isLiked);
              return !isLiked;
            },
            likeBuilder: (bool isLiked) {
              return AnimatedCrossFade(
                duration: const Duration(milliseconds: 200),
                crossFadeState: isLiked
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                firstChild: Icon(
                  Icons.star,
                  color: const Color.fromRGBO(251, 184, 3, 1),
                  size: 0.1.sw,
                ),
                secondChild: Icon(
                  Icons.star,
                  color: Colors.white,
                  size: 0.1.sw,
                ),
              );
            },
            likeCountAnimationType: LikeCountAnimationType.all,
            countPostion: CountPostion.bottom,
            countDecoration: (Widget count, int? collectCount) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 26,
                    child: Text(
                      widget.likeCount == 0
                          ? '收藏'
                          : widget.collectCount.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  )
                ],
              );
            },
          ),
          InkWell(
            onTap: () {
              showMaterialModalBottomSheet(
                useRootNavigator: true,
                duration: const Duration(milliseconds: 200),
                closeProgressThreshold: 0.95,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0)),
                ),
                context: context,
                barrierColor: Colors.transparent,
                backgroundColor: Colors.white,
                builder: (context) {
                  return SizedBox(
                      // width: MediaQuery.of(context).size.width,
                      height: 300,
                      child: Column(
                        children: [
                          Container(
                            // width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 10, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  child: const Text(
                                    '分享到',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                                InkWell(
                                  onTap: () => Navigator.of(context).pop(),
                                  child: const Icon(
                                    Icons.close,
                                    size: 18,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey.withOpacity(0.2),
                                  width: 1.0,
                                ),
                              ),
                            ),
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(
                                left: 15, right: 15, bottom: 15),
                            padding: const EdgeInsets.only(bottom: 15),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 20),
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 0.065.sw,
                                          backgroundColor: Colors.white,
                                          child: CircleAvatar(
                                            radius: 0.06.sw,
                                            backgroundColor: Colors.white,
                                            backgroundImage:
                                                NetworkImage(widget.avatar),
                                          ),
                                        ),
                                        Container(
                                          padding:
                                              const EdgeInsets.only(top: 4),
                                          width: 48,
                                          child: const Text(
                                            'ISO_Studio',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(right: 20),
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 0.065.sw,
                                          backgroundColor: Colors.white,
                                          child: CircleAvatar(
                                            radius: 0.06.sw,
                                            backgroundColor: Colors.white,
                                            backgroundImage: const NetworkImage(
                                                'https://i1.hdslb.com/bfs/face/40213ffa924f6ea36f96d1f767f6d78c31290519.jpg@96w_96h_1c.webp'),
                                          ),
                                        ),
                                        Container(
                                          padding:
                                              const EdgeInsets.only(top: 4),
                                          width: 48,
                                          child: const Text(
                                            'Kototo',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(
                                  left: 15, right: 15, bottom: 15),
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(children: [
                                    Container(
                                        margin:
                                            const EdgeInsets.only(right: 20),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 36,
                                              height: 36,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color.fromRGBO(
                                                    248, 208, 24, 1),
                                              ),
                                              child: const Center(
                                                child: Icon(Icons.flash_on),
                                              ),
                                            ),
                                            Center(
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    top: 4),
                                                child: const Text(
                                                  '转发',
                                                  style: TextStyle(
                                                      color: Colors.black45,
                                                      fontSize: 12),
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                    Container(
                                        margin:
                                            const EdgeInsets.only(right: 20),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 36,
                                              height: 36,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color.fromRGBO(
                                                    156, 101, 244, 1),
                                              ),
                                              child: const Center(
                                                child: Icon(Icons.thumb_up),
                                              ),
                                            ),
                                            Center(
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    top: 4),
                                                child: const Text(
                                                  '推荐给朋友',
                                                  style: TextStyle(
                                                      color: Colors.black45,
                                                      fontSize: 12),
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                    Container(
                                        margin:
                                            const EdgeInsets.only(right: 20),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 36,
                                              height: 36,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color.fromRGBO(
                                                    255, 71, 105, 1),
                                              ),
                                              child: const Center(
                                                child: Icon(Icons.send),
                                              ),
                                            ),
                                            Center(
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    top: 4),
                                                child: const Text(
                                                  '私信朋友',
                                                  style: TextStyle(
                                                      color: Colors.black45,
                                                      fontSize: 12),
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                    Container(
                                        margin:
                                            const EdgeInsets.only(right: 20),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 36,
                                              height: 36,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color.fromRGBO(
                                                    18, 192, 91, 1),
                                              ),
                                              child: const Center(
                                                child: Icon(Icons.group_add),
                                              ),
                                            ),
                                            Center(
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    top: 4),
                                                child: const Text(
                                                  '新建分享',
                                                  style: TextStyle(
                                                      color: Colors.black45,
                                                      fontSize: 12),
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                    Container(
                                        margin:
                                            const EdgeInsets.only(right: 20),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 36,
                                              height: 36,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color.fromRGBO(
                                                    59, 190, 236, 1),
                                              ),
                                              child: const Center(
                                                child: Icon(Icons.insert_link),
                                              ),
                                            ),
                                            Center(
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    top: 4),
                                                child: const Text(
                                                  '复制链接',
                                                  style: TextStyle(
                                                      color: Colors.black45,
                                                      fontSize: 12),
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                    Container(
                                        margin:
                                            const EdgeInsets.only(right: 20),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 36,
                                              height: 36,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color.fromRGBO(
                                                    255, 155, 38, 1),
                                              ),
                                              child: const Center(
                                                child: Icon(Icons.image),
                                              ),
                                            ),
                                            Center(
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    top: 4),
                                                child: const Text(
                                                  '生成图片',
                                                  style: TextStyle(
                                                      color: Colors.black45,
                                                      fontSize: 12),
                                                ),
                                              ),
                                            )
                                          ],
                                        ))
                                  ]))),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(
                                  left: 15, right: 15, bottom: 15),
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(children: [
                                    Container(
                                        margin:
                                            const EdgeInsets.only(right: 20),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 36,
                                              height: 36,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color.fromRGBO(
                                                    243, 243, 243, 1),
                                              ),
                                              child: const Center(
                                                child: Icon(
                                                  Icons.weekend,
                                                  color: Colors.black45,
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    top: 4),
                                                child: const Text(
                                                  '一起看视频',
                                                  style: TextStyle(
                                                      color: Colors.black45,
                                                      fontSize: 12),
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                    Container(
                                        margin:
                                            const EdgeInsets.only(right: 20),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 36,
                                              height: 36,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color.fromRGBO(
                                                    243, 243, 243, 1),
                                              ),
                                              child: const Center(
                                                child: Icon(
                                                  Icons.report_problem,
                                                  color: Colors.black45,
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    top: 4),
                                                child: const Text(
                                                  '举报',
                                                  style: TextStyle(
                                                      color: Colors.black45,
                                                      fontSize: 12),
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                    Container(
                                        margin:
                                            const EdgeInsets.only(right: 20),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 36,
                                              height: 36,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color.fromRGBO(
                                                    243, 243, 243, 1),
                                              ),
                                              child: const Center(
                                                child: Icon(
                                                  Icons.people_alt,
                                                  color: Colors.black45,
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    top: 4),
                                                child: const Text(
                                                  '合拍',
                                                  style: TextStyle(
                                                      color: Colors.black45,
                                                      fontSize: 12),
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                    Container(
                                        margin:
                                            const EdgeInsets.only(right: 20),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 36,
                                              height: 36,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color.fromRGBO(
                                                    243, 243, 243, 1),
                                              ),
                                              child: const Center(
                                                child: Icon(
                                                  Icons.motion_photos_auto,
                                                  color: Colors.black45,
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    top: 4),
                                                child: const Text(
                                                  '动态壁纸',
                                                  style: TextStyle(
                                                      color: Colors.black45,
                                                      fontSize: 12),
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                    Container(
                                        margin:
                                            const EdgeInsets.only(right: 20),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 36,
                                              height: 36,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color.fromRGBO(
                                                    243, 243, 243, 1),
                                              ),
                                              child: const Center(
                                                child: Icon(
                                                  Icons.heart_broken,
                                                  color: Colors.black45,
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    top: 4),
                                                child: const Text(
                                                  '不感兴趣',
                                                  style: TextStyle(
                                                      color: Colors.black45,
                                                      fontSize: 12),
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                  ])))
                        ],
                      ));
                },
              );
            },
            child: Column(
              children: [
                Icon(
                  Icons.share,
                  color: Colors.white,
                  size: 0.1.sw,
                ),
                SizedBox(
                  height: 26,
                  child: Text(
                    widget.shareCount == 0
                        ? '分享'
                        : widget.shareCount.toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                )
              ],
            ),
          ),
          CircleAvatarAnimation(
              isPlaying: widget.isPlaying, avatar: widget.avatar)
        ],
      ),
    );
  }
}
