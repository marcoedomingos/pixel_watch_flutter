import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_watch/features/home/logic/home_bloc.dart';
import 'package:smart_watch/features/home/ui/widgets/watch_router.dart';
import 'package:smart_watch/features/splash/ui/pages/splash_page.dart';

class WatchScreen extends StatelessWidget {
  final bool embedded;

  const WatchScreen({Key? key, required this.embedded}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final watchRouter = state.showScreens ? const WatchRouter() : const SizedBox.shrink();

        if (embedded) {
          return watchRouter;
        }

        return PageView(
          controller: context.read<HomeBloc>().controller,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const SplashPage(),
            AnimatedOpacity(
              opacity: state.contentOpacity,
              duration: const Duration(seconds: 3),
              child: watchRouter,
            ),
          ],
        );
      },
    );
  }
}
