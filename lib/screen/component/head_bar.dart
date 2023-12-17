import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:myweb/provider/provider_tab.dart';

import 'package:responsive_framework/responsive_framework.dart';

class HeadBar extends ConsumerStatefulWidget {
  final void Function() aboutCallBack;
  final void Function() projectCallBack;
  final void Function() contactCallBack;
  final void Function() refreshCallBack;
  const HeadBar(
      {super.key,
      required this.refreshCallBack,
      required this.aboutCallBack,
      required this.contactCallBack,
      required this.projectCallBack});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HeadBarState();
}

class _HeadBarState extends ConsumerState<HeadBar> with TickerProviderStateMixin {
  late AnimationController _control;

  bool isHover = false;
  bool isHoverProject = false;
  bool isHoverContact = false;
  bool isHoverAbout = false;
  bool openBottom = false;
  late Animation<double> lengthIndicator;

  @override
  void initState() {
    _control = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    lengthIndicator =
        Tween<double>(begin: 0, end: WidgetsBinding.instance.window.physicalSize.height * 0.15)
            .animate(CurvedAnimation(parent: _control, curve: Curves.easeIn));
    _control.forward();
    super.initState();
  }

  @override
  void dispose() {
    _control.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 1000),
        width: MediaQuery.of(context).size.width,
        color: Colors.transparent,
        constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.15,
            maxHeight: MediaQuery.of(context).size.height * 0.45),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.15,
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
                          fontSize: 20, color: Colors.blue.shade400, fontWeight: FontWeight.w700),
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
                          },
                          child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 35,
                              height: 35,
                              child: Builder(builder: (context) {
                                if (openBottom) {
                                  return Icon(
                                    Icons.close,
                                    color: isHover ? Colors.blue : Colors.blue.shade300,
                                    size: 35,
                                  );
                                } else {
                                  return SvgPicture.asset(
                                    "assets/images/ic_menu.svg",
                                    width: 24,
                                    height: 24,
                                    color: isHover ? Colors.blue : Colors.blue.shade300,
                                  );
                                }
                              })),
                        ),
                      );
                    } else {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: MediaQuery.of(context).size.height * 0.15,
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
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "About",
                                        style: TextStyle(
                                            color: isHoverAbout
                                                ? Colors.blue.shade800
                                                : ref.watch(providerChangeTab) == 0
                                                    ? Colors.blue
                                                    : Colors.blue.shade300,
                                            fontWeight:
                                                isHoverAbout ? FontWeight.w700 : FontWeight.w400,
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
                                                    width: lengthIndicator.value,
                                                    decoration: const BoxDecoration(
                                                        color: Colors.blue,
                                                        borderRadius:
                                                            BorderRadius.all(Radius.circular(10))),
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
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Project",
                                        style: TextStyle(
                                            color: isHoverAbout
                                                ? Colors.blue.shade800
                                                : ref.watch(providerChangeTab) == 1
                                                    ? Colors.blue
                                                    : Colors.blue.shade300,
                                            fontWeight:
                                                isHoverAbout ? FontWeight.w700 : FontWeight.w400,
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
                                                    width: lengthIndicator.value,
                                                    decoration: const BoxDecoration(
                                                        color: Colors.blue,
                                                        borderRadius:
                                                            BorderRadius.all(Radius.circular(10))),
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
                                  isHoverContact = true;
                                });
                              },
                              onExit: (event) {
                                setState(() {
                                  isHoverContact = false;
                                });
                              },
                              child: InkWell(
                                onTap: () {
                                  _control.reset();
                                  _control.forward();
                                  widget.contactCallBack();
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Contact",
                                        style: TextStyle(
                                            color: isHoverAbout
                                                ? Colors.blue.shade800
                                                : ref.watch(providerChangeTab) == 2
                                                    ? Colors.blue
                                                    : Colors.blue.shade300,
                                            fontWeight:
                                                isHoverAbout ? FontWeight.w700 : FontWeight.w400,
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
                                                    width: lengthIndicator.value,
                                                    decoration: const BoxDecoration(
                                                        color: Colors.blue,
                                                        borderRadius:
                                                            BorderRadius.all(Radius.circular(10))),
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
                  height: MediaQuery.of(context).size.height * 0.3,
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
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            child: Text(
                              "About",
                              style: TextStyle(
                                  color: isHoverAbout ? Colors.blue.shade800 : Colors.blue.shade300,
                                  fontWeight: isHoverAbout ? FontWeight.w700 : FontWeight.w400,
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
                          },
                          child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              child: Text(
                                "Project",
                                style: TextStyle(
                                    color: isHoverProject
                                        ? Colors.blue.shade800
                                        : Colors.blue.shade300,
                                    fontWeight: isHoverProject ? FontWeight.w700 : FontWeight.w400,
                                    fontSize: 16),
                              )),
                        ),
                      ),
                      MouseRegion(
                        onHover: (value) {
                          setState(() {
                            isHoverContact = true;
                          });
                        },
                        onExit: (event) {
                          setState(() {
                            isHoverContact = false;
                          });
                        },
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              openBottom = false;
                            });

                            widget.contactCallBack();
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            child: Text(
                              "Contact",
                              style: TextStyle(
                                  color:
                                      isHoverContact ? Colors.blue.shade800 : Colors.blue.shade300,
                                  fontWeight: isHoverContact ? FontWeight.w700 : FontWeight.w400,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const SizedBox();
              }
            })
          ],
        ));
  }
}
