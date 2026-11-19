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
          "Hey again! I'm Faruq, a mobile engineer with 5 years in React Native, Flutter, and Kotlin, and these days I build the Go APIs behind the apps too. "
              "My favorite project so far is COIP, an app I built from scratch at United Tractors as the only mobile developer: 3+ mining companies use it to inspect heavy equipment "
              "at sites with no signal, running up to 100 inspections a day, and it syncs once the device is back in range. "
              "Before that I shipped six apps at NEXA, four of them on my own, including ForYou, which holds 4.8 stars and 10K+ downloads on Google Play. "
              "Now I'm at REDDOG, building POS features from the Go API to the React screen. "
              "I use Claude Code to move faster, and I still design, review, and test every change myself.",
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
