import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:myweb/helper/util.dart';
import 'package:myweb/model/project_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemProject extends ConsumerStatefulWidget {
  final ProjectModel model;
  final void Function(ProjectModel model) callBack;

  const ItemProject({
    super.key,
    required this.model,
    required this.callBack,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ItemProjectState();
}

class _ItemProjectState extends ConsumerState<ItemProject> with TickerProviderStateMixin {
  late AnimationController _control;
  late Animation<double> blurShadow;
  late Animation<double> showButton;
  bool showDetail = false;

  @override
  void initState() {
    _control = AnimationController(
      duration: const Duration(milliseconds: 10),
      vsync: this,
    );
    blurShadow = Tween<double>(begin: 10, end: 20)
        .animate(CurvedAnimation(parent: _control, curve: Curves.easeIn));

    showButton =
        Tween<double>(begin: 0, end: WidgetsBinding.instance.window.physicalSize.height * 0.6)
            .animate(CurvedAnimation(parent: _control, curve: Curves.easeIn));

    super.initState();
  }

  @override
  void dispose() {
    _control.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _control,
        builder: (context, _) {
          return MouseRegion(
            onHover: (event) {
              setState(() {
                showDetail = true;
              });
              _control.forward();
            },
            onExit: (event) {
              setState(() {
                showDetail = false;
              });
              _control.reset();
            },
            onEnter: (event) {
              setState(() {
                showDetail = true;
              });
              _control.forward();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              constraints: BoxConstraints.expand(
                  width: Util().autoSizing(context, stat: 1, percent: 0.45),
                  height: Util().autoSizing(context, stat: 2, percent: 0.75)),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.15), spreadRadius: 5, blurRadius: 20)
                  ]),
              child: Stack(
                children: [
                  Positioned.fill(
                      child: Container(
                    constraints: BoxConstraints.expand(
                        width: Util().autoSizing(context, stat: 1, percent: 0.45),
                        height: Util().autoSizing(context, stat: 2, percent: 0.75)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                          child: widget.model.pathImage != null
                              ? Image.network(
                                  widget.model.pathImage!,
                                  width: Util().autoSizing(context, stat: 1, percent: 0.45),
                                  height: Util().autoSizing(context, stat: 2, percent: 0.3),
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  "https://images.unsplash.com/photo-1519389950473-47ba0277781c?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3Dhttps://images.unsplash.com/photo-1519389950473-47ba0277781c?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3Dhttps://images.unsplash.com/photo-1519389950473-47ba0277781c?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                                  width: Util().autoSizing(context, stat: 1, percent: 0.45),
                                  height: Util().autoSizing(context, stat: 2, percent: 0.3),
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 16, bottom: 8, right: 16),
                          child: Text(
                            widget.model.projectName ?? "",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const Gap(16),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16, bottom: 8, right: 16),
                            child: Wrap(
                              spacing: 20,
                              runSpacing: 20,
                              children: [
                                RichText(
                                    text: TextSpan(
                                        text: "Project type: ",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                        children: [
                                      TextSpan(
                                          text: widget.model.typeProject,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ))
                                    ])),
                                RichText(
                                    text: TextSpan(
                                        text: "Project by: ",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                        children: [
                                      TextSpan(
                                          text: widget.model.projectBy,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ))
                                    ])),
                                RichText(
                                    text: TextSpan(
                                        text: "Build by: ",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                        children: [
                                      TextSpan(
                                          text: widget.model.frameworkUsing ?? "",
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ))
                                    ]))
                              ],
                            ),
                          ),
                        ),
                        const Gap(16),
                        const Flexible(
                            child: Padding(
                          padding: EdgeInsets.only(left: 16, bottom: 8, right: 16),
                          child: Text(
                            "Description:",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        )),
                        Flexible(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 16, bottom: 8, right: 16),
                          child: Text(
                            widget.model.descriptionProject ?? "",
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ))
                      ],
                    ),
                  )),
                  Builder(builder: (context) {
                    if (showDetail) {
                      return Positioned.fill(
                          child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                          child: AnimatedContainer(
                            width: Util().autoSizing(context, stat: 1, percent: 0.45),
                            height: showButton.value,
                            duration: const Duration(milliseconds: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if (widget.model.githubLink != null)
                                  ElevatedButton(
                                      onPressed: () async {
                                        await launchUrl(Uri.parse(widget.model.githubLink!));
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.black,
                                          fixedSize: const Size(200, 52),
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(10)))),
                                      child: ListTile(
                                        leading: SvgPicture.asset(
                                          "assets/images/ic_github.svg",
                                          width: 24,
                                          height: 24,
                                          color: Colors.white,
                                        ),
                                        title: const Text(
                                          "Github Repo",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                        ),
                                      )),
                                if (widget.model.playStoreLink != null)
                                  ElevatedButton(
                                      onPressed: () async {
                                        await launchUrl(Uri.parse(widget.model.playStoreLink!));
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red.shade500,
                                          fixedSize: const Size(200, 52),
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(10)))),
                                      child: ListTile(
                                        leading: SvgPicture.asset(
                                          "assets/images/ic_google_play.svg",
                                          width: 24,
                                          height: 24,
                                          color: Colors.white,
                                        ),
                                        title: const Text(
                                          "Play Store",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                        ),
                                      )),
                                if (widget.model.appStoreLink != null)
                                  ElevatedButton(
                                      onPressed: () async {
                                        await launchUrl(Uri.parse(widget.model.appStoreLink!));
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue.shade400,
                                          fixedSize: const Size(200, 52),
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(10)))),
                                      child: ListTile(
                                        leading: SvgPicture.asset(
                                          "assets/images/ic_app_store.svg",
                                          width: 24,
                                          height: 24,
                                          color: Colors.white,
                                        ),
                                        title: const Text(
                                          "App Store",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                        ),
                                      )),
                                if (widget.model.webLink != null)
                                  ElevatedButton(
                                      onPressed: () async {
                                        await launchUrl(Uri.parse(widget.model.webLink!));
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.amber.shade400,
                                          fixedSize: const Size(200, 52),
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(10)))),
                                      child: ListTile(
                                        leading: SvgPicture.asset(
                                          "assets/images/ic_web.svg",
                                          width: 24,
                                          height: 24,
                                          color: Colors.white,
                                        ),
                                        title: const Text(
                                          "Website",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                        ),
                                      )),
                              ],
                            ),
                          ),
                        ),
                      ));
                    } else {
                      return const Positioned(left: 0, bottom: 0, child: SizedBox());
                    }
                  })
                ],
              ),
            ),
          );
        });
  }
}
