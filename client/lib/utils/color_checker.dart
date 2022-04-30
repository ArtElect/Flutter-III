import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class ColorChecker {
  static Color getColorByLength({required int length}) {
    if (length == 1) {
      return GFColors.PRIMARY;
    }
    if (length == 2) {
      return GFColors.SUCCESS;
    }
    if (length == 3) {
      return GFColors.WARNING;
    }
    return GFColors.DANGER;
  }

  static Color getColorByName({required String name}) {
    if (name == "READ") {
      return GFColors.PRIMARY;
    }
    if (name == "CREATE") {
      return GFColors.SUCCESS;
    }
    if (name == "UPDATE") {
      return GFColors.WARNING;
    }
    return GFColors.DANGER;
  }
}
