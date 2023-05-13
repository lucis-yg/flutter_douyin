import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_douyin/pages/follow/follow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:nested_scroll_views/material.dart';
// import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
// import 'package:nested_scroll_views/material.dart';

import '../../widgets/quicker_scroll_physics.dart';
import '../../widgets/bottom_navigation_item.dart';

// 引入视频滑动页面
import 'recommend_video.dart';

// 引入商城页面
import './shop.dart';
// 地点
import './location.dart';
//经验
import './experience.dart';

import './../../pages/friends/friends.dart';
import './../../pages/message/message.dart';
import './../../pages/mine/mine.dart';

class Home extends StatefulWidget {
  final Function changePopup;

  const Home({
    Key? key,
    required this.changePopup,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  int _currentIndex = 4;
  int _currentPageIndex = 0;
  late TabController _tabController;
  Color? _labelColor = Colors.white;
  bool _flag = true;
  double _colorPercent = 0;
  late PageController _pageController;
  final List _tabs = [
    '经验',
    '香洲区',
    '关注',
    '商城',
    '推荐',
  ];
  late final List _tabView = [
    const Experience(),
    const Location(),
    const Follow(),
    const Shop(),
    const Video()
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: _tabs.length, vsync: this, initialIndex: _tabs.length - 1);

    _tabController.animation?.addListener(_handleTabAnimation);
    _tabController.addListener(_handleTab);
    _pageController =
        PageController(initialPage: _currentPageIndex, keepPage: true);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _handleTab() {
    setState(() {
      _currentIndex = _tabController.index;
    });
  }

  void _handleTabAnimation() {
    setState(() {
      if (_tabController.offset.abs() == 0.0) return;
      if (_tabController.offset.abs() > 1 && _flag) {
        _flag = false;
        Future.delayed(const Duration(milliseconds: 250), () {
          _flag = true;
        });
        if ((_tabController.previousIndex == 0 && _tabController.index == 2) ||
            (_tabController.previousIndex == 3 && _tabController.index == 1) ||
            (_tabController.previousIndex == 0 && _tabController.index == 4)) {
          _labelColor = Colors.white;
          _colorPercent = 0;
        } else if ((_tabController.previousIndex == 2 &&
                _tabController.index == 0) ||
            (_tabController.previousIndex == 1 && _tabController.index == 3) ||
            (_tabController.previousIndex == 4 && _tabController.index == 0)) {
          _labelColor = Colors.black;
          _colorPercent = 1;
        }
      }
      if (!_flag) return;
      if ((_tabController.offset < 0 && _tabController.index == 4) ||
          (_tabController.offset > 0 && _tabController.index == 2) ||
          (_tabController.offset < 0 && _tabController.index == 1)) {
        _colorPercent = _tabController.offset.abs();

        _labelColor =
            Color.lerp(Colors.white, Colors.black, _tabController.offset.abs());
      } else if ((_tabController.offset > 0 && _tabController.index == 3) ||
          (_tabController.offset < 0 && _tabController.index == 3) ||
          (_tabController.offset > 0 && _tabController.index == 0)) {
        _colorPercent = 1 - _tabController.offset.abs();
        _labelColor =
            Color.lerp(Colors.black, Colors.white, _tabController.offset.abs());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      extendBody: true,
      extendBodyBehindAppBar: true,
      bottomNavigationBar: BottomAppBar(
          height: 50,
          color: Color.fromRGBO(255, 255, 255, _colorPercent),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BottomNavigationItem(
                currentIndex: _currentPageIndex,
                labelColor: _labelColor,
                index: 0,
                label: '首页',
                changeNavigationPage: changeNavigationPage,
              ),
              BottomNavigationItem(
                currentIndex: _currentPageIndex,
                labelColor: _labelColor,
                index: 1,
                label: '朋友',
                changeNavigationPage: changeNavigationPage,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 5,
                  child: Icon(
                    Icons.add_box,
                    size: 36,
                    color: Color.fromRGBO(
                        (255 * (1 - _colorPercent)).toInt(),
                        (255 * (1 - _colorPercent)).toInt(),
                        (255 * (1 - _colorPercent)).toInt(),
                        1),
                  ),
                ),
              ),
              BottomNavigationItem(
                currentIndex: _currentPageIndex,
                labelColor: _labelColor,
                index: 2,
                label: '消息',
                changeNavigationPage: changeNavigationPage,
              ),
              BottomNavigationItem(
                currentIndex: _currentPageIndex,
                labelColor: _labelColor,
                index: 3,
                label: '我',
                changeNavigationPage: changeNavigationPage,
              ),
            ],
          )),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          MaterialApp(
              theme: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                colorScheme: const ColorScheme.dark().copyWith(
                  secondary: const Color.fromRGBO(200, 200, 200, 0.1),
                ),
                appBarTheme: AppBarTheme(
                  systemOverlayStyle: [0, 3].contains(_currentIndex)
                      ? SystemUiOverlayStyle.dark
                      : SystemUiOverlayStyle.light, // 设置为亮色模式
                ),
              ),
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.transparent,
                extendBody: true,
                extendBodyBehindAppBar: true,
                appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(40),
                    child: AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      titleSpacing: 0,
                      leading: IconButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        icon: Icon(
                          Icons.menu_open,
                          color: _labelColor,
                        ),
                        onPressed: () {
                          widget.changePopup();
                        },
                      ),
                      centerTitle: true,
                      title: TabBar(
                        controller: _tabController,
                        onTap: (value) {
                          // print(value);
                          setState(() {
                            _currentIndex = value;
                          });
                        },
                        isScrollable: true,
                        indicatorSize: TabBarIndicatorSize.label, //设置指示器大小
                        indicatorColor: _labelColor,
                        labelColor: _labelColor,
                        labelStyle: TextStyle(
                            // fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontSize: 0.04.sw),
                        indicatorPadding: const EdgeInsets.only(
                            bottom: 10, right: 4, left: 4),
                        labelPadding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                        ), //设置文字padding
                        tabs: _tabs
                            .map((tab) => Tab(
                                  child: Container(
                                    padding: const EdgeInsets.all(0),
                                    child: Tab(
                                      text: tab,
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                      actions: [
                        IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            // Do something when the user taps on the overflow icon
                          },
                        ),
                      ],
                    )),
                body: Stack(
                  children: [
                    Container(
                      color: Colors.black,
                      child: NestedTabBarView(
                        physics: const QuickerScrollPhysics(),
                        controller: _tabController,
                        children: _tabView.map((view) {
                          return Container(
                            child: view,
                          );
                        }).toList(),
                      ),
                    ),
                    Positioned(
                        child: _colorPercent == 0
                            ? Container(
                                height: 80,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0x66000000),
                                        Color(0x00000000),
                                      ]),
                                ),
                              )
                            : const Text('')),
                  ],
                ),
              )),
          const Friends(),
          const Message(),
          const Mine()
        ],
      ),
    );
  }

  void changeNavigationPage(index) {
    setState(() {
      if ([2, 3].contains(index)) {
        _colorPercent = 1;
        _labelColor = Colors.black;
        SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ));
      } else if (index == 1) {
        _colorPercent = 0;
        _labelColor = Colors.white;
        SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
        ));
      } else if (index == 0) {
        if ([0, 3].contains(_currentIndex)) {
          _colorPercent = 1;
          _labelColor = Colors.black;
          SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
          ));
        } else {
          _colorPercent = 0;
          _labelColor = Colors.white;
        }
      }

      _currentPageIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  bool get wantKeepAlive => true;
}
