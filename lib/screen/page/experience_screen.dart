import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:myweb/helper/util.dart';
import 'package:myweb/provider/provider_working.dart';

import 'package:myweb/screen/component/experience_item.dart';

class ExperienceScreen extends ConsumerStatefulWidget {
  const ExperienceScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExperienceScreenState();
}

class _ExperienceScreenState extends ConsumerState<ExperienceScreen> {
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(providerWorkingGet.notifier).getAllData();
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    return SizedBox(
      width: widthScreen,
      child: ListView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding:
            EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15, left: 28, right: 28),
        children: [
          const Gap(24),
          Container(
            height: 80,
            width: 80,
            decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
            child: Center(
              child: SvgPicture.asset(
                "assets/images/ic_koper.svg",
                width: 45,
                height: 45,
                color: Colors.white,
              ),
            ),
          ),
          const Gap(16),
          const Align(
            alignment: Alignment.center,
            child: Text(
              "Experience Work",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
            ),
          ),
          const Gap(8),
          const Align(
              alignment: Alignment.center,
              child: Text(
                "Here are the experiences I have gone through in this job",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),
                textAlign: TextAlign.left,
              )),
          const Gap(16),
          Container(
              width: Util().autoSizing(context, stat: 1), height: 1, color: Colors.blue.shade600),
          const Gap(24),
          Consumer(builder: (context, ref, _) {
            var response = ref.watch(providerWorkingGet);
            if (response.isNotEmpty) {
              return ListView.builder(
                  padding: const EdgeInsets.only(left: 28, right: 28),
                  itemCount: response.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => ExperienceItem(
                      model: response.elementAt(index),
                      isLast: index == (response.length - 1) ? true : false));
            } else {
              return SizedBox(
                width: Util().autoSizing(context, stat: 1),
                height: Util().autoSizing(context, stat: 2),
                child: Center(
                  child: Lottie.asset("assets/images/anim_loading.json",
                      repeat: true, frameRate: FrameRate.composition, width: 150, height: 150),
                ),
              );
            }
          }),
          const Gap(28),
        ],
      ),
    );
  }
}
