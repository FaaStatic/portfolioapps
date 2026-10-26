import 'package:colorful_iconify_flutter/icons/logos.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:myweb/helper/palette.dart';
import 'package:myweb/model/project_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemProject extends StatelessWidget {
  final ProjectModel model;
  final int index;
  const ItemProject({super.key, required this.model, required this.index});

  // First match wins, matched as whole words against framework_using.
  static final _frameworkLogos = {
    RegExp(r'\bflutter\b'): Logos.flutter,
    RegExp(r'\bexpo\b'): Logos.expo_icon,
    RegExp(r'\breact\b'): Logos.react,
    RegExp(r'\bkotlin\b'): Logos.kotlin_icon,
    RegExp(r'\bandroid\b'): Logos.android_icon,
    RegExp(r'\btensorflow\b'): Logos.tensorflow,
    RegExp(r'\bjava\b'): Logos.java,
    RegExp(r'\bgo\b'): Logos.go,
    RegExp(r'\bcodeigniter\b'): Logos.codeigniter_icon,
  };

  String? get _logo {
    final framework = (model.frameworkUsing ?? "").toLowerCase();
    for (final entry in _frameworkLogos.entries) {
      if (entry.key.hasMatch(framework)) return entry.value;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final logo = _logo;
    final links = [
      if (model.githubLink != null && !model.isPrivate) ("GitHub", model.githubLink!),
      if (model.playStoreLink != null) ("Play Store", model.playStoreLink!),
      if (model.appStoreLink != null) ("App Store", model.appStoreLink!),
      if (model.webLink != null) ("Website", model.webLink!),
    ];

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 32, 20, 24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(32)),
      child: Column(
        children: [
          Container(
            width: 128,
            height: 128,
            padding: const EdgeInsets.all(34),
            decoration: BoxDecoration(
                shape: BoxShape.circle, gradient: Palette.badgeGradients[index % Palette.badgeGradients.length]),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: logo != null ? Iconify(logo, size: 40) : const Icon(Icons.dns_rounded, color: Palette.primary, size: 36),
            ),
          ),
          const Gap(24),
          Text((model.frameworkUsing ?? "").toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, height: 1.25, fontWeight: FontWeight.w800, color: Palette.heading)),
          const Gap(8),
          Text(model.projectName ?? "",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 17, height: 1.3, fontWeight: FontWeight.w700, color: Palette.primary)),
          const Gap(6),
          Text("${model.projectBy ?? ""}, ${model.period}",
              textAlign: TextAlign.center,
              style: const TextStyle(fontFamily: bodyFont, fontSize: 13, fontWeight: FontWeight.w600, color: Palette.body)),
          const Gap(12),
          Text(model.descriptionProject ?? "",
              textAlign: TextAlign.center,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontFamily: bodyFont, fontSize: 14, height: 1.55, fontWeight: FontWeight.w500, color: Palette.body)),
          const Spacer(),
          const Gap(18),
          Wrap(alignment: WrapAlignment.center, spacing: 6, runSpacing: 6, children: [
            for (final (label, url) in links)
              ActionChip(
                label: Text(label),
                onPressed: () => launchUrl(Uri.parse(url)),
                backgroundColor: Palette.panel,
                labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Palette.heading),
                shape: const StadiumBorder(),
                side: BorderSide.none,
              ),
            if (model.isPrivate)
              const Chip(
                avatar: Icon(Icons.lock_rounded, size: 15, color: Palette.body),
                label: Text("Private repository"),
                backgroundColor: Palette.background,
                labelStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Palette.body),
                shape: StadiumBorder(),
                side: BorderSide.none,
              ),
          ]),
        ],
      ),
    );
  }
}
