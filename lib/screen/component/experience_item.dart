import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:myweb/model/experience_model.dart';

class ExperienceItem extends StatelessWidget {
  final ExperienceModel model;
  final bool isLast;
  const ExperienceItem({super.key, required this.model, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    final widthItem = MediaQuery.of(context).size.width;
    return SizedBox(
      width: widthItem * 0.85,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: widthItem / 3,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                    child: Wrap(
                  runAlignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runSpacing: 5,
                  spacing: 5,
                  children: [
                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(100)),
                            child: model.pathLogo != null
                                ? Image.network(
                                    model.pathLogo!,
                                    width: 36,
                                    height: 36,
                                    fit: BoxFit.fill,
                                  )
                                : Image.network(
                                    "https://images.unsplash.com/photo-1487446929682-f62f73984006?q=80&w=1471&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                                    width: 36,
                                    height: 36,
                                    fit: BoxFit.fill,
                                  ),
                          ),
                          const Gap(8),
                          Text(
                            model.companyName ?? "",
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                                fontSize: 18,
                                color: Colors.blue,
                                fontWeight: FontWeight.w700),
                          ),
                          const Gap(8),
                          SizedBox(
                            width: 200,
                            child: Text(
                              "${model.dateStart ?? "0"}-${model.dateEnd ?? "0"}",
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
              ],
            ),
          ),
          const Gap(16),
          SizedBox(
            height: 200,
            width: 24,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DottedBorder(
                      borderType: BorderType.Circle,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: model.colorSymbol,
                        ),
                      )),
                  const Gap(8),
                  if (!isLast)
                    Expanded(
                        child: ListView.builder(
                            itemCount: 8,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 8,
                                    top: 8,
                                  ),
                                  child: Container(
                                    width: 4,
                                    height: 4,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey),
                                  ),
                                )))
                ]),
          ),
          const Gap(16),
          SizedBox(
            width: widthItem / 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  model.position ?? "",
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                      fontWeight: FontWeight.w700),
                ),
                const Gap(8),
                Text(
                  model.typeWork ?? "",
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                      fontWeight: FontWeight.w700),
                ),
                const Gap(8),
                Text(
                  model.description ?? "",
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
                const Gap(8),
                if (model.pathLinkCertif != null)
                  Flexible(
                      child: InkWell(
                    onTap: () {},
                    child: const Text(
                      "Link Certificate",
                      style: TextStyle(
                          color: Colors.amber,
                          fontSize: 12,
                          fontWeight: FontWeight.w700),
                    ),
                  ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
