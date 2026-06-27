import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_watch/features/home/ui/pages/home_page.dart';
import 'package:smart_watch/core/injection_container/injection_container.dart' as injection;
import 'package:smart_watch/features/home/ui/widgets/watch_frame.dart';
import 'package:smart_watch/features/home/ui/widgets/watch_screen.dart';
import 'package:smart_watch/features/splash/ui/pages/splash_page.dart';

void main() {
  testWidgets("should test the home page flow", (tester) async {
    injection.init();

    await tester.runAsync(() async => await tester.pumpWidget(const MaterialApp(
          title: 'Pixel Watch',
          debugShowCheckedModeBanner: false,
          home: HomePage(),
        )));

    await tester.idle();

    await tester.pumpAndSettle(const Duration(seconds: 6));

    final watchFrame = find.byType(WatchFrame);
    expect(watchFrame, findsOneWidget);

    final homePageElements = tester.widget<WatchFrame>(watchFrame);
    expect(homePageElements.content, isInstanceOf<WatchScreen>());

    final splashPage = find.byType(SplashPage);
    expect(splashPage, findsOneWidget);
  });
}
