import 'dart:ui';

import 'package:hexcolor/hexcolor.dart';

class ExperienceModel {
  final String? companyName;
  final String? dateStart;
  final String? dateEnd;
  final String? typeWork;
  final String? position;
  final String? pathLinkCertif;
  final String? description;
  final Color? colorSymbol;
  final String? pathLogo;

  const ExperienceModel(
      {required this.companyName,
      required this.dateStart,
      required this.pathLinkCertif,
      required this.dateEnd,
      required this.colorSymbol,
      required this.description,
      required this.pathLogo,
      required this.position,
      required this.typeWork});

  factory ExperienceModel.fromJson(Map<String, dynamic> json) => ExperienceModel(
      companyName: json["company_name"],
      dateStart: json["date_start"],
      pathLinkCertif: json["link_certif"],
      dateEnd: json["date_end"],
      colorSymbol: HexColor(json["color_symbol"]),
      description: json["description"],
      pathLogo: json["path_logo"],
      position: json["position"],
      typeWork: json["type_work"]);
}
