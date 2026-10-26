import 'package:flutter/material.dart';
import 'package:myweb/helper/palette.dart';

typedef NavItem = ({String label, IconData icon, VoidCallback onTap});

/// Floating pill-shaped bottom navigation for mobile and tablet widths.
class FloatingNav extends StatelessWidget {
  final List<NavItem> items;
  final int activeIndex;

  const FloatingNav({super.key, required this.items, required this.activeIndex});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      minimum: const EdgeInsets.fromLTRB(12, 0, 12, 16),
      child: Center(
        heightFactor: 1,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 460),
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: Palette.panel, width: 1.5),
              boxShadow: [
                BoxShadow(color: Palette.heading.withValues(alpha: 0.18), blurRadius: 30, offset: const Offset(0, 12)),
              ],
            ),
            child: Row(children: [
              for (var i = 0; i < items.length; i++)
                Expanded(child: _NavButton(item: items[i], active: i == activeIndex)),
            ]),
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final NavItem item;
  final bool active;

  const _NavButton({required this.item, required this.active});

  @override
  Widget build(BuildContext context) {
    final color = active ? Colors.white : Palette.heading;
    return Semantics(
      button: true,
      selected: active,
      label: item.label,
      excludeSemantics: true,
      child: InkWell(
        onTap: item.onTap,
        borderRadius: BorderRadius.circular(100),
        child: AnimatedContainer(
          duration: MediaQuery.disableAnimationsOf(context) ? Duration.zero : const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            gradient: active ? Palette.buttonGradient : null,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(item.icon, size: 20, color: color),
            const SizedBox(height: 2),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(item.label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: color)),
            ),
          ]),
        ),
      ),
    );
  }
}
