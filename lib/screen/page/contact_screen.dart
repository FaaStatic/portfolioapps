import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:myweb/helper/palette.dart';
import 'package:myweb/model/about_model.dart';
import 'package:myweb/model/contact_model.dart';
import 'package:myweb/repository/repository_data.dart';
import 'package:myweb/screen/component/item_contact.dart';
import 'package:myweb/screen/component/section.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';

Uri _emailUri(String address) =>
    Uri(scheme: "mailto", path: address, query: "subject=${Uri.encodeComponent("Let's work together")}");

final _designReference = Uri.parse("https://dribbble.com/shots/26851273-Graphics-Designer-Portfolio-Design");

List<ContactModel> _socials(AboutModel about) => [
      ContactModel(title: "GitHub", iconLink: "assets/images/ic_github.svg", link: about.github),
      ContactModel(title: "LinkedIn", iconLink: "assets/images/ic_linkedin.svg", link: about.linkedin),
      ContactModel(title: "WhatsApp", iconLink: "assets/images/ic_wa.svg", link: about.whatsapp),
      ContactModel(title: "Telegram", iconLink: "assets/images/ic_tele.svg", link: about.telegram),
      ContactModel(title: "Instagram", iconLink: "assets/images/ic_ig.svg", link: about.instagram),
    ];

class ContactSection extends ConsumerWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDesktop = ResponsiveBreakpoints.of(context).isDesktop;
    final about = ref.watch(aboutProvider).valueOrNull ?? AboutModel.fallback;

    final pitch = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("CONTACT INFO", style: displayStyle(context, desktop: 60, mobile: 36)),
        const Gap(24),
        const Text("Interested in working together or just want to say hi?",
            style: TextStyle(fontFamily: bodyFont, fontSize: 19, fontWeight: FontWeight.w600, color: Palette.heading)),
        const Gap(6),
        const Text(
            "I'm open to remote roles in Indonesia and abroad, and to hybrid or onsite roles in Indonesia. "
            "Email is the fastest way to reach me.",
            style: TextStyle(fontFamily: bodyFont, fontSize: 16, height: 1.6, fontWeight: FontWeight.w500, color: Palette.body)),
        const Gap(36),
        PillButton(label: "Contact Me Now", onPressed: () => launchUrl(_emailUri(about.email))),
      ],
    );

    return Section(
      panel: true,
      floating: const [
        Positioned(left: 36, top: 120, child: FloatingBadge(asset: "assets/images/ic_kotlin.webp", size: 46, dim: true, turns: -0.06)),
      ],
      child: isDesktop
          ? Row(children: [
              Expanded(flex: 6, child: pitch),
              const Expanded(flex: 5, child: _ContactPortrait(size: 340)),
            ])
          : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              pitch,
              const Gap(32),
              const Center(child: _ContactPortrait(size: 260)),
            ]),
    );
  }
}

class _ContactPortrait extends StatelessWidget {
  final double size;
  const _ContactPortrait({required this.size});

  @override
  Widget build(BuildContext context) {
    final badge = size * 0.16;
    return SizedBox.square(
      dimension: size,
      child: Stack(clipBehavior: Clip.none, alignment: Alignment.center, children: [
        Glow(size: size * 1.3),
        Container(
          width: size * 0.7,
          height: size * 0.7,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 6),
            boxShadow: [BoxShadow(color: Palette.heading.withValues(alpha: 0.2), blurRadius: 36, offset: const Offset(0, 18))],
          ),
          child: ClipOval(
              child: Image.asset("assets/images/avatar_contact.webp",
                  fit: BoxFit.cover,
                  alignment: const Alignment(-0.1, -0.3),
                  semanticLabel: "Suhaili Faruq holding a phone with a mobile app")),
        ),
        Align(
            alignment: const Alignment(-0.6, -1.0),
            child: FloatingBadge(asset: "assets/images/ic_flutter.webp", size: badge, turns: 0.03)),
        Align(
            alignment: const Alignment(1.0, -0.75),
            child: FloatingBadge(asset: "assets/images/ic_react_native.webp", size: badge, turns: 0.06)),
      ]),
    );
  }
}

class FooterSection extends ConsumerWidget {
  final Map<String, VoidCallback> links;
  const FooterSection({super.key, required this.links});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDesktop = ResponsiveBreakpoints.of(context).isDesktop;
    final about = ref.watch(aboutProvider).valueOrNull ?? AboutModel.fallback;
    const heading = TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Palette.heading);
    const item = TextStyle(fontFamily: bodyFont, fontSize: 15, height: 1.9, fontWeight: FontWeight.w500, color: Palette.body);

    final brand = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Image.asset("assets/images/logo.webp", height: 56, semanticLabel: "Suhaili Faruq"),
      const Gap(16),
      const Text("\"Offline-first apps, online-first attitude. Mobile engineer from Kotawaringin Barat.\"",
          style: TextStyle(fontFamily: bodyFont, fontSize: 15, height: 1.6, fontWeight: FontWeight.w500, color: Palette.body)),
      const Gap(20),
      _EmailPill(email: about.email),
      const Gap(16),
      Wrap(children: [
        for (final social in _socials(about))
          Tooltip(
            message: social.title,
            child: ItemContact(
                title: social.title, pathImage: social.iconLink, callback: () => launchUrl(Uri.parse(social.link))),
          ),
      ]),
    ]);

    final address = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text("Address", style: heading),
      const Gap(14),
      Text(about.phone, style: item),
      Text(about.email, style: item),
      Text(about.location, style: item),
    ]);

    final pages = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text("Links", style: heading),
      const Gap(10),
      for (final link in links.entries)
        InkWell(onTap: link.value, child: Text(link.key, style: item)),
    ]);

    return Section(
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        if (isDesktop)
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Gap(56),
            Expanded(flex: 4, child: brand),
            const Gap(64),
            Expanded(flex: 3, child: Padding(padding: const EdgeInsets.only(top: 20), child: address)),
            const Gap(32),
            Expanded(flex: 2, child: pages),
          ])
        else ...[
          brand,
          const Gap(36),
          address,
          const Gap(36),
          pages,
        ],
        const Gap(56),
        const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("MADE WITH ", style: TextStyle(fontFamily: bodyFont, fontSize: 14, fontWeight: FontWeight.w600, color: Palette.body)),
          Icon(Icons.favorite, size: 16, color: Color(0xFFF44336)),
          Text(" BY SUHAILI FARUQ",
              style: TextStyle(fontFamily: bodyFont, fontSize: 14, fontWeight: FontWeight.w600, color: Palette.body)),
        ]),
        const Gap(10),
        Center(
          child: InkWell(
            onTap: () => launchUrl(_designReference),
            borderRadius: BorderRadius.circular(8),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text.rich(
                TextSpan(text: "Design reference by ", children: [
                  TextSpan(
                      text: "Dharmu Bhusal on Dribbble",
                      style: TextStyle(color: Palette.primary, decoration: TextDecoration.underline)),
                ]),
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: bodyFont, fontSize: 13, fontWeight: FontWeight.w600, color: Palette.body),
              ),
            ),
          ),
        ),
        const Gap(10),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text("Built with ",
              style: TextStyle(fontFamily: bodyFont, fontSize: 13, fontWeight: FontWeight.w600, color: Palette.body)),
          Image.asset("assets/images/ic_flutter.webp", width: 16, height: 16, semanticLabel: "Flutter"),
          const Text(" Flutter",
              style: TextStyle(fontFamily: bodyFont, fontSize: 13, fontWeight: FontWeight.w600, color: Palette.body)),
        ]),
      ]),
    );
  }
}

/// The reference's newsletter field, repurposed: shows the address and opens an email.
class _EmailPill extends StatelessWidget {
  final String email;
  const _EmailPill({required this.email});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 360),
      padding: const EdgeInsets.fromLTRB(22, 4, 4, 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
        boxShadow: [BoxShadow(color: Palette.heading.withValues(alpha: 0.08), blurRadius: 24, offset: const Offset(0, 8))],
      ),
      child: Row(children: [
        Expanded(
          child: Text(email,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontFamily: bodyFont, fontSize: 14, fontWeight: FontWeight.w600, color: Palette.body)),
        ),
        PillButton(label: "Email Me", onPressed: () => launchUrl(_emailUri(email))),
      ]),
    );
  }
}
