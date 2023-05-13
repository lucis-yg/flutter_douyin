import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_douyin/routes/routes.dart';
import 'package:flutter_douyin/widgets/quicker_scroll_physics.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:nested_scroll_views/material.dart';

import './pages/home/home.dart';
import './pages/userpage/user_page.dart';

void main() {
  runApp(const MyApp());
  SystemUiOverlayStyle uiStyle = const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(uiStyle);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            title: 'Flutter douyin',
            getPages: AppPage.routes,
            theme: ThemeData(
              primarySwatch: Colors.grey,
            ),
            debugShowCheckedModeBanner: false,
            home: const MyHomePage(),
          );
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ZoomDrawerController zoomDrawerController = ZoomDrawerController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
        controller: zoomDrawerController,
        menuBackgroundColor: Colors.white,
        slideWidth: MediaQuery.of(context).size.width * 0.75,
        angle: 0.0,
        mainScreenScale: 0,
        borderRadius: 0,
        mainScreenTapClose: true,
        mainScreenOverlayColor: Colors.black.withOpacity(0.1),
        showShadow: true,
        menuScreen: buildMenu(),
        mainScreen: NestedPageView(
          physics: const QuickerScrollPhysics(),
          children: [
            Home(
              changePopup: changePopup,
            ),
            const UserPage(),
          ],
        ));
  }

  void changePopup() {
    setState(() {});
    zoomDrawerController.toggle!();
  }

  Widget buildMenu() {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: const EdgeInsets.only(top: 30, left: 10, right: 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '晚上好',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: const [Icon(Icons.settings)],
                  )
                ],
              )
            ],
          ),
        ));
  }
}
