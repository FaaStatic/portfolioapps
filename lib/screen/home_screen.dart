import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myweb/helper/util.dart';
import 'package:myweb/provider/provider_tab.dart';

import 'package:myweb/screen/component/head_bar.dart';
import 'package:myweb/screen/page/about_screen.dart';
import 'package:myweb/screen/page/experience_screen.dart';
import 'package:myweb/screen/page/project_screen.dart';
import 'package:visibility_detector/visibility_detector.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with TickerProviderStateMixin {
  final PageController controller = PageController(
    initialPage: 0,
    keepPage: true,
  );

  final GlobalKey index1 = GlobalKey();
  final GlobalKey index2 = GlobalKey();
  final GlobalKey index3 = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  bool expandedHight = false;

  final List<int> listing = [1, 2, 3, 4, 5, 6, 7, 8];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
          width: widthScreen,
          height: heightScreen,
          child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                return false;
              },
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    floating: true,
                    shadowColor: null,
                    forceMaterialTransparency: true,
                    backgroundColor: Colors.transparent,
                    collapsedHeight: expandedHight
                        ? Util().autoSizing(context, stat: 2, percent: 0.45)
                        : Util().autoSizing(context, stat: 2, percent: 0.15),
                    flexibleSpace: HeadBar(
                        refreshCallBack: () {},
                        aboutCallBack: () {
                          _scrollController.position.ensureVisible(
                            index1.currentContext!.findRenderObject()!,
                            alignment: 0.0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.linear,
                          );
                        },
                        experienceCallBack: () {
                          _scrollController.position.ensureVisible(
                            index2.currentContext!.findRenderObject()!,
                            alignment: 0.0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.linear,
                          );
                        },
                        resumeCallBack: () {},
                        isExpanded: (status) {
                          setState(() {
                            expandedHight = status;
                          });
                        },
                        projectCallBack: () {
                          _scrollController.position.ensureVisible(
                            index3.currentContext!.findRenderObject()!,
                            alignment: 0.0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.linear,
                          );
                        }),
                  ),
                  SliverToBoxAdapter(
                    key: index1,
                    child: VisibilityDetector(
                        onVisibilityChanged: (info) {
                          var visiblePercentage = info.visibleFraction * 100;
                          if (visiblePercentage < 10) {
                            ref.read(providerChangeTab.notifier).changeTab(1);
                          } else {
                            ref.read(providerChangeTab.notifier).changeTab(0);
                          }
                        },
                        key: const ValueKey(0),
                        child: const AboutScreen()),
                  ),
                  SliverToBoxAdapter(
                      key: index2,
                      child: VisibilityDetector(
                        onVisibilityChanged: (info) {
                          var visiblePercentage = info.visibleFraction * 100;
                          if (_scrollController.position.userScrollDirection ==
                              ScrollDirection.forward) {
                            if (visiblePercentage < 10) {
                              ref.read(providerChangeTab.notifier).changeTab(0);
                            } else {
                              ref.read(providerChangeTab.notifier).changeTab(1);
                            }
                          }
                        },
                        key: const ValueKey(1),
                        child: const ExperienceScreen(),
                      )),
                  SliverToBoxAdapter(
                      key: index3,
                      child: VisibilityDetector(
                        onVisibilityChanged: (info) {
                          var visiblePercentage = info.visibleFraction * 100;
                          if (visiblePercentage < 10) {
                            ref.read(providerChangeTab.notifier).changeTab(1);
                          } else {
                            ref.read(providerChangeTab.notifier).changeTab(2);
                          }
                        },
                        key: const ValueKey(2),
                        child: const ProjectScreen(),
                      )),
                ],
              ))),
    );
  }
}

class CustomBehaviour extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}
