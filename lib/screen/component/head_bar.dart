import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myweb/helper/palette.dart';
import 'package:myweb/provider/provider_download.dart';
import 'package:myweb/screen/component/section.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';

class HeadBar extends ConsumerWidget {
  /// Nav label -> scroll action, in display order.
  final Map<String, VoidCallback> links;

  /// Index into [links] of the section currently on screen.
  final int activeIndex;

  const HeadBar({super.key, required this.links, this.activeIndex = 0});

  Future<void> _openResume(WidgetRef ref) async {
    final ready = ref.read(providerDownloadData).isNotEmpty;
    if (!ready) await ref.read(providerDownloadData.notifier).downloadData();
    final url = ref.read(providerDownloadData);
    // Browsers block a new tab opened after an await, so a late link opens in this tab instead.
    if (url.isNotEmpty) await launchUrl(Uri.parse(url), webOnlyWindowName: ready ? "_blank" : "_self");
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDesktop = ResponsiveBreakpoints.of(context).isDesktop;

    return Material(
      color: Palette.background.withValues(alpha: 0.96),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: maxContentWidth),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: gutterOf(context), vertical: isDesktop ? 22 : 12),
            child: Row(
              children: [
                InkWell(
                  onTap: links.values.first,
                  child: Image.asset("assets/images/logo.webp",
                      height: isDesktop ? 46 : 38, semanticLabel: "Suhaili Faruq, back to top"),
                ),
                if (isDesktop) ...[
                  Expanded(
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      for (final (i, link) in links.entries.indexed)
                        _NavLink(label: link.key, active: i == activeIndex, onTap: link.value),
                    ]),
                  ),
                  PillButton(label: "Download Resume", onPressed: () => _openResume(ref)),
                ] else ...[
                  // Section links live in the floating bottom bar on narrow screens.
                  const Spacer(),
                  PillButton(label: "Resume", icon: Icons.download_rounded, onPressed: () => _openResume(ref)),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Desktop nav link; the active one gets the same gradient pill as the mobile bottom bar.
class _NavLink extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _NavLink({required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Semantics(
        selected: active,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(100),
          child: AnimatedContainer(
            duration: MediaQuery.disableAnimationsOf(context) ? Duration.zero : const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              gradient: active ? Palette.buttonGradient : null,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(label,
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w700, color: active ? Colors.white : Palette.heading)),
          ),
        ),
      ),
    );
  }
}
