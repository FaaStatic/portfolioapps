import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:myweb/helper/palette.dart';
import 'package:myweb/model/experience_model.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ExperienceItem extends StatelessWidget {
  final ExperienceModel model;
  final bool isLast;
  const ExperienceItem({super.key, required this.model, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveBreakpoints.of(context).isDesktop;
    final meta = [model.typeWork, model.location].whereType<String>().where((part) => part.isNotEmpty).join(", ");

    final when = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(model.period, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Palette.primary)),
        if (meta.isNotEmpty) ...[
          const Gap(4),
          Text(meta,
              style: const TextStyle(
                  fontFamily: bodyFont, fontSize: 13, height: 1.5, fontWeight: FontWeight.w600, color: Palette.body)),
        ],
      ],
    );

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isDesktop) ...[
            SizedBox(width: 200, child: Padding(padding: const EdgeInsets.only(top: 22), child: when)),
            const Gap(24),
          ],
          SizedBox(
            width: 20,
            child: Column(children: [
              const Gap(26),
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: model.colorSymbol ?? Palette.primary,
                  border: Border.all(color: Colors.white, width: 3),
                ),
              ),
              if (!isLast) Expanded(child: Container(width: 2, color: Palette.primary.withValues(alpha: 0.25))),
            ]),
          ),
          Gap(isDesktop ? 24 : 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
              child: Container(
                padding: EdgeInsets.all(isDesktop ? 28 : 20),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(28)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!isDesktop) ...[when, const Gap(12)],
                    Text(model.position ?? "",
                        style: const TextStyle(
                            fontSize: 18, height: 1.35, fontWeight: FontWeight.w700, color: Palette.heading)),
                    const Gap(4),
                    Text(model.companyName ?? "",
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Palette.heading)),
                    const Gap(14),
                    for (final highlight in model.highlights)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Container(
                            width: 6,
                            height: 6,
                            margin: const EdgeInsets.only(top: 9, right: 12),
                            decoration: const BoxDecoration(color: Palette.accent, shape: BoxShape.circle),
                          ),
                          Expanded(
                              child: Text(highlight,
                                  style: const TextStyle(
                                      fontFamily: bodyFont,
                                      fontSize: 15,
                                      height: 1.65,
                                      fontWeight: FontWeight.w500,
                                      color: Palette.body))),
                        ]),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
