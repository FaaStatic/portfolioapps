import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myweb/screen/component/splash_overlay.dart';

class _Page extends StatefulWidget {
  const _Page();

  static int mounts = 0;

  @override
  State<_Page> createState() => _PageState();
}

class _PageState extends State<_Page> {
  @override
  void initState() {
    super.initState();
    _Page.mounts++;
  }

  @override
  Widget build(BuildContext context) => const SizedBox.expand();
}

void main() {
  testWidgets('splash leaves without remounting the page beneath', (tester) async {
    await tester.pumpWidget(MaterialApp(home: SplashOverlay(logoKey: GlobalKey(), child: const _Page())));
    expect(find.byType(Image), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 1300));
    await tester.pumpAndSettle();

    expect(find.byType(Image), findsNothing);
    expect(_Page.mounts, 1);
  });
}
