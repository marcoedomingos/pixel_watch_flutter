import 'package:flutter/material.dart';
import 'package:smart_watch/commons/clipPath/bracelet.dart';
import 'package:smart_watch/commons/extension.dart';

class WatchFrame extends StatefulWidget {
  final Widget content;
  final Function(bool, double) enableWidget;
  const WatchFrame({Key? key, required this.content, required this.enableWidget,}) : super(key: key);

  @override
  State<WatchFrame> createState() => _WatchFrameState();
}

class _WatchFrameState extends State<WatchFrame> {
  double size = 2;
  double opacity = 1.0;

  void animateClickButton() {
    setState(() {
      size = 0;
      Future.delayed(const Duration(milliseconds: 50), () {
        setState(() {
          size = 2;
        });
      });
      handleOnAndOffScreen();
    });
  }

  void handleOnAndOffScreen() {
    setState(() {
      if (opacity == 0.0) {
        opacity = 1.0;
      } else {
        opacity = 0.0;
      }
      widget.enableWidget(opacity == 1.0, opacity);
    });
  }

  @override
  Widget build(BuildContext context) {
    final watchDimension = context.minSide;

    return Container(
      width: context.width,
      height: context.height,
      color: context.primaryBlack,
      child: Center(
        child: SizedBox(
          width: context.width,
          height: context.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              _getBracelet("top"),
              _getBracelet("bottom"),
              SizedBox(
                width: watchDimension * .9,
                height: watchDimension * .85,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: watchDimension * .72,
                      height: watchDimension * .72,
                      decoration: BoxDecoration(
                        color: context.primaryBlack,
                        gradient: RadialGradient(
                          colors: [
                            context.secondaryBlack,
                            context.primaryBlack,
                            context.secondaryBlack,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(watchDimension),
                      ),
                      child: Center(
                        child: Container(
                          width: watchDimension * .7,
                          height: watchDimension * .7,
                          decoration: BoxDecoration(
                            color: context.primaryBlack,
                            borderRadius: BorderRadius.circular(watchDimension),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(watchDimension),
                            child: widget.content,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: animateClickButton,
                      child: SizedBox(
                        width: watchDimension * .08,
                        height: watchDimension * .12,
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            AnimatedContainer(
                              width: (watchDimension * .03) + size,
                              height: watchDimension * .05,
                              duration: const Duration(milliseconds: 50),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.grey.shade600,
                                    Colors.black87,
                                    Colors.grey.shade600,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                borderRadius: const BorderRadius.horizontal(
                                    right: Radius.circular(5)),
                              ),
                            ),
                            AnimatedPositioned(
                              left: 1 + size,
                              duration: const Duration(milliseconds: 50),
                              child: Container(
                                width: watchDimension * .025,
                                height: watchDimension * .075,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      context.primaryBlack,
                                      const Color(0xdd696969),
                                      context.primaryBlack,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getBracelet(String direction) {
    final isTop = direction == "top";
    final watchDimension = context.minSide;

    return Positioned(
      top: isTop ? (context.height / 2) - (watchDimension * .45) : null,
      bottom: !isTop ? (context.height / 2) - (watchDimension * .45) : null,
      child: RotatedBox(
        quarterTurns: isTop ? 0 : 2,
        child: SizedBox(
          width: watchDimension * .5,
          height: watchDimension * .35,
          child: ClipPath(
            clipper: Bracelet(),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.grey.shade700,
                    context.secondaryBlack,
                    context.secondaryBlack,
                    context.primaryBlack,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.elliptical(46, 90),
                  topRight: Radius.elliptical(42, 80),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
