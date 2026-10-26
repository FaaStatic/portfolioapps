import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myweb/provider/provider_download.dart';
import 'package:myweb/screen/component/floating_nav.dart';
import 'package:myweb/screen/component/head_bar.dart';
import 'package:myweb/screen/component/splash_overlay.dart';
import 'package:myweb/screen/page/about_screen.dart';
import 'package:myweb/screen/page/contact_screen.dart';
import 'package:myweb/screen/page/experience_screen.dart';
import 'package:myweb/screen/page/project_screen.dart';
import 'package:myweb/screen/page/skills_screen.dart';
import 'package:responsive_framework/responsive_framework.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _homeKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _experienceKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _contactKey = GlobalKey();
  final _headerLogoKey = GlobalKey();
  final _scroll = ScrollController();
  // Only the nav listens; a setState here would rebuild every section mid-scroll.
  final _activeSection = ValueNotifier(0);

  late final _sectionKeys = [_homeKey, _aboutKey, _skillsKey, _experienceKey, _projectsKey, _contactKey];

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_trackActiveSection);
    // Resolve the resume URL early so the click opens it directly (browsers block popups after an await).
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(providerDownloadData.notifier).downloadData();
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    _activeSection.dispose();
    super.dispose();
  }

  /// The active section is the last one whose top has passed the upper third of the screen.
  void _trackActiveSection() {
    final threshold = MediaQuery.sizeOf(context).height / 3;
    var active = 0;
    for (var i = 0; i < _sectionKeys.length; i++) {
      final box = _sectionKeys[i].currentContext?.findRenderObject() as RenderBox?;
      if (box != null && box.attached && box.localToGlobal(Offset.zero).dy <= threshold) active = i;
    }
    if (_scroll.position.extentAfter < 8) active = _sectionKeys.length - 1;
    _activeSection.value = active;
  }

  void _scrollTo(GlobalKey key) {
    final target = key.currentContext;
    if (target == null) return;
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    Scrollable.ensureVisible(target,
        duration: reduceMotion ? Duration.zero : const Duration(milliseconds: 600), curve: Curves.easeInOutCubic);
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveBreakpoints.of(context).isDesktop;
    final sections = <NavItem>[
      (label: "Home", icon: Icons.home_rounded, onTap: () => _scrollTo(_homeKey)),
      (label: "About", icon: Icons.person_rounded, onTap: () => _scrollTo(_aboutKey)),
      (label: "Skills", icon: Icons.bolt_rounded, onTap: () => _scrollTo(_skillsKey)),
      (label: "Experience", icon: Icons.work_rounded, onTap: () => _scrollTo(_experienceKey)),
      (label: "Projects", icon: Icons.grid_view_rounded, onTap: () => _scrollTo(_projectsKey)),
      (label: "Contact", icon: Icons.mail_rounded, onTap: () => _scrollTo(_contactKey)),
    ];

    return SplashOverlay(
      logoKey: _headerLogoKey,
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                ValueListenableBuilder(
                  valueListenable: _activeSection,
                  builder: (context, active, _) => HeadBar(
                      links: {for (final section in sections) section.label: section.onTap},
                      activeIndex: active,
                      logoKey: _headerLogoKey),
                ),
                Expanded(
                  child: SelectionArea(
                    child: SingleChildScrollView(
                      controller: _scroll,
                      child: Column(
                        children: [
                          // Without a boundary per section, every scroll frame re-records the whole page.
                          for (final section in [
                            HeroSection(key: _homeKey, onContact: () => _scrollTo(_contactKey)),
                            AboutSection(key: _aboutKey, onMore: () => _scrollTo(_experienceKey)),
                            SkillsSection(key: _skillsKey),
                            ExperienceScreen(key: _experienceKey),
                            ProjectScreen(key: _projectsKey),
                            ContactSection(key: _contactKey),
                            FooterSection(links: {
                              "About Me": () => _scrollTo(_aboutKey),
                              "My Skills": () => _scrollTo(_skillsKey),
                              "My Experience": () => _scrollTo(_experienceKey),
                              "My Projects": () => _scrollTo(_projectsKey),
                              "Contact Me": () => _scrollTo(_contactKey),
                            }),
                          ])
                            RepaintBoundary(child: section),
                          // Keeps the footer clear of the floating bottom bar.
                          if (!isDesktop) const SizedBox(height: 96),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (!isDesktop)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: ValueListenableBuilder(
                  valueListenable: _activeSection,
                  builder: (context, active, _) => FloatingNav(items: sections, activeIndex: active),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
