import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:myweb/helper/palette.dart';
import 'package:myweb/screen/component/section.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';

const _heroPhoto = "assets/images/avatar_hero.webp";
const _aboutPhoto = "assets/images/avatar_about.webp";

class HeroSection extends StatelessWidget {
  final VoidCallback onContact;

  const HeroSection({super.key, required this.onContact});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveBreakpoints.of(context).isDesktop;

    final intro = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // An emoji here makes CanvasKit download a color emoji font at runtime.
        Icon(Icons.waving_hand_rounded, size: isDesktop ? 64 : 48, color: Palette.accent),
        const Gap(16),
        Text("Hi, it's me\nFaruq.",
            style: displayStyle(context,
                desktop: (MediaQuery.sizeOf(context).width * 0.06).clamp(56, 84).toDouble(), mobile: 50)),
        const Gap(20),
        Text("Mobile Engineer by Craft,\nFull-Stack by Practice.",
            style: TextStyle(
                fontFamily: bodyFont,
                fontSize: isDesktop ? 26 : 20,
                height: 1.25,
                fontWeight: FontWeight.w500,
                color: Palette.body)),
        Gap(isDesktop ? 48 : 32),
        PillButton(label: "Contact Me", onPressed: onContact),
      ],
    );

    return Section(
      floating: const [
        Positioned(left: 56, top: 120, child: FloatingBadge(asset: "assets/images/ic_firebase.webp", size: 70, dim: true, turns: -0.05)),
        Positioned(left: 96, bottom: 40, child: FloatingBadge(asset: "assets/images/ic_typescript.webp", size: 56, dim: true, turns: 0.05, reverse: true)),
      ],
      child: isDesktop
          ? Row(children: [
              Expanded(flex: 5, child: Padding(padding: const EdgeInsets.only(left: 56), child: intro)),
              const Expanded(flex: 6, child: _HeroPortrait(size: 520)),
            ])
          : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              intro,
              const Gap(24),
              const Center(child: _HeroPortrait(size: 320)),
            ]),
    );
  }
}

class _HeroPortrait extends StatelessWidget {
  final double size;
  const _HeroPortrait({required this.size});

  @override
  Widget build(BuildContext context) {
    final badge = size * 0.14;
    return SizedBox.square(
      dimension: size,
      child: Stack(clipBehavior: Clip.none, alignment: Alignment.center, children: [
        Glow(size: size * 1.25),
        Container(
          width: size * 0.74,
          height: size * 0.74,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: Palette.heading.withValues(alpha: 0.22), blurRadius: 50, offset: const Offset(0, 24))],
          ),
          child: ClipOval(
              child: Image.asset(_heroPhoto,
                  fit: BoxFit.cover, semanticLabel: "Illustrated portrait of Suhaili Faruq in front of Flutter and Go code")),
        ),
        Align(
            alignment: const Alignment(-0.95, 0.05),
            child: FloatingBadge(asset: "assets/images/ic_react_native.webp", size: badge, turns: -0.04)),
        Align(
            alignment: const Alignment(0.92, -0.92),
            child: FloatingBadge(asset: "assets/images/ic_flutter.webp", size: badge, turns: 0.05, reverse: true)),
        Align(
            alignment: const Alignment(1.0, 0.62),
            child: FloatingBadge(asset: "assets/images/ic_kotlin.webp", size: badge, turns: -0.05)),
      ]),
    );
  }
}

class AboutSection extends StatelessWidget {
  final VoidCallback onMore;
  const AboutSection({super.key, required this.onMore});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveBreakpoints.of(context).isDesktop;
    const paragraph = TextStyle(fontFamily: bodyFont, fontSize: 17, height: 1.7, fontWeight: FontWeight.w500, color: Palette.body);

    final story = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("ABOUT MYSELF", style: eyebrowStyle),
        const Gap(10),
        Text("Know About Me\nIn Detail", style: displayStyle(context)),
        const Gap(20),
        const Text(
            "I'm a mobile engineer with 4+ years building offline-first apps in React Native, Flutter, and Kotlin, "
            "and 7 releases on the Play Store and App Store. I also build REST APIs in Go and Kotlin on PostgreSQL and Redis, "
            "and I work full-stack on a production POS system at Reddog. I use Claude Code to plan, test, and debug, "
            "so I ship features faster without skipping checks.",
            style: paragraph),
        const Gap(24),
        const _ContactLine(icon: Icons.location_on, label: "Kotawaringin Barat, Indonesia"),
        _ContactLine(icon: Icons.phone, label: "+62 857-1356-1437", uri: Uri(scheme: "tel", path: "+6285713561437")),
        _ContactLine(
            icon: Icons.email,
            label: "suhaili.faruq01@gmail.com",
            uri: Uri(scheme: "mailto", path: "suhaili.faruq01@gmail.com")),
        const Gap(32),
        PillButton(label: "See My Experience", onPressed: onMore),
      ],
    );

    return Section(
      floating: const [
        Positioned(left: 70, top: 90, child: FloatingBadge(asset: "assets/images/ic_git.webp", size: 56, dim: true, turns: 0.04)),
      ],
      child: isDesktop
          ? Row(children: [
              Expanded(child: Padding(padding: const EdgeInsets.only(left: 56), child: story)),
              const Gap(48),
              const Expanded(child: _AboutPortrait(height: 520)),
            ])
          : Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              story,
              const Gap(40),
              const _AboutPortrait(height: 400),
            ]),
    );
  }
}

/// Arch-cropped photo with squiggles and floating badges, mirroring the reference's second illustration.
class _AboutPortrait extends StatelessWidget {
  final double height;
  const _AboutPortrait({required this.height});

  @override
  Widget build(BuildContext context) {
    final width = height * 0.68;
    return SizedBox(
      height: height,
      child: Stack(clipBehavior: Clip.none, alignment: Alignment.center, children: [
        Glow(size: height * 1.1),
        Container(
          width: width,
          height: height * 0.86,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(width / 2), bottom: const Radius.circular(36)),
            boxShadow: [BoxShadow(color: Palette.heading.withValues(alpha: 0.2), blurRadius: 40, offset: const Offset(0, 20))],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(width / 2), bottom: const Radius.circular(36)),
            // The figure stands on the right of the whiteboard; keep him and part of the sketch in frame.
            child: Image.asset(_aboutPhoto,
                fit: BoxFit.cover,
                alignment: const Alignment(0.55, 0),
                semanticLabel: "Suhaili Faruq sketching a Flutter, React Native, and Go architecture on a whiteboard"),
          ),
        ),
        Positioned(left: 0, bottom: height * 0.08, child: Squiggle(height: height * 0.22)),
        Positioned(right: 0, bottom: height * 0.08, child: Squiggle(height: height * 0.22)),
        Positioned(
            right: height * 0.02,
            top: height * 0.18,
            child: FloatingBadge(asset: "assets/images/ic_js.webp", size: height * 0.13, turns: 0.04)),
        Positioned(
            left: height * 0.04,
            top: height * 0.02,
            child: FloatingBadge(asset: "assets/images/ic_android.webp", size: height * 0.11, turns: -0.04, reverse: true)),
      ]),
    );
  }
}

class _ContactLine extends StatelessWidget {
  final IconData icon;
  final String label;
  final Uri? uri;

  const _ContactLine({required this.icon, required this.label, this.uri});

  @override
  Widget build(BuildContext context) {
    final line = Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 20, color: Palette.heading),
        const Gap(14),
        Flexible(
            child: Text(label,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Palette.heading))),
      ]),
    );
    if (uri == null) return line;
    return InkWell(borderRadius: BorderRadius.circular(8), onTap: () => launchUrl(uri!), child: line);
  }
}
