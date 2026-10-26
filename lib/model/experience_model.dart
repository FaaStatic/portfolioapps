import 'dart:ui';

import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class ExperienceModel {
  final String? companyName;
  final String? dateStart;
  final String? dateEnd;
  final String? typeWork;
  final String? location;
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
      required this.typeWork,
      required this.location});

  factory ExperienceModel.fromJson(Map<String, dynamic> json) => ExperienceModel(
      companyName: json["company_name"],
      dateStart: json["date_start"],
      pathLinkCertif: json["link_certif"],
      dateEnd: json["date_end"],
      colorSymbol: json["color_symbol"] != null ? HexColor(json["color_symbol"]) : null,
      description: json["description"],
      pathLogo: json["path_logo"],
      position: json["position"],
      typeWork: json["type_work"],
      location: json["location"]);

  String get period => "${_monthYear(dateStart)} – ${_monthYear(dateEnd)}";

  List<String> get highlights =>
      (description ?? "").split("\n").map((line) => line.trim()).where((line) => line.isNotEmpty).toList();

  // "2024-07" -> "Jul 2024"; anything else ("2021", "Present") is shown as stored.
  static String _monthYear(String? raw) {
    if (raw == null || !RegExp(r'^\d{4}-\d{2}$').hasMatch(raw)) return raw ?? "";
    return DateFormat("MMM yyyy").format(DateTime.parse("$raw-01"));
  }
}
