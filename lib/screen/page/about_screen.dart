import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:myweb/helper/util.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

class AboutScreen extends ConsumerStatefulWidget {
  const AboutScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AboutScreenState();
}

class _AboutScreenState extends ConsumerState<AboutScreen> {
  ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<int> listing = [1, 2, 3, 4, 5, 6, 7, 8];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Util().autoSizing(
        context,
        stat: 1,
      ),
      // height: Util().autoSizing(
      //   context,
      //   stat: 2,
      // ),
      child: ListView(
        controller: _controller,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(left: 28, right: 28),
        children: [
          const Gap(24),
          Container(
            constraints: BoxConstraints.expand(
                width: Util().autoSizing(context, stat: 1),
                height: Util().autoSizing(context, stat: 2, percent: 0.75)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text.rich(
                  TextSpan(
                      text: "Mobile an",
                      style: const TextStyle(
                          fontSize: 40,
                          color: Colors.blue,
                          fontWeight: FontWeight.w700),
                      children: [
                        TextSpan(
                            text: "d Web Developer",
                            style: TextStyle(
                                fontSize: 40,
                                color: Colors.blue.shade100,
                                fontWeight: FontWeight.w600))
                      ]),
                  textAlign: TextAlign.center,
                ),
                const Gap(8),
                Text(
                  "I develop mobile and web application with modern framework for your business.",
                  style: TextStyle(
                      fontSize: 16, color: Colors.blueAccent.shade700),
                  textAlign: TextAlign.center,
                ),
                Gap(MediaQuery.of(context).size.height * 0.10),
                Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: ClipOval(
                    child: Image.asset(
                      "assets/images/image_photo.jpg",
                      fit: BoxFit.fill,
                    ),
                  ),
                )
              ],
            ),
          ),
          const Gap(36),
          Container(
            width: Util().autoSizing(context, stat: 1, percent: 0.8),
            padding: const EdgeInsets.all(36),
            decoration: BoxDecoration(
              color: Colors.blue.shade900,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Gap(16),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Hi i'm Faruq welcome to my website portfolio.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  const Gap(28),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      "I have more than two years of experience working on various mobile and web application projects using modern frameworks such as Flutter, react JS, react-native also Android native Kotlin. In addition, I am also interested in exploring other fields such as backend development and machine learning such as nodeJS, fastApi, and Django for backend and TensorFlow for machine learning using MySQL as a database. I enjoy collaborating with my team, have a strong desire to learn, and can fulfill my obligations even under pressure, I also looking for a job hybrid, remote, or freelance especially in mobile apps and web apps projects.",
                      textScaler: ResponsiveBreakpoints.of(context).isMobile ||
                              ResponsiveBreakpoints.of(context).isTablet
                          ? const TextScaler.linear(0.75)
                          : const TextScaler.linear(1),
                      style: const TextStyle(
                        fontSize: 16,
                        height: 2,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Gap(16),
                ]),
          ),
          const Gap(36),
          Container(
            height: 80,
            width: 80,
            decoration:
                const BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
            child: Center(
              child: SvgPicture.asset(
                "assets/images/ic_code.svg",
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
              "Main Skills",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
          ),
          const Gap(8),
          const Align(
              alignment: Alignment.center,
              child: Text(
                "From scratch, i code and build something then ensure run to mobile and browser",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
                textAlign: TextAlign.left,
              )),
          const Gap(16),
          Container(
              width: Util().autoSizing(context, stat: 1),
              height: 1,
              color: Colors.blue.shade600),
          const Gap(24),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "I Like Code with Languange:",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
          ),
          const Gap(16),
          Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                runSpacing: 20,
                spacing: 10,
                children: [
                  SizedBox(
                    width: 220,
                    height: 50,
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/ic_dart.png",
                          width: 20,
                          height: 20,
                        ),
                        const Gap(30),
                        const Text(
                          "Dart Languange",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 220,
                    height: 50,
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/ic_js.png",
                          width: 20,
                          height: 20,
                        ),
                        Image.asset(
                          "assets/images/ic_typescript.png",
                          width: 20,
                          height: 20,
                        ),
                        const Gap(8),
                        const SizedBox(
                            width: 160,
                            child: Text(
                              "Javascript/Typescript Languange",
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 220,
                    height: 50,
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/ic_kotlin.png",
                          width: 20,
                          height: 20,
                        ),
                        const Gap(30),
                        const Text(
                          "Kotlin Languange",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 220,
                    height: 50,
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/ic_java.png",
                          width: 20,
                          height: 20,
                        ),
                        const Gap(30),
                        const Text(
                          "Java Languange",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        )
                      ],
                    ),
                  ),
                ],
              )),
          const Gap(24),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "And using modern framework like:",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
          ),
          const Gap(16),
          Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                runSpacing: 20,
                spacing: 10,
                children: [
                  SizedBox(
                    width: 220,
                    height: 50,
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/ic_flutter.png",
                          width: 20,
                          height: 20,
                        ),
                        const Gap(30),
                        const Text(
                          "Flutter",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 220,
                    height: 50,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/images/ic_android.png",
                          width: 20,
                          height: 20,
                        ),
                        const Gap(30),
                        const SizedBox(
                            width: 150,
                            child: Text(
                              "Android Jetpack Compose",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 220,
                    height: 50,
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/ic_react_native.png",
                          width: 20,
                          height: 20,
                        ),
                        const Gap(30),
                        const Text(
                          "React-Native",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 220,
                    height: 50,
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/ic_react_js.png",
                          width: 20,
                          height: 20,
                        ),
                        const Gap(30),
                        const Text(
                          "React JS",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 220,
                    height: 50,
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/ic_node.png",
                          width: 20,
                          height: 20,
                        ),
                        const Gap(30),
                        const Text(
                          "Node JS",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 220,
                    height: 50,
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/ic_mysql.png",
                          width: 20,
                          height: 20,
                        ),
                        const Gap(30),
                        const Text(
                          "MySql",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        )
                      ],
                    ),
                  ),
                ],
              )),
          const Gap(24),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Then for support what i do, usually using:",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
          ),
          const Gap(16),
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: Util().autoSizing(context, stat: 1),
              child: Wrap(
                runSpacing: 20,
                spacing: 10,
                children: [
                  SizedBox(
                    width: 220,
                    height: 50,
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/ic_vscode.png",
                          width: 20,
                          height: 20,
                        ),
                        const Gap(30),
                        const Text(
                          "VScode",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 220,
                    height: 50,
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/ic_studio.png",
                          width: 20,
                          height: 20,
                        ),
                        const Gap(30),
                        const Text(
                          "Android Studio",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 220,
                    height: 50,
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/ic_git.png",
                          width: 20,
                          height: 20,
                        ),
                        const Gap(30),
                        const Text(
                          "Git",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 220,
                    height: 50,
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/ic_figma.png",
                          width: 20,
                          height: 20,
                        ),
                        const Gap(30),
                        const Text(
                          "Figma",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 220,
                    height: 50,
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/ic_postman.png",
                          width: 20,
                          height: 20,
                        ),
                        const Gap(30),
                        const Text(
                          "Postman",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Gap(28),
        ],
      ),
    );
  }
}
