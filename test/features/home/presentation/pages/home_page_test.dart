import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_watch/features/home/presentation/pages/home_page.dart';
import 'package:smart_watch/core/injection_container/injection_container.dart'
    as injection;
import 'package:smart_watch/features/home/presentation/pages/widget/watch.dart';
import 'package:smart_watch/features/splash/presentation/pages/splash_page.dart';

void main() {
  testWidgets("should test the home page flow", (tester) async {
    injection.init();

    await tester.runAsync(() async => await tester.pumpWidget(MaterialApp(
          title: 'Pixel Watch',
          debugShowCheckedModeBanner: false,
          home: HomePage(),
        )));

    await tester.idle();

    await tester.pumpAndSettle(Duration(seconds: 6));

    final watchWidget = find.byType(WatchWidget);
    expect(watchWidget, findsOneWidget);

    final homePageElements = tester.widget<WatchWidget>(watchWidget);
    expect(homePageElements.content, isInstanceOf<PageView>());

    final splashPage = find.byType(SplashPage);
    expect(splashPage, findsOneWidget);
  });
}
