import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text.rich(
                  TextSpan(
                      text: "Mobile an",
                      style: const TextStyle(
                          fontSize: 40, color: Colors.blue, fontWeight: FontWeight.w700),
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
                  style: TextStyle(fontSize: 16, color: Colors.blueAccent.shade700),
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
          Gap(MediaQuery.of(context).size.height * 0.15),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade900,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
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
                      style:
                          TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const Gap(28),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: const Text(
                      "I am a computer science graduate and I work for a software company in Semarang City. I have over two years of experience working on various mobile and web application projects using modern frameworks. Additionally, I am interested in exploring other fields such as backend development and machine learning. I enjoy collaborating with my team, have a strong desire to learn, and am able to fulfill my obligations even under pressure.",
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
                  Gap(16),
                ]),
          )
        ],
      ),
    );
  }
}
