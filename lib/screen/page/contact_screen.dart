import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:myweb/helper/palette.dart';
import 'package:myweb/model/contact_model.dart';
import 'package:myweb/screen/component/item_contact.dart';
import 'package:myweb/screen/component/section.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';

const _emailAddress = "suhaili.faruq01@gmail.com";
final _email = Uri(scheme: "mailto", path: _emailAddress, query: "subject=${Uri.encodeComponent("Let's work together")}");

final _designReference = Uri.parse("https://dribbble.com/shots/26851273-Graphics-Designer-Portfolio-Design");

const _socials = [
  ContactModel(title: "GitHub", iconLink: "assets/images/ic_github.svg", link: "https://github.com/FaaStatic"),
  ContactModel(
      title: "LinkedIn",
      iconLink: "assets/images/ic_linkedin.svg",
      link: "https://www.linkedin.com/in/suhaili-faruq-8475a0189/"),
  ContactModel(title: "WhatsApp", iconLink: "assets/images/ic_wa.svg", link: "https://wa.me/6285713561437"),
  ContactModel(title: "Telegram", iconLink: "assets/images/ic_tele.svg", link: "https://t.me/suhailifaruq"),
  ContactModel(
      title: "Instagram", iconLink: "assets/images/ic_ig.svg", link: "https://www.instagram.com/suhailifaruq_/"),
];

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveBreakpoints.of(context).isDesktop;

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
        PillButton(label: "Contact Me Now", onPressed: () => launchUrl(_email)),
      ],
    );

    return Section(
      panel: true,
      floating: const [
        Positioned(left: 36, top: 120, child: FloatingBadge(asset: "assets/images/ic_kotlin.png", size: 46, blur: 1.5, turns: -0.06)),
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
              child: Image.asset("assets/images/avatar_contact.jpg",
                  fit: BoxFit.cover,
                  alignment: const Alignment(-0.1, -0.3),
                  semanticLabel: "Suhaili Faruq holding a phone with a mobile app")),
        ),
        Align(
            alignment: const Alignment(-0.6, -1.0),
            child: FloatingBadge(asset: "assets/images/ic_flutter.png", size: badge, turns: 0.03)),
        Align(
            alignment: const Alignment(1.0, -0.75),
            child: FloatingBadge(asset: "assets/images/ic_react_native.png", size: badge, turns: 0.06, reverse: true)),
      ]),
    );
  }
}

class FooterSection extends StatelessWidget {
  final Map<String, VoidCallback> links;
  const FooterSection({super.key, required this.links});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveBreakpoints.of(context).isDesktop;
    const heading = TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Palette.heading);
    const item = TextStyle(fontFamily: bodyFont, fontSize: 15, height: 1.9, fontWeight: FontWeight.w500, color: Palette.body);

    final brand = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Image.asset("assets/images/logo.png", height: 56, semanticLabel: "Suhaili Faruq"),
      const Gap(16),
      const Text("\"Offline-first apps, online-first attitude. Mobile engineer from Kotawaringin Barat.\"",
          style: TextStyle(fontFamily: bodyFont, fontSize: 15, height: 1.6, fontWeight: FontWeight.w500, color: Palette.body)),
      const Gap(20),
      _EmailPill(),
      const Gap(16),
      Wrap(children: [
        for (final social in _socials)
          Tooltip(
            message: social.title,
            child: ItemContact(
                title: social.title, pathImage: social.iconLink, callback: () => launchUrl(Uri.parse(social.link))),
          ),
      ]),
    ]);

    const address = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Address", style: heading),
      Gap(14),
      Text("+62 857-1356-1437", style: item),
      Text(_emailAddress, style: item),
      Text("Kotawaringin Barat, Indonesia", style: item),
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
            const Expanded(flex: 3, child: Padding(padding: EdgeInsets.only(top: 20), child: address)),
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
          Image.asset("assets/images/ic_flutter.png", width: 16, height: 16, semanticLabel: "Flutter"),
          const Text(" Flutter",
              style: TextStyle(fontFamily: bodyFont, fontSize: 13, fontWeight: FontWeight.w600, color: Palette.body)),
        ]),
      ]),
    );
  }
}

/// The reference's newsletter field, repurposed: shows the address and opens an email.
class _EmailPill extends StatelessWidget {
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
        const Expanded(
          child: Text(_emailAddress,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontFamily: bodyFont, fontSize: 14, fontWeight: FontWeight.w600, color: Palette.body)),
        ),
        PillButton(label: "Email Me", onPressed: () => launchUrl(_email)),
      ]),
    );
  }
}
