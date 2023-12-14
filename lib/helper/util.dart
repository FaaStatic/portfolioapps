import 'package:flutter/material.dart';

class Util {
  static final _util = Util._instance();

  factory Util() {
    return _util;
  }

  Util._instance();

  double autoSizing(BuildContext context, {int stat = 1, double percent = 0}) {
    switch (stat) {
      case 1:
        if (percent > 0) {
          return MediaQuery.of(context).size.width * percent;
        } else {
          return MediaQuery.of(context).size.width;
        }

      case 2:
        if (percent > 0) {
          return MediaQuery.of(context).size.height * percent;
        } else {
          return MediaQuery.of(context).size.height;
        }

      default:
        return MediaQuery.of(context).size.width;
    }
  }
}
