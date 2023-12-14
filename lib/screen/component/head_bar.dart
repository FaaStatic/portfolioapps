import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myweb/provider/provider_tab.dart';
import 'package:responsive_framework/responsive_framework.dart';

class HeadBar extends ConsumerStatefulWidget {
  const HeadBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HeadBarState();
}

class _HeadBarState extends ConsumerState<HeadBar> with TickerProviderStateMixin {
  bool isHover = false;
  bool isHoverProject = false;
  bool isHoverContact = false;
  bool isHoverAbout = false;
  bool openBottom = false;

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
                    onTap: () {
                      context.go("/");
                    },
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
                              child: Icon(
                                openBottom ? Icons.close : Icons.list_outlined,
                                color: isHover ? Colors.blue : Colors.blue.shade300,
                                size: 35,
                              )),
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
                                  ref.read(providerChangeTab.notifier).changeTab(0);
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  child: Text(
                                    "About",
                                    style: TextStyle(
                                        color: isHoverAbout
                                            ? Colors.blue.shade800
                                            : Colors.blue.shade300,
                                        fontWeight:
                                            isHoverAbout ? FontWeight.w700 : FontWeight.w400,
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
                                  ref.read(providerChangeTab.notifier).changeTab(1);
                                },
                                child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    child: Text(
                                      "Project",
                                      style: TextStyle(
                                          color: isHoverProject
                                              ? Colors.blue.shade800
                                              : Colors.blue.shade300,
                                          fontWeight:
                                              isHoverProject ? FontWeight.w700 : FontWeight.w400,
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
                                  ref.read(providerChangeTab.notifier).changeTab(2);
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  child: Text(
                                    "Contact",
                                    style: TextStyle(
                                        color: isHoverContact
                                            ? Colors.blue.shade800
                                            : Colors.blue.shade300,
                                        fontWeight:
                                            isHoverContact ? FontWeight.w700 : FontWeight.w400,
                                        fontSize: 16),
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
                          onTap: () {},
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
                          onTap: () {},
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
                          onTap: () {},
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
