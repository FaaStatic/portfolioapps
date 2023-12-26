import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:myweb/helper/util.dart';
import 'package:myweb/model/contact_model.dart';
import 'package:myweb/provider/provider_project.dart';
import 'package:myweb/screen/component/item_contact.dart';
import 'package:myweb/screen/component/item_project.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectScreen extends ConsumerStatefulWidget {
  const ProjectScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends ConsumerState<ProjectScreen> {
  final List<ContactModel> listing = [
    const ContactModel(
        title: "Github",
        iconLink: "assets/images/ic_github.svg",
        link: "https://github.com/FaaStatic"),
    const ContactModel(
        title: "Linkedin",
        iconLink: "assets/images/ic_linkedin.svg",
        link: "https://www.linkedin.com/in/suhaili-faruq-8475a0189/"),
    const ContactModel(
        title: "email",
        iconLink: "assets/images/ic_gmail.svg",
        link:
            "mailto:suhaili.faruq01@gmail.com?subject=Invitation Collaborate&body=Hi Faruq, i want to collaborate with you about ..."),
    const ContactModel(
        title: "Whatsapp",
        iconLink: "assets/images/ic_wa.svg",
        link: "https://wa.me/085713561437/?text=I want collaborate with you ..."),
    const ContactModel(
        title: "Telegram",
        iconLink: "assets/images/ic_tele.svg",
        link: "https://t.me/suhailifaruq"),
    const ContactModel(
        title: "Instagram",
        iconLink: "assets/images/ic_ig.svg",
        link: "https://www.instagram.com/suhailifaruq_/"),
  ];

  ScrollController _controller = ScrollController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(providerProjectGet.notifier).getAllData();
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
      width: Util().autoSizing(
        context,
        stat: 1,
      ),
      child: ListView(
        controller: _controller,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
        children: [
          const Gap(24),
          Container(
            height: 80,
            width: 80,
            decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
            child: Center(
              child: SvgPicture.asset(
                "assets/images/ic_project.svg",
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
              "Recent Work",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
            ),
          ),
          const Gap(8),
          const Align(
              alignment: Alignment.center,
              child: Text(
                "Here are the list project while i working on programming job: ",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),
                textAlign: TextAlign.left,
              )),
          const Gap(16),
          Padding(
              padding: const EdgeInsets.only(left: 28, right: 28),
              child: Container(
                  width: Util().autoSizing(context, stat: 1),
                  height: 1,
                  color: Colors.blue.shade600)),
          const Gap(24),
          Consumer(builder: (context, ref, _) {
            var response = ref.watch(providerProjectGet);

            if (response.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(left: 28, right: 28),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 25,
                  runSpacing: 25,
                  children: [
                    ...response.map((item) => ItemProject(
                          model: item,
                          callBack: (value) {},
                        )),
                  ],
                ),
              );
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
          Container(
            width: widthScreen,
            height: 300,
            color: Colors.blue.shade600,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "want collaborate together, contact me at:",
                  style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w600),
                ),
                const Gap(16),
                Wrap(
                  runSpacing: 20,
                  spacing: 10,
                  children: [
                    ...listing.map((item) => ItemContact(
                        title: item.title,
                        pathImage: item.iconLink,
                        callback: () async {
                          if (item.title == "email") {
                            final Uri emailLaunchUri = Uri(
                              scheme: 'mailto',
                              path: 'suhaili.faruq01@gmail.com',
                              queryParameters: {
                                'subject': 'Invitation ...',
                                'body': "Hi Faruq ..."
                              },
                            );
                            await launchUrl(emailLaunchUri, mode: LaunchMode.platformDefault);
                          } else {
                            await launchUrl(Uri.parse(item.link), mode: LaunchMode.platformDefault);
                          }
                        }))
                  ],
                ),
                const Gap(24),
                const Text(
                  "Handcraft by me@suhailifaruq_",
                  style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600),
                ),
                const Gap(8),
                SizedBox(
                  width: widthScreen * 0.25,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/ic_flutter.png",
                        width: 12,
                        height: 12,
                      ),
                      const Gap(16),
                      const Text(
                        "build by Flutter",
                        style: TextStyle(
                            fontSize: 12, color: Colors.white, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
