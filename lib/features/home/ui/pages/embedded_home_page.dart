import 'package:flutter/material.dart';
import 'package:smart_watch/commons/size/viewport_scope.dart';
import 'package:smart_watch/features/home/ui/pages/home_page.dart';

class EmbeddedHomePage extends StatelessWidget {
  const EmbeddedHomePage({super.key});

  static const designSize = Size(375, 812);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: FittedBox(
            fit: BoxFit.contain,
            child: ViewportScope(
              size: designSize,
              child: SizedBox(
                width: designSize.width,
                height: designSize.height,
                child: MediaQuery(
                  data: const MediaQueryData(
                    size: designSize,
                    devicePixelRatio: 1.0,
                    textScaler: TextScaler.noScaling,
                  ),
                  child: const HomePage(embedded: true),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
