import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:myweb/helper/palette.dart';
import 'package:responsive_framework/responsive_framework.dart';

const double maxContentWidth = 1180;

double gutterOf(BuildContext context) => ResponsiveBreakpoints.of(context).isMobile ? 16 : 32;

TextStyle displayStyle(BuildContext context, {double desktop = 52, double mobile = 32}) => TextStyle(
    fontSize: ResponsiveBreakpoints.of(context).isMobile ? mobile : desktop,
    height: 1.1,
    fontWeight: FontWeight.w900,
    color: Palette.heading);

const eyebrowStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Palette.primary);

/// Centers content at [maxContentWidth]. [panel] draws the tinted rounded block from the reference design;
/// [floating] are Positioned decorations laid over the full page width, shown on desktop only.
class Section extends StatelessWidget {
  final String? eyebrow;
  final String? title;
  final String? subtitle;
  final bool panel;
  final List<Widget> floating;
  final Widget child;

  const Section(
      {super.key,
      this.eyebrow,
      this.title,
      this.subtitle,
      this.panel = false,
      this.floating = const [],
      required this.child});

  @override
  Widget build(BuildContext context) {
    final breakpoints = ResponsiveBreakpoints.of(context);
    final inner = panel ? (breakpoints.isMobile ? 20.0 : 64.0) : 0.0;

    final content = Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: maxContentWidth),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: gutterOf(context), vertical: breakpoints.isMobile ? 32 : 56),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: inner, vertical: panel ? inner : 0),
            decoration: panel
                ? BoxDecoration(color: Palette.panel, borderRadius: BorderRadius.circular(breakpoints.isMobile ? 28 : 48))
                : null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (eyebrow != null) ...[
                  Text(eyebrow!, textAlign: TextAlign.center, style: eyebrowStyle),
                  const Gap(10),
                ],
                if (title != null) ...[
                  Text(title!.toUpperCase(), textAlign: TextAlign.center, style: displayStyle(context)),
                  if (subtitle != null) ...[
                    const Gap(14),
                    Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 560),
                        child: Text(subtitle!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontFamily: bodyFont,
                                fontSize: 17,
                                height: 1.6,
                                fontWeight: FontWeight.w500,
                                color: Palette.body)),
                      ),
                    ),
                  ],
                  Gap(breakpoints.isMobile ? 28 : 48),
                ],
                child,
              ],
            ),
          ),
        ),
      ),
    );

    // Edge badges need empty margin beside the content, otherwise they cover text.
    final hasMargin = MediaQuery.sizeOf(context).width >= maxContentWidth + 180;
    if (floating.isEmpty || !hasMargin) return content;
    return Stack(clipBehavior: Clip.none, children: [content, ...floating]);
  }
}

/// Rows of equal-height cells; column count follows the available width.
class ResponsiveGrid extends StatelessWidget {
  final double minItemWidth;
  final int maxColumns;
  final List<Widget> children;

  static const spacing = 24.0;

  const ResponsiveGrid({super.key, required this.minItemWidth, required this.maxColumns, required this.children});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final columns = ((constraints.maxWidth + spacing) ~/ (minItemWidth + spacing)).clamp(1, maxColumns);
      final rows = <Widget>[];
      for (var start = 0; start < children.length; start += columns) {
        final cells = children.sublist(start, (start + columns).clamp(0, children.length));
        rows.add(IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < columns; i++) ...[
                if (i > 0) const Gap(spacing),
                Expanded(child: i < cells.length ? cells[i] : const SizedBox()),
              ],
            ],
          ),
        ));
      }
      return Column(
        children: [
          for (var i = 0; i < rows.length; i++) ...[if (i > 0) const Gap(spacing * 1.5), rows[i]],
        ],
      );
    });
  }
}

/// Gradient pill with a soft glow, like the reference CTAs; [outlined] is the quiet variant.
class PillButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool outlined;
  final IconData? icon;

  const PillButton({super.key, required this.label, required this.onPressed, this.outlined = false, this.icon});

  @override
  Widget build(BuildContext context) {
    final foreground = outlined ? Palette.primary : Colors.white;
    final radius = BorderRadius.circular(100);

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: radius,
        gradient: outlined ? null : Palette.buttonGradient,
        color: outlined ? Colors.white : null,
        border: outlined ? Border.all(color: Palette.primary, width: 1.5) : null,
        boxShadow: outlined
            ? null
            : [BoxShadow(color: Palette.primary.withValues(alpha: 0.35), blurRadius: 24, offset: const Offset(0, 10))],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onPressed,
          borderRadius: radius,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 15),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              if (icon != null) ...[Icon(icon, size: 18, color: foreground), const Gap(8)],
              Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: foreground)),
            ]),
          ),
        ),
      ),
    );
  }
}

/// App-icon style tile that drifts up and down; [blur] pushes it into the background.
class FloatingBadge extends StatefulWidget {
  final String asset;
  final double size;
  final double blur;
  final double turns;
  final bool reverse;

  const FloatingBadge(
      {super.key, required this.asset, this.size = 60, this.blur = 0, this.turns = 0, this.reverse = false});

  @override
  State<FloatingBadge> createState() => _FloatingBadgeState();
}

class _FloatingBadgeState extends State<FloatingBadge> with SingleTickerProviderStateMixin {
  late final AnimationController _drift = AnimationController(vsync: this, duration: const Duration(milliseconds: 3200));

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _drift.stop();
    } else if (!_drift.isAnimating) {
      _drift.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _drift.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.size;
    Widget tile = Transform.rotate(
      angle: widget.turns * 2 * math.pi,
      child: Container(
        width: size,
        height: size,
        padding: EdgeInsets.all(size * 0.2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(size * 0.28),
          boxShadow: [
            BoxShadow(color: Palette.heading.withValues(alpha: 0.16), blurRadius: size * 0.35, offset: Offset(0, size * 0.15))
          ],
        ),
        child: Image.asset(widget.asset),
      ),
    );
    if (widget.blur > 0) {
      tile = ImageFiltered(imageFilter: ImageFilter.blur(sigmaX: widget.blur, sigmaY: widget.blur), child: tile);
    }

    // The drift repaints every frame; the boundaries keep that off the page and reuse the blurred tile raster.
    return ExcludeSemantics(
      child: RepaintBoundary(
        child: AnimatedBuilder(
          animation: _drift,
          builder: (context, child) {
            final offset = (Curves.easeInOut.transform(_drift.value) - 0.5) * 14;
            return Transform.translate(offset: Offset(0, widget.reverse ? -offset : offset), child: child);
          },
          child: RepaintBoundary(child: tile),
        ),
      ),
    );
  }
}

/// Soft radial glow placed behind portraits.
class Glow extends StatelessWidget {
  final double size;
  const Glow({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(colors: [
            Palette.primary.withValues(alpha: 0.30),
            Palette.primary.withValues(alpha: 0.10),
            Palette.background.withValues(alpha: 0),
          ], stops: const [0, 0.45, 1]),
        ),
      ),
    );
  }
}

/// Vertical wavy stroke from the reference's "about" illustration.
class Squiggle extends StatelessWidget {
  final double height;
  const Squiggle({super.key, this.height = 110});

  @override
  Widget build(BuildContext context) =>
      CustomPaint(size: Size(height * 0.28, height), painter: _SquigglePainter());
}

class _SquigglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()..moveTo(size.width / 2, 0);
    const waves = 3;
    for (var i = 0; i < waves; i++) {
      final y0 = size.height * i / waves;
      final y1 = size.height * (i + 1) / waves;
      final side = i.isEven ? size.width : 0.0;
      path.quadraticBezierTo(side, (y0 + y1) / 2, size.width / 2, y1);
    }
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..shader = const LinearGradient(
              begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Palette.accent, Palette.primary])
          .createShader(Offset.zero & size);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
