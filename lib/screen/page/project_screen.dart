import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:myweb/provider/provider_project.dart';
import 'package:myweb/screen/component/item_project.dart';
import 'package:myweb/screen/component/section.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ProjectScreen extends ConsumerStatefulWidget {
  const ProjectScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends ConsumerState<ProjectScreen> {
  static const _initialCount = 8;
  bool _showAll = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(providerProjectGet.notifier).getAllData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final projects = ref.watch(providerProjectGet);

    return Section(
      panel: true,
      eyebrow: "My Projects",
      title: "Some of My Works",
      floating: const [
        Positioned(right: 40, top: 160, child: FloatingBadge(asset: "assets/images/ic_react_js.webp", size: 60, dim: true, turns: -0.06)),
      ],
      child: projects.isEmpty
          ? Center(child: Lottie.asset("assets/images/anim_loading.json", width: 150, height: 150))
          : Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: SizedBox(
                  height: ResponsiveBreakpoints.of(context).isMobile ? 220 : 400,
                  child: Image.asset("assets/images/avatar_projects.webp",
                      fit: BoxFit.cover,
                      // Frame the upper part of the shot so the face sits inside the banner.
                      alignment: const Alignment(0.3, -0.6),
                      semanticLabel: "Suhaili Faruq writing code on two monitors"),
                ),
              ),
              const Gap(32),
              ResponsiveGrid(
                minItemWidth: 220,
                maxColumns: 4,
                children: [
                  for (var i = 0; i < (_showAll ? projects.length : _initialCount.clamp(0, projects.length)); i++)
                    ItemProject(model: projects[i], index: i),
                ],
              ),
              if (projects.length > _initialCount) ...[
                const Gap(40),
                Center(
                  child: PillButton(
                    label: _showAll ? "Show fewer projects" : "Show all ${projects.length} projects",
                    outlined: _showAll,
                    onPressed: () => setState(() => _showAll = !_showAll),
                  ),
                ),
              ],
            ]),
    );
  }
}
