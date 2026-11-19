/// About copy and contact details from profile/about. A missing field falls back to the value here.
class AboutModel {
  final String eyebrow;
  final String title;
  final String summary;
  final String location;
  final String phone;
  final String email;
  final String github;
  final String linkedin;
  final String whatsapp;
  final String telegram;
  final String instagram;

  const AboutModel(
      {required this.eyebrow,
      required this.title,
      required this.summary,
      required this.location,
      required this.phone,
      required this.email,
      required this.github,
      required this.linkedin,
      required this.whatsapp,
      required this.telegram,
      required this.instagram});

  factory AboutModel.fromJson(Map<String, dynamic> json) => AboutModel(
      eyebrow: json["eyebrow"] as String? ?? "ABOUT MYSELF",
      title: json["title"] as String? ?? "Know About Me\nIn Detail",
      summary: json["summary"] as String? ??
          "Hey again! I'm Faruq, a mobile engineer with 5 years in React Native, Flutter, and Kotlin, and lately the Go APIs behind the apps too. "
              "I like building apps that keep working offline: my favorite is COIP, which 3+ mining companies use for up to 100 inspections a day "
              "at sites with no signal. Right now I'm at REDDOG, building POS features from the Go API to the React screen.",
      location: json["location"] as String? ?? "Jakarta, Indonesia",
      phone: json["phone"] as String? ?? "+62 857-1356-1437",
      email: json["email"] as String? ?? "suhaili.faruq01@gmail.com",
      github: json["github"] as String? ?? "https://github.com/FaaStatic",
      linkedin: json["linkedin"] as String? ?? "https://www.linkedin.com/in/suhaili-faruq-8475a0189/",
      whatsapp: json["whatsapp"] as String? ?? "https://wa.me/6285713561437",
      telegram: json["telegram"] as String? ?? "https://t.me/suhailifaruq",
      instagram: json["instagram"] as String? ?? "https://www.instagram.com/suhailifaruq_/");

  /// Shown while profile/about loads or when it can't be read.
  static final fallback = AboutModel.fromJson(const {});

  // "+62 857-1356-1437" -> tel:+6285713561437
  Uri get phoneUri => Uri(scheme: "tel", path: phone.replaceAll(RegExp(r"[^+\d]"), ""));
}
