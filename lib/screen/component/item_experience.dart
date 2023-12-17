import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:myweb/helper/util.dart';

class ItemExperience extends ConsumerStatefulWidget {
  final String imagePath;
  final String companyName;
  final String position;
  final DateTime startWork;
  final void Function(Map<String, dynamic> value) callBack;

  final DateTime endWork;
  final String description;
  const ItemExperience({
    super.key,
    this.imagePath =
        "https://images.unsplash.com/photo-1519389950473-47ba0277781c?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3Dhttps://images.unsplash.com/photo-1519389950473-47ba0277781c?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3Dhttps://images.unsplash.com/photo-1519389950473-47ba0277781c?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    this.companyName = "PT Tokopedia",
    this.position = "Manager",
    required this.startWork,
    required this.endWork,
    this.description = "Management Team and Project",
    required this.callBack,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ItemExperienceState();
}

class _ItemExperienceState extends ConsumerState<ItemExperience> with TickerProviderStateMixin {
  late AnimationController _control;
  late Animation<double> blurShadow;
  late Animation<double> spreadShadow;
  late Animation<double> showButton;
  late ColorTween colorShadow;
  bool showDetail = false;

  @override
  void initState() {
    _control = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    blurShadow = Tween<double>(begin: 10, end: 20)
        .animate(CurvedAnimation(parent: _control, curve: Curves.easeIn));
    spreadShadow = Tween<double>(begin: 1, end: 5)
        .animate(CurvedAnimation(parent: _control, curve: Curves.easeIn));
    showButton =
        Tween<double>(begin: 0, end: WidgetsBinding.instance.window.physicalSize.height * 0.6)
            .animate(CurvedAnimation(parent: _control, curve: Curves.easeIn));
    colorShadow =
        ColorTween(begin: Colors.black.withOpacity(0.2), end: Colors.black.withOpacity(0.8));
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
              _control.forward().whenComplete(() {
                setState(() {
                  showDetail = true;
                });
              });
            },
            onExit: (event) {
              setState(() {
                showDetail = false;
              });
              _control.reset();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: Util().autoSizing(context, stat: 1, percent: 0.45),
              height: Util().autoSizing(context, stat: 2, percent: 0.6),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        color: colorShadow.evaluate(_control)!,
                        spreadRadius: spreadShadow.value,
                        blurRadius: blurShadow.value,
                        offset: const Offset(1, 2))
                  ]),
              child: Stack(
                children: [
                  Positioned.fill(
                      child: SizedBox(
                    width: Util().autoSizing(context, stat: 1, percent: 0.45),
                    height: Util().autoSizing(context, stat: 2, percent: 0.6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                          child: Image.network(
                            widget.imagePath,
                            width: Util().autoSizing(context, stat: 1, percent: 0.45),
                            height: Util().autoSizing(context, stat: 2, percent: 0.25),
                            fit: BoxFit.fill,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
                          child: Text(
                            widget.companyName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const Gap(16),
                        Padding(
                            padding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
                            child: RichText(
                                text: TextSpan(
                                    text: "Position : ",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                    children: [
                                  TextSpan(
                                      text: widget.position,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ))
                                ]))),
                        const Gap(16),
                        Padding(
                            padding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
                            child: RichText(
                                text: TextSpan(
                                    text: "Service : ",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                    children: [
                                  TextSpan(
                                      text: "${DateFormat("yyyy").format(widget.startWork)}-",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      )),
                                  TextSpan(
                                      text: DateFormat("yyyy").format(widget.startWork),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      )),
                                ]))),
                        const Gap(16)
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
                            duration: const Duration(milliseconds: 500),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        fixedSize: const Size(200, 52),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(10)))),
                                    child: const Text(
                                      "Detail Experience",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ))
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
