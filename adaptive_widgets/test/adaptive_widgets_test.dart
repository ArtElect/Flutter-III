import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:adaptive_widgets/adaptive_widgets.dart';


void main() {

  setUp(() {
  });
  test('emulate different screen size', () {
    const Size size = Size(700, 1200);

    expect(AdaptiveWidget.isSmallScreen(size), true);
    expect(AdaptiveWidget.isMediumScreen(size), false);
    expect(AdaptiveWidget.isLargeScreen(size), false);
  });
}
