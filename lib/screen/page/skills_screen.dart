import 'package:colorful_iconify_flutter/icons/logos.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:myweb/helper/palette.dart';
import 'package:myweb/screen/component/section.dart';

/// A small tool badge: an Iconify [logo] SVG or a bundled [asset] image. [wide] fits wordmarks.
class _Tool {
  final String name;
  final String? logo;
  final String? asset;
  final bool wide;

  const _Tool(this.name, {this.logo, this.asset, this.wide = false});
}

/// Every claim here comes from the resume, the GitHub profile README, or the LinkedIn summary.
class _Skill {
  final String category;
  final String title;
  final String text;

  /// Brand logo SVG; when null, [icon] is drawn on the primary gradient tile.
  final String? logo;
  final IconData? icon;
  final List<_Tool> tools;

  const _Skill(
      {required this.category,
      required this.title,
      required this.text,
      this.logo,
      this.icon,
      this.tools = const []});
}

const _skills = [
  _Skill(
      category: "Mobile",
      title: "React Native",
      logo: Logos.react,
      text: "Expo and bare 0.87, New Architecture, Re.Pack, Nitro modules, TanStack Query, Zustand, NativeWind.",
      tools: [
        _Tool("Expo", logo: Logos.expo_icon),
        _Tool("TanStack Query", logo: Logos.react_query_icon),
        _Tool("TypeScript", logo: Logos.typescript_icon),
      ]),
  _Skill(
      category: "Mobile",
      title: "Flutter",
      logo: Logos.flutter,
      text: "Riverpod, BLoC, and Clean Architecture. Four of my seven published apps run on Flutter.",
      tools: [
        _Tool("Dart", logo: Logos.dart),
        _Tool("Riverpod", asset: "assets/images/ic_riverpod.png"),
        _Tool("BLoC", asset: "assets/images/ic_bloc.png"),
      ]),
  _Skill(
      category: "Mobile",
      title: "Kotlin",
      logo: Logos.kotlin_icon,
      text: "Native Android with MVVM, Hilt, Room, and WorkManager. Jetpack Compose and Kotlin Multiplatform.",
      tools: [_Tool("Android", logo: Logos.android_icon), _Tool("Ktor", logo: Logos.ktor_icon)]),
  _Skill(
      category: "Backend",
      title: "Go",
      logo: Logos.go,
      text: "REST APIs with Fiber v3 and Gin, gRPC, GORM, Cobra CLI, and Swagger. Kafka and Elasticsearch at Reddog.",
      tools: [
        _Tool("Fiber", asset: "assets/images/ic_fiber.png", wide: true),
        _Tool("Gin", logo: Logos.gin),
        _Tool("Swagger", logo: Logos.swagger),
      ]),
  _Skill(
      category: "Web",
      title: "React & TypeScript",
      logo: Logos.typescript_icon,
      text: "React with Redux Toolkit, React Router, Chart.js, and FullCalendar. Vite and TanStack Router at Reddog.",
      tools: [_Tool("React", logo: Logos.react), _Tool("Vite", logo: Logos.vitejs), _Tool("Redux", logo: Logos.redux)]),
  _Skill(
      category: "Data",
      title: "Database",
      logo: Logos.postgresql,
      text: "PostgreSQL, Redis, and MySQL on the server. Realm, drift, and Room for offline storage on the device.",
      tools: [
        _Tool("Redis", logo: Logos.redis),
        _Tool("MySQL", logo: Logos.mysql_icon),
        _Tool("Realm", logo: Logos.realm),
        // Room ships no logo of its own; it is part of Android Jetpack.
        _Tool("Room (Android Jetpack)", logo: Logos.android_icon),
      ]),
  _Skill(
      category: "Practice",
      title: "Architecture",
      icon: Icons.account_tree_rounded,
      text: "Clean Architecture, MVVM, offline-first sync, Module Federation, and Nx and Melos monorepos."),
  _Skill(
      category: "Practice",
      title: "Performance",
      icon: Icons.speed_rounded,
      text: "Startup and bundle optimization, memoization, lazy loading and pagination, FlashList, query cache tuning."),
  _Skill(
      category: "Practice",
      title: "Mobile Security",
      icon: Icons.shield_rounded,
      text: "Root and jailbreak detection, screenshot prevention, encrypted storage, JWT access and refresh tokens, BCrypt."),
  _Skill(
      category: "Practice",
      title: "Testing",
      logo: Logos.jest,
      text: "Jest, React Native Testing Library, and Mockito. 100+ unit and UI tests on COIP Mobile.",
      tools: [_Tool("Testing Library", logo: Logos.testing_library)]),
  _Skill(
      category: "Tooling",
      title: "DevOps & Release",
      logo: Logos.docker_icon,
      text: "Docker Compose, Nginx on a Linux VPS, Git, Azure DevOps, JIRA. Firebase FCM, Crashlytics, and Analytics. "
          "Play Store and App Store releases.",
      tools: [
        _Tool("Nginx", logo: Logos.nginx),
        _Tool("Git", logo: Logos.git_icon),
        _Tool("Azure DevOps", logo: Logos.azure_icon),
        _Tool("Firebase", logo: Logos.firebase),
      ]),
  _Skill(
      category: "Tooling",
      title: "AI-Assisted Dev",
      icon: Icons.auto_awesome_rounded,
      text: "Claude Code to plan changes, implement against tests, run checks, and trace bugs to the root cause. "
          "A CLAUDE.md per repo, Context7 docs, and hooks."),
];

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Section(
      panel: true,
      eyebrow: "Skills I Have:",
      title: "My Skills",
      subtitle: "Tools I use across mobile, web, and backend work.",
      floating: const [
        Positioned(right: 48, top: 40, child: FloatingBadge(asset: "assets/images/ic_dart.png", size: 58, blur: 1.5, turns: 0.06)),
      ],
      child: ResponsiveGrid(
        minItemWidth: 220,
        maxColumns: 4,
        children: [for (final skill in _skills) _SkillCard(skill: skill)],
      ),
    );
  }
}

class _SkillCard extends StatelessWidget {
  final _Skill skill;
  const _SkillCard({required this.skill});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 24, 22, 24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(28)),
      child: Column(children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(color: Palette.background, borderRadius: BorderRadius.circular(100)),
          child: Text(skill.category,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Palette.primary)),
        ),
        const Gap(18),
        SizedBox.square(
          dimension: 60,
          child: skill.logo != null
              ? Iconify(skill.logo!, size: 60)
              : DecoratedBox(
                  decoration: BoxDecoration(gradient: Palette.buttonGradient, borderRadius: BorderRadius.circular(18)),
                  child: Icon(skill.icon, size: 32, color: Colors.white),
                ),
        ),
        const Gap(20),
        Text(skill.title.toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 19, height: 1.2, fontWeight: FontWeight.w800, color: Palette.heading)),
        const Gap(10),
        Text(skill.text,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontFamily: bodyFont, fontSize: 15, height: 1.6, fontWeight: FontWeight.w500, color: Palette.body)),
        const Spacer(),
        if (skill.tools.isNotEmpty) ...[
          const Gap(16),
          Wrap(alignment: WrapAlignment.center, spacing: 10, runSpacing: 10, children: [
            for (final tool in skill.tools)
              Tooltip(
                message: tool.name,
                child: Container(
                  width: tool.wide ? 76 : 38,
                  height: 38,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Palette.background, borderRadius: BorderRadius.circular(12)),
                  child: tool.asset != null
                      ? Image.asset(tool.asset!, fit: BoxFit.contain, semanticLabel: tool.name)
                      : Iconify(tool.logo!, size: 22),
                ),
              ),
          ]),
        ],
      ]),
    );
  }
}
