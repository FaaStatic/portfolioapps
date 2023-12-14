import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myweb/screen/component/about_screen.dart';
import 'package:myweb/screen/component/head_bar.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Positioned.fill(
                  child: SingleChildScrollView(
                controller: _controller,
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.30),
                child: const Column(
                  children: [AboutScreen()],
                ),
              )),
              const Positioned(left: 0, right: 0, top: 0, child: HeadBar())
            ],
          )),
    );
  }
}
