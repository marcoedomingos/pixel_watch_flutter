import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:smart_watch/commons/colors.dart';
import 'package:smart_watch/commons/size/size.dart';
import 'package:smart_watch/core/presentation/bloc/heartbeat/heartbeat_bloc.dart';
import 'package:smart_watch/core/presentation/bloc/home/home_bloc.dart';
import 'package:smart_watch/core/presentation/bloc/weather/weather_bloc.dart';
import 'package:smart_watch/features/clock/presentation/pages/clock_page.dart';
import 'package:smart_watch/features/fitbit/presentation/pages/fitbit_page.dart';
import 'package:smart_watch/features/heart_rate/presentation/pages/heart_rate_page.dart';
import 'package:smart_watch/features/home/presentation/pages/widget/watch.dart';
import 'package:smart_watch/features/menu/presentation/pages/menu_page.dart';
import 'package:smart_watch/features/splash/presentation/pages/splash_page.dart';
import 'package:smart_watch/core/injection_container/injection_container.dart';
import 'package:smart_watch/features/weather/presentation/pages/weather_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bloc = injectionInstance<HomeBloc>();
  final heartBloc = injectionInstance<HeartbeatBloc>();
  final weatherBloc = injectionInstance<WeatherBloc>();
  final opacity = 1.0;
  bool showScreens = true;
  bool bottomIsShowing = false;
  String languageCode = 'pt_BR';

  @override
  void initState() {
    super.initState();
    setState(() {
      initializeDateFormatting(languageCode);
      Future.delayed(
        Duration(seconds: 6),
        () {
          bloc.controller.jumpToPage(1);
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WatchWidget(
        enableWidget: (enable, opacity) {
          setState(() {
            showScreens = enable;
            opacity = opacity;
          });
        },
        content: PageView(
          controller: bloc.controller,
          physics: NeverScrollableScrollPhysics(),
          children: [
            SplashPage(),
            AnimatedOpacity(
              opacity: opacity,
              duration: const Duration(seconds: 3),
              child: buildWatchOptions(),
            )
          ],
        ),
      ),
    );
  }

  Widget buildWatchOptions() {
    if (showScreens == false) {
      return Container();
    } else {
      return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => heartBloc,
            ),
            BlocProvider(
              create: (_) => weatherBloc,
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: "/clock",
            routes: {
              '/clock': (clockContext) =>
                  _getRouteScreen(route: '/clock', clockContext: clockContext),
              '/clockMenu': (clockContext) => _getRouteScreen(
                  route: '/clockMenu', clockContext: clockContext),
              '/heart': (clockContext) =>
                  _getRouteScreen(route: '/heart', clockContext: clockContext),
              '/weather': (clockContext) => _getRouteScreen(
                  route: '/weather', clockContext: clockContext),
              '/fitbit': (clockContext) =>
                  _getRouteScreen(route: '/fitbit', clockContext: clockContext),
            },
          ));
    }
  }

  Widget _getRouteScreen({
    required String route,
    required BuildContext clockContext,
  }) {
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
              if (bottomIsShowing == false) {
                bottomIsShowing = true;
                ScaffoldMessenger.of(clockContext).showSnackBar(SnackBar(
                    content: SizedBox(
                  width: 500,
                  height: 50,
                  child: SizedBox(
                    width: width(context) * .52,
                    child: Text(
                      "This menu is only available in physical watch",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: primaryWhite()),
                    ),
                  ),
                )));
                Future.delayed(Duration(seconds: 5), (){
                  bottomIsShowing = false;
                });
              }
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
        return FitbitPage();
      case '/heart':
        return HeartRatePage();
      default:
        return WeatherPage();
    }
  }
}
