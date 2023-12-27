import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:myweb/provider/provider_download.dart';
import 'package:myweb/provider/provider_tab.dart';

import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';

class HeadBar extends ConsumerStatefulWidget {
  final void Function() aboutCallBack;
  final void Function() experienceCallBack;
  final void Function() projectCallBack;
  final void Function() resumeCallBack;
  final void Function() refreshCallBack;
  final void Function(bool status) isExpanded;
  const HeadBar(
      {super.key,
      required this.refreshCallBack,
      required this.aboutCallBack,
      required this.experienceCallBack,
      required this.resumeCallBack,
      required this.isExpanded,
      required this.projectCallBack});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HeadBarState();
}

class _HeadBarState extends ConsumerState<HeadBar>
    with TickerProviderStateMixin {
  late AnimationController _control;

  bool isHover = false;
  bool isHoverProject = false;
  bool isHoverExperience = false;
  bool isHoverResume = false;
  bool isHoverAbout = false;
  bool openBottom = false;
  late Animation<double> lengthIndicator;

  @override
  void initState() {
    _control = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    lengthIndicator = Tween<double>(
            begin: 0,
            end: WidgetsBinding.instance.window.physicalSize.height * 0.15)
        .animate(CurvedAnimation(parent: _control, curve: Curves.easeIn));
    _control.forward();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(providerDownloadData.notifier).downloadData();
    });
    super.initState();
  }

  @override
  void dispose() {
    _control.dispose();
    super.dispose();
  }

  void downloadProcess() async {
    var dataUrl = await ref.watch(providerDownloadData);
    await launchUrl(Uri.parse(dataUrl));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 1000),
        width: MediaQuery.of(context).size.width,
        color: Colors.transparent,
        constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.10,
            maxHeight: MediaQuery.of(context).size.height * 0.35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.10,
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: widget.refreshCallBack,
                    child: Text(
                      "Suhaili Faruq",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.blue.shade400,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Builder(builder: (context) {
                    if (ResponsiveBreakpoints.of(context).isMobile ||
                        ResponsiveBreakpoints.of(context).isTablet) {
                      return MouseRegion(
                        onHover: (value) {
                          setState(() {
                            isHover = true;
                          });
                        },
                        onExit: (event) {
                          setState(() {
                            isHover = false;
                          });
                        },
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              openBottom = !openBottom;
                            });
                            widget.isExpanded(openBottom);
                          },
                          child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 35,
                              height: 35,
                              child: Builder(builder: (context) {
                                if (openBottom) {
                                  return Icon(
                                    Icons.close,
                                    color: isHover
                                        ? Colors.blue
                                        : Colors.blue.shade300,
                                    size: 35,
                                  );
                                } else {
                                  return SvgPicture.asset(
                                    "assets/images/ic_menu.svg",
                                    width: 24,
                                    height: 24,
                                    color: isHover
                                        ? Colors.blue
                                        : Colors.blue.shade300,
                                  );
                                }
                              })),
                        ),
                      );
                    } else {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.55,
                        height: MediaQuery.of(context).size.height * 0.10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            MouseRegion(
                              onHover: (value) {
                                setState(() {
                                  isHoverAbout = true;
                                });
                              },
                              onExit: (event) {
                                setState(() {
                                  isHoverAbout = false;
                                });
                              },
                              child: InkWell(
                                onTap: () {
                                  _control.reset();
                                  _control.forward();
                                  widget.aboutCallBack();
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "About",
                                        style: TextStyle(
                                            color: isHoverAbout
                                                ? Colors.blue.shade800
                                                : ref.watch(providerChangeTab) ==
                                                        0
                                                    ? Colors.blue
                                                    : Colors.blue.shade300,
                                            fontWeight: isHoverAbout
                                                ? FontWeight.w700
                                                : FontWeight.w400,
                                            fontSize: 16),
                                      ),
                                      const Gap(8),
                                      Consumer(builder: (context, ref, _) {
                                        if (ref.watch(providerChangeTab) == 0) {
                                          return AnimatedBuilder(
                                              animation: _control,
                                              builder: (context, _) {
                                                return SizeTransition(
                                                  axis: Axis.horizontal,
                                                  axisAlignment: -1,
                                                  sizeFactor: _control,
                                                  child: Container(
                                                    height: 2,
                                                    width:
                                                        lengthIndicator.value,
                                                    decoration: const BoxDecoration(
                                                        color: Colors.blue,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                                  ),
                                                );
                                              });
                                        } else {
                                          return const Gap(0);
                                        }
                                      }),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            MouseRegion(
                              onHover: (value) {
                                setState(() {
                                  isHoverExperience = true;
                                });
                              },
                              onExit: (event) {
                                setState(() {
                                  isHoverExperience = false;
                                });
                              },
                              child: InkWell(
                                onTap: () {
                                  _control.reset();
                                  _control.forward();
                                  widget.experienceCallBack();
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Experience",
                                        style: TextStyle(
                                            color: isHoverExperience
                                                ? Colors.blue.shade800
                                                : ref.watch(providerChangeTab) ==
                                                        1
                                                    ? Colors.blue
                                                    : Colors.blue.shade300,
                                            fontWeight: isHoverExperience
                                                ? FontWeight.w700
                                                : FontWeight.w400,
                                            fontSize: 16),
                                      ),
                                      const Gap(8),
                                      Consumer(builder: (context, ref, _) {
                                        if (ref.watch(providerChangeTab) == 1) {
                                          return AnimatedBuilder(
                                              animation: _control,
                                              builder: (context, _) {
                                                return SizeTransition(
                                                  axis: Axis.horizontal,
                                                  axisAlignment: -1,
                                                  sizeFactor: _control,
                                                  child: Container(
                                                    height: 2,
                                                    width:
                                                        lengthIndicator.value,
                                                    decoration: const BoxDecoration(
                                                        color: Colors.blue,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                                  ),
                                                );
                                              });
                                        } else {
                                          return const Gap(0);
                                        }
                                      }),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            MouseRegion(
                              onHover: (value) {
                                setState(() {
                                  isHoverProject = true;
                                });
                              },
                              onExit: (event) {
                                setState(() {
                                  isHoverProject = false;
                                });
                              },
                              child: InkWell(
                                onTap: () {
                                  _control.reset();
                                  _control.forward();
                                  widget.projectCallBack();
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Project",
                                        style: TextStyle(
                                            color: isHoverProject
                                                ? Colors.blue.shade800
                                                : ref.watch(providerChangeTab) ==
                                                        2
                                                    ? Colors.blue
                                                    : Colors.blue.shade300,
                                            fontWeight: isHoverProject
                                                ? FontWeight.w700
                                                : FontWeight.w400,
                                            fontSize: 16),
                                      ),
                                      const Gap(8),
                                      Consumer(builder: (context, ref, _) {
                                        if (ref.watch(providerChangeTab) == 2) {
                                          return AnimatedBuilder(
                                              animation: _control,
                                              builder: (context, _) {
                                                return SizeTransition(
                                                  axis: Axis.horizontal,
                                                  axisAlignment: -1,
                                                  sizeFactor: _control,
                                                  child: Container(
                                                    height: 2,
                                                    width:
                                                        lengthIndicator.value,
                                                    decoration: const BoxDecoration(
                                                        color: Colors.blue,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                                  ),
                                                );
                                              });
                                        } else {
                                          return const Gap(0);
                                        }
                                      }),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            MouseRegion(
                              onHover: (value) {
                                setState(() {
                                  isHoverResume = true;
                                });
                              },
                              onExit: (event) {
                                setState(() {
                                  isHoverResume = false;
                                });
                              },
                              child: InkWell(
                                onTap: () {
                                  downloadProcess();
                                  widget.resumeCallBack();
                                },
                                child: AnimatedContainer(
                                    height: 52,
                                    duration: const Duration(milliseconds: 200),
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16),
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(30)),
                                        color: isHoverResume
                                            ? Colors.blue
                                            : Colors.white,
                                        border: Border.all(
                                          width: 1,
                                          color: isHoverResume
                                              ? Colors.white
                                              : Colors.blue,
                                        )),
                                    child: Center(
                                        child: Text(
                                      "Resume",
                                      style: TextStyle(
                                          color: isHoverResume
                                              ? Colors.white
                                              : Colors.blue.shade300,
                                          fontWeight: isHoverResume
                                              ? FontWeight.w700
                                              : FontWeight.w400,
                                          fontSize: 16),
                                    ))),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  })
                ],
              ),
            ),
            Builder(builder: (context) {
              if (openBottom) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.25,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MouseRegion(
                        onHover: (value) {
                          setState(() {
                            isHoverAbout = true;
                          });
                        },
                        onExit: (event) {
                          setState(() {
                            isHoverAbout = false;
                          });
                        },
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              openBottom = false;
                            });
                            widget.aboutCallBack();
                            widget.isExpanded(openBottom);
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            child: Text(
                              "About",
                              style: TextStyle(
                                  color: isHoverAbout
                                      ? Colors.blue.shade800
                                      : Colors.blue.shade300,
                                  fontWeight: isHoverAbout
                                      ? FontWeight.w700
                                      : FontWeight.w400,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      MouseRegion(
                        onHover: (value) {
                          setState(() {
                            isHoverExperience = true;
                          });
                        },
                        onExit: (event) {
                          setState(() {
                            isHoverExperience = false;
                          });
                        },
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              openBottom = false;
                            });
                            widget.experienceCallBack();
                            widget.isExpanded(openBottom);
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            child: Text(
                              "Experience",
                              style: TextStyle(
                                  color: isHoverExperience
                                      ? Colors.blue.shade800
                                      : Colors.blue.shade300,
                                  fontWeight: isHoverExperience
                                      ? FontWeight.w700
                                      : FontWeight.w400,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      MouseRegion(
                        onHover: (value) {
                          setState(() {
                            isHoverProject = true;
                          });
                        },
                        onExit: (event) {
                          setState(() {
                            isHoverProject = false;
                          });
                        },
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              openBottom = false;
                            });
                            widget.projectCallBack();
                            widget.isExpanded(openBottom);
                          },
                          child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              child: Text(
                                "Project",
                                style: TextStyle(
                                    color: isHoverProject
                                        ? Colors.blue.shade800
                                        : Colors.blue.shade300,
                                    fontWeight: isHoverProject
                                        ? FontWeight.w700
                                        : FontWeight.w400,
                                    fontSize: 16),
                              )),
                        ),
                      ),
                      MouseRegion(
                        onHover: (value) {
                          setState(() {
                            isHoverResume = true;
                          });
                        },
                        onExit: (event) {
                          setState(() {
                            isHoverResume = false;
                          });
                        },
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              openBottom = false;
                            });
                            downloadProcess();
                            widget.resumeCallBack();
                            widget.isExpanded(openBottom);
                          },
                          child: AnimatedContainer(
                              width: 250,
                              height: 52,
                              duration: const Duration(milliseconds: 200),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(30)),
                                  color: isHoverResume
                                      ? Colors.blue
                                      : Colors.white,
                                  border: Border.all(
                                    width: 1,
                                    color: isHoverResume
                                        ? Colors.white
                                        : Colors.blue,
                                  )),
                              child: Center(
                                  child: Text(
                                "Resume",
                                style: TextStyle(
                                    color: isHoverResume
                                        ? Colors.white
                                        : Colors.blue.shade300,
                                    fontWeight: isHoverResume
                                        ? FontWeight.w700
                                        : FontWeight.w400,
                                    fontSize: 16),
                              ))),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const SizedBox();
              }
            }),
          ],
        ));
  }
}
