import 'package:flutter_test/flutter_test.dart';
import 'package:myweb/model/about_model.dart';

void main() {
  test("missing fields fall back, present fields win", () {
    final about = AboutModel.fromJson(const {"phone": "+62 811-2233-4455"});
    expect(about.phone, "+62 811-2233-4455");
    expect(about.phoneUri.toString(), "tel:+6281122334455");
    expect(about.email, AboutModel.fallback.email);
  });
}
