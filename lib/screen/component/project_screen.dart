import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:myweb/helper/util.dart';
import 'package:myweb/screen/component/item_project.dart';

class ProjectScreen extends ConsumerStatefulWidget {
  const ProjectScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends ConsumerState<ProjectScreen> {
  List<int> listing = [1, 2, 3, 4, 5, 6, 7, 8];
  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Util().autoSizing(
          context,
          stat: 1,
        ),
        height: Util().autoSizing(
          context,
          stat: 2,
        ),
        child: SingleChildScrollView(
          controller: _controller,
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15, left: 28, right: 28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/images/ic_project.svg",
                    width: 45,
                    height: 45,
                    color: Colors.white,
                  ),
                ),
              ),
              const Gap(4),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Recent Work",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
                ),
              ),
              const Gap(8),
              const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Here are the list project while i working on programming job: ",
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),
                    textAlign: TextAlign.left,
                  )),
              const Gap(16),
              Container(
                  width: Util().autoSizing(context, stat: 1),
                  height: 1,
                  color: Colors.blue.shade600),
              const Gap(24),
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 25,
                runSpacing: 25,
                children: [
                  ...listing.map((item) => ItemProject(
                        callBack: (value) {},
                      )),
                ],
              ),
            ],
          ),
        ));
  }
}
