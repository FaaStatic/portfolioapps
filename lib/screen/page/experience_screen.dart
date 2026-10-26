import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:myweb/provider/provider_working.dart';
import 'package:myweb/screen/component/experience_item.dart';
import 'package:myweb/screen/component/section.dart';

class ExperienceScreen extends ConsumerStatefulWidget {
  const ExperienceScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExperienceScreenState();
}

class _ExperienceScreenState extends ConsumerState<ExperienceScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(providerWorkingGet.notifier).getAllData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final experiences = ref.watch(providerWorkingGet);

    return Section(
      panel: true,
      eyebrow: "My Journey",
      title: "Experience",
      child: experiences.isEmpty
          ? Center(child: Lottie.asset("assets/images/anim_loading.json", width: 150, height: 150))
          : Column(children: [
              for (var i = 0; i < experiences.length; i++)
                ExperienceItem(model: experiences[i], isLast: i == experiences.length - 1),
            ]),
    );
  }
}
