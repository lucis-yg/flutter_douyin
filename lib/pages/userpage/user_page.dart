import 'package:flutter/material.dart';
import 'package:flutter_douyin/widgets/quicker_scroll_physics.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'goods_list.dart';
import 'header_info.dart';
import 'main_info.dart';
import 'video_list.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late TabController _tabController;
  bool navbarColorWhite = true;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _scrollController.addListener(scrollListen);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(scrollListen);
    _tabController.dispose();
    _scrollController.dispose();
  }

  void scrollListen() {
    if (_scrollController.position.pixels >= 130) {
      if (navbarColorWhite) {
        setState(() {
          navbarColorWhite = false;
        });
      }
    } else {
      if (!navbarColorWhite) {
        setState(() {
          navbarColorWhite = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
            body: NestedScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                // physics: const NeverScrollableScrollPhysics(),
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      elevation: 1,
                      pinned: true,
                      backgroundColor: Colors.white,
                      expandedHeight: 200,
                      stretch: true,
                      leading: Icon(
                        Icons.arrow_back_ios,
                        color: navbarColorWhite ? Colors.white : Colors.black,
                      ),
                      actions: [
                        Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: navbarColorWhite
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            const SizedBox(width: 10),
                            Icon(
                              Icons.more_horiz,
                              color: navbarColorWhite
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            const SizedBox(width: 16)
                          ],
                        )
                      ],
                      title: navbarColorWhite
                          ? const SizedBox()
                          : Container(
                              width: 80,
                              padding: const EdgeInsets.only(
                                  left: 6, top: 2, bottom: 2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: const Color.fromRGBO(255, 243, 245, 1),
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 0.03.sw,
                                    backgroundColor: Colors.white,
                                    backgroundImage: const NetworkImage(
                                        'https://p3-pc.douyinpic.com/img/aweme-avatar/tos-cn-avt-0015_dd6bbf583de38e271b63b18a3bb36ae2~c5_300x300.jpeg?from=2956013662'),
                                  ),
                                  const Icon(
                                    Icons.add,
                                    color: Colors.pinkAccent,
                                    size: 18,
                                  ),
                                  const Text(
                                    '关注',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.pinkAccent,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                      flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.pin,
                          centerTitle: true,
                          background: Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://s1.ax1x.com/2023/05/11/p9rbbdK.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  const HeaderInfo(),
                                  Positioned(
                                      top: 210,
                                      left: 0,
                                      right: 0,
                                      bottom: 0,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10.0),
                                              topRight: Radius.circular(10.0),
                                            ),
                                            color: Colors.white
                                            // 其他装饰属性
                                            ),
                                      ))
                                ],
                              ))),
                    ),
                    const SliverToBoxAdapter(child: MainInfo()),
                    SliverPersistentHeader(
                      delegate: MyTabBar(_tabController),
                      pinned: true,
                    ),
                  ];
                },
                body: TabBarView(
                    physics: const QuickerScrollPhysics(),
                    controller: _tabController,
                    children: const [VideoList(), GoodsList()]))));
  }
}

class MyTabBar extends SliverPersistentHeaderDelegate {
  final TabController tabController;

  MyTabBar(this.tabController);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.grey),
        ),
      ),
      child: TabBar(
        controller: tabController,
        indicatorColor: Colors.black,
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
        tabs: const [
          Tab(text: '作品520'),
          Tab(text: '橱窗'),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 48;

  @override
  double get minExtent => 48;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
