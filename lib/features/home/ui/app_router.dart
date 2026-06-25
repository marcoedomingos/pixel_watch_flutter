import 'package:flutter/material.dart';
import 'package:smart_watch/features/clock/ui/pages/clock_page.dart';
import 'package:smart_watch/features/fitbit/ui/pages/fitbit_page.dart';
import 'package:smart_watch/features/heart_rate/ui/pages/heart_rate_page.dart';
import 'package:smart_watch/features/menu/ui/pages/menu_page.dart';
import 'package:smart_watch/features/weather/ui/pages/weather_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute({
    required RouteSettings settings,
    required BuildContext clockContext,
    required VoidCallback onShowWarning,
  }) {
    final route = settings.name ?? '/clock';

    return MaterialPageRoute<void>(
      settings: settings,
      builder: (ctx) {
        switch (route) {
          case '/clock':
            return ClockPage(
              heartClicked: () {
                Navigator.pushNamed(clockContext, '/heart');
              },
              horizontalSlideControl: (details) {
                int sensitivity = 8;
                if (details.delta.dx < -sensitivity) {
                  Navigator.pushNamed(clockContext, '/clockMenu');
                }
              },
              verticalSlideControl: (details) {
                int sensitivity = 8;
                if (details.delta.dy < -sensitivity) {
                  onShowWarning();
                }
              },
            );
          case '/clockMenu':
            return MenuPage(
              heartClicked: () {
                Navigator.pushNamed(clockContext, '/heart');
              },
              weatherClicked: () {
                Navigator.pushNamed(clockContext, '/weather');
              },
              fitbitClicked: () {
                Navigator.pushNamed(clockContext, '/fitbit');
              },
              horizontalSlideControl: (details) {
                int sensitivity = 8;
                if (details.delta.dx > sensitivity) {
                  Navigator.of(clockContext).pop();
                }
              },
              verticalSlideControl: (details) {},
            );
          case '/fitbit':
            return const FitbitPage();
          case '/heart':
            return const HeartRatePage();
          default:
            return const WeatherPage();
        }
      },
    );
  }
}
