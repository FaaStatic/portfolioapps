import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:myweb/helper/util.dart';
import 'package:responsive_framework/responsive_framework.dart';

class AboutScreen extends ConsumerStatefulWidget {
  const AboutScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AboutScreenState();
}

class _AboutScreenState extends ConsumerState<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
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
                Gap(MediaQuery.of(context).size.height * 0.15),
                Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: ClipOval(
                    child: Image.network(
                      "https://images.unsplash.com/photo-1604675223954-b1aabd668078?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                      fit: BoxFit.fill,
                    ),
                  ),
                )
              ],
            ),
          ),
          Gap(Util().autoSizing(context, stat: 2, percent: 0.1)),
          Container(
            constraints: BoxConstraints.expand(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height),
            padding: const EdgeInsets.all(16),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                    left: 16,
                    top: 0,
                    right: 16,
                    child: Container(
                      width: Util().autoSizing(context, stat: 1),
                      height: Util().autoSizing(context, stat: 2, percent: 0.4),
                      padding: const EdgeInsets.only(left: 28, right: 28),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade900,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
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
                              child: const Text(
                                "I am a computer science graduate and I work at a software company in Semarang City. As a developer, I have more than two years of experience working on various mobile and web application projects using modern frameworks. In addition, I am also interested in exploring other fields such as backend development and machine learning. I enjoy collaborating with my team, have a strong desire to learn, and am able to fulfill my obligations even under pressure.",
                                textScaler: TextScaler.linear(1),
                                style: TextStyle(
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
                    )),
                Positioned(
                    left: 40,
                    right: 40,
                    top: Util().autoSizing(context, stat: 2, percent: 0.35),
                    child: Container(
                        constraints: BoxConstraints.expand(
                            width: Util().autoSizing(context, stat: 1),
                            height: Util().autoSizing(context, stat: 2)),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: Colors.blue.shade500),
                        child: Builder(builder: (context) {
                          if (ResponsiveBreakpoints.of(context).isMobile ||
                              ResponsiveBreakpoints.of(context).isTablet) {
                            return Column(
                              children: [Text("test")],
                            );
                          } else {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: Container(
                                    width: Util().autoSizing(context, stat: 1),
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          "assets/images/ic_code.svg",
                                          width: 40,
                                          height: 40,
                                          color: Colors.grey.shade400,
                                        ),
                                        const Gap(4),
                                        const Text(
                                          "Main Skills",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                        ),
                                        const Gap(24),
                                        const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Programming Languange:",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white),
                                          ),
                                        ),
                                        const Gap(16),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: ListView(
                                            shrinkWrap: true,
                                            children: [
                                              SizedBox(
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
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              const Gap(8),
                                              SizedBox(
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
                                                    const Text(
                                                      "Javascript/Typescript Languange",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              const Gap(8),
                                              SizedBox(
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
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              const Gap(8),
                                              SizedBox(
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
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              const Gap(8),
                                              SizedBox(
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      "assets/images/ic_phyton.png",
                                                      width: 20,
                                                      height: 20,
                                                    ),
                                                    const Gap(30),
                                                    const Text(
                                                      "Phyton Languange",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Gap(24),
                                        const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Framework:",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white),
                                          ),
                                        ),
                                        const Gap(16),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: ListView(
                                            shrinkWrap: true,
                                            children: [
                                              SizedBox(
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
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              const Gap(8),
                                              SizedBox(
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      "assets/images/ic_android.png",
                                                      width: 20,
                                                      height: 20,
                                                    ),
                                                    const Gap(30),
                                                    const Text(
                                                      "Android Jetpack Compose",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              const Gap(8),
                                              SizedBox(
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      "assets/images/ic_react_native.png",
                                                      width: 20,
                                                      height: 20,
                                                    ),
                                                    const Gap(30),
                                                    const Text(
                                                      "React-native",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              const Gap(8),
                                              SizedBox(
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
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              const Gap(8),
                                              SizedBox(
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
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              const Gap(8),
                                              SizedBox(
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      "assets/images/ic_django.png",
                                                      width: 20,
                                                      height: 20,
                                                    ),
                                                    const Gap(30),
                                                    const Text(
                                                      "Django",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Gap(24),
                                        const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Tools:",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white),
                                          ),
                                        ),
                                        const Gap(16),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Wrap(
                                            children: [
                                              SizedBox(
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
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              const Gap(8),
                                              SizedBox(
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
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              const Gap(8),
                                              SizedBox(
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
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              const Gap(8),
                                              SizedBox(
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
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              const Gap(8),
                                              SizedBox(
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
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 1,
                                  height: double.infinity,
                                  color: Colors.white,
                                ),
                                Expanded(
                                  child: Container(
                                    width: Util().autoSizing(context, stat: 1),
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          "assets/images/ic_certification.svg",
                                          width: 40,
                                          height: 40,
                                          color: Colors.red.shade400,
                                        ),
                                        const Gap(4),
                                        const Text(
                                          "Certification",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        })))
              ],
            ),
          )
        ],
      ),
    );
  }
}
