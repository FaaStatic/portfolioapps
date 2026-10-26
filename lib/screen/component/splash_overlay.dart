import 'package:flutter/material.dart';
import 'package:myweb/helper/palette.dart';

/// Covers [child] on first load, then flies the logo into the header slot at [logoKey]
/// while the backdrop slides up. Hero-style, but within one route so the URL stays "/".
class SplashOverlay extends StatefulWidget {
  final GlobalKey logoKey;
  final Widget child;

  const SplashOverlay({super.key, required this.logoKey, required this.child});

  @override
  State<SplashOverlay> createState() => _SplashOverlayState();
}

class _SplashOverlayState extends State<SplashOverlay> with SingleTickerProviderStateMixin {
  late final _exit = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
  // Backdrop starts a beat late and uncovers the header last, so the real logo never shows before ours lands.
  late final _slide = Tween(begin: Offset.zero, end: const Offset(0, -1))
      .chain(CurveTween(curve: const Interval(0.15, 1, curve: Curves.easeInOutCubic)))
      .animate(_exit);
  late final _flight = _exit.drive(CurveTween(curve: const Interval(0, 0.85, curve: Curves.easeInOutCubic)));
  final _splashLogoKey = GlobalKey();
  Rect? _from, _to;
  bool _gone = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1300), _leave);
  }

  @override
  void dispose() {
    _exit.dispose();
    super.dispose();
  }

  Rect? _rectOf(GlobalKey key) {
    final box = key.currentContext?.findRenderObject() as RenderBox?;
    return box == null || !box.hasSize ? null : box.localToGlobal(Offset.zero) & box.size;
  }

  Future<void> _leave() async {
    if (!mounted) return;
    if (MediaQuery.disableAnimationsOf(context)) _exit.duration = Duration.zero;
    setState(() {
      _from = _rectOf(_splashLogoKey);
      _to = _rectOf(widget.logoKey);
    });
    await _exit.forward();
    if (mounted) setState(() => _gone = true);
  }

  @override
  Widget build(BuildContext context) {
    // The Stack stays put after the splash is gone so the page element underneath is never remounted.
    return Stack(
      children: [
        widget.child,
        if (!_gone)
          Positioned.fill(
            // Own layer and layout scope, so animating the splash never repaints or relays out the page.
            child: RepaintBoundary(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: SlideTransition(
                      position: _slide,
                      child: const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                              center: Alignment(0, -0.16), radius: 0.9, colors: [Palette.panel, Palette.background]),
                        ),
                      ),
                    ),
                  ),
                  if (_from != null && _to != null)
                    AnimatedBuilder(
                      animation: _flight,
                      builder: (context, child) =>
                          Positioned.fromRect(rect: Rect.lerp(_from, _to, _flight.value)!, child: child!),
                      child: Image.asset("assets/images/logo.webp", fit: BoxFit.contain),
                    )
                  else
                    Center(
                      child: TweenAnimationBuilder(
                        tween: Tween(begin: 0.0, end: 1.0),
                        duration:
                            MediaQuery.disableAnimationsOf(context) ? Duration.zero : const Duration(milliseconds: 700),
                        curve: Curves.easeOutBack,
                        builder: (context, t, child) => Opacity(
                            opacity: t.clamp(0.0, 1.0), child: Transform.scale(scale: 0.85 + 0.15 * t, child: child)),
                        child: Image.asset("assets/images/logo.webp",
                            key: _splashLogoKey, height: 72, semanticLabel: "Suhaili Faruq"),
                      ),
                    ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
