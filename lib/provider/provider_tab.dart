import 'package:flutter_riverpod/flutter_riverpod.dart';

final providerChangeTab = StateNotifierProvider<TabChange, int>((ref) => TabChange());

class TabChange extends StateNotifier<int> {
  TabChange() : super(0);

  void changeTab(int change) {
    state = change;
  }
}
