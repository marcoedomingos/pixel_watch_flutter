import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_watch/commons/extension.dart';
import 'package:smart_watch/commons/size/viewport_scope.dart';
import 'package:smart_watch/core/injection_container/injection_container.dart';
import 'package:smart_watch/features/clock/logic/clock_bloc.dart';
import 'package:smart_watch/features/heart_rate/logic/heartbeat_bloc.dart';
import 'package:smart_watch/features/home/logic/home_bloc.dart';
import 'package:smart_watch/features/weather/logic/weather_bloc.dart';
import 'package:smart_watch/features/home/ui/app_router.dart';

class WatchRouter extends StatelessWidget {
  const WatchRouter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: injectionInstance<ClockBloc>()..add(StartClock())),
        BlocProvider.value(value: injectionInstance<HeartbeatBloc>()),
        BlocProvider.value(value: injectionInstance<WeatherBloc>()),
      ],
      child: Builder(
        builder: (navContext) {
          Widget navigator = Navigator(
            initialRoute: '/clock',
            onGenerateRoute: (settings) => AppRouter.generateRoute(
              settings: settings,
              clockContext: navContext,
              onShowWarning: () => context.read<HomeBloc>().add(ShowBottomWarning()),
            ),
          );

          final viewport = ViewportScope.maybeOf(navContext);
          if (viewport != null) {
            navigator = MediaQuery(
              data: MediaQuery.of(navContext).copyWith(
                size: viewport,
                textScaler: TextScaler.noScaling,
              ),
              child: navigator,
            );
          }

          return Material(
            color: Colors.transparent,
            child: ScaffoldMessenger(
              child: BlocListener<HomeBloc, HomeState>(
                listenWhen: (previous, current) =>
                    previous.bottomIsShowing != current.bottomIsShowing &&
                    current.bottomIsShowing,
                listener: (context, state) {
                  _showWarningSnackBar(context);
                },
                child: navigator,
              ),
            ),
          );
        },
      ),
    );
  }

  void _showWarningSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(
            "This menu is only available in physical watch",
            textAlign: TextAlign.center,
            style: TextStyle(color: context.primaryWhite),
          ),
        ),
      ),
    );
  }
}
