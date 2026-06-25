import 'package:flutter/material.dart';
import 'package:smart_watch/commons/extension.dart';

class WatchBaseLayout extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;

  const WatchBaseLayout({
    Key? key,
    required this.child,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final watchSize = context.width * 0.72;
    
    return Scaffold(
      backgroundColor: backgroundColor ?? context.primaryBlack,
      body: Center(
        child: SizedBox(
          width: watchSize,
          height: watchSize,
          child: child,
        ),
      ),
    );
  }
}
