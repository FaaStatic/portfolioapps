import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ItemContact extends StatefulWidget {
  final void Function() callback;
  final String pathImage;
  final String title;
  const ItemContact(
      {super.key, required this.title, required this.pathImage, required this.callback});

  @override
  State<ItemContact> createState() => _ItemContactState();
}

class _ItemContactState extends State<ItemContact> with TickerProviderStateMixin {
  late AnimationController _control;
  late Animation<Color?> colorBg;
  late Animation<Color?> colorIcon;

  @override
  void initState() {
    _control = AnimationController(duration: const Duration(milliseconds: 10), vsync: this);
    colorBg = ColorTween(begin: Colors.white, end: Colors.blue.shade600)
        .animate(CurvedAnimation(parent: _control, curve: Curves.easeIn));
    colorIcon = ColorTween(begin: Colors.blue.shade600, end: Colors.white)
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
    return Padding(
      padding: const EdgeInsets.all(8),
      child: MouseRegion(
          onHover: (event) {
            _control.forward();
          },
          onExit: (event) {
            _control.reset();
          },
          child: GestureDetector(
            onTap: widget.callback,
            child: AnimatedBuilder(
              animation: _control,
              builder: (context, _) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(color: colorBg.value!, shape: BoxShape.circle),
                  child: Center(
                      child: SvgPicture.asset(
                    widget.pathImage,
                    width: 36,
                    height: 36,
                    color: colorIcon.value,
                  )),
                );
              },
            ),
          )),
    );
  }
}
