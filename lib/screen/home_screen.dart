import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:myweb/helper/util.dart';
import 'package:myweb/provider/provider_tab.dart';
import 'package:myweb/screen/component/about_screen.dart';

import 'package:myweb/screen/component/head_bar.dart';
import 'package:myweb/screen/component/item_experience.dart';
import 'package:myweb/screen/component/item_project.dart';
import 'package:myweb/screen/component/project_screen.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with TickerProviderStateMixin {
  final PageController controller = PageController(initialPage: 0);

  List<int> listing = [1, 2, 3, 4, 5, 6, 7, 8];

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
          child: Stack(
        children: [
          Positioned.fill(
              child: PageView(
            allowImplicitScrolling: true,
            controller: controller,
            scrollDirection: Axis.vertical,
            onPageChanged: (value) {
              ref.read(providerChangeTab.notifier).changeTab(value);
            },
            children: const [AboutScreen(), ProjectScreen()],
          )),
          Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: HeadBar(
                refreshCallBack: () {},
                aboutCallBack: () {
                  controller.jumpToPage(0);
                },
                projectCallBack: () {
                  controller.jumpToPage(1);
                },
                contactCallBack: () {
                  controller.jumpToPage(2);
                },
              ))
        ],
      )),
    );
  }
}
