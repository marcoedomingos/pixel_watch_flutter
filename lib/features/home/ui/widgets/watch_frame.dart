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
    return SizedBox(
      width: context.width,
      height: context.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _getBracelet("top"),
          _getBracelet("bottom"),
          SizedBox(
            width: context.width * .9,
            height: context.width * .85,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: context.width * .72,
                  height: context.width * .72,
                  decoration: BoxDecoration(
                    color: context.primaryBlack,
                    gradient: RadialGradient(
                      colors: [
                        context.secondaryBlack,
                        context.primaryBlack,
                        context.secondaryBlack,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(180),
                  ),
                  child: Center(
                    child: Container(
                      width: context.width * .7,
                      height: context.width * .7,
                      decoration: BoxDecoration(
                        color: context.primaryBlack,
                        borderRadius: BorderRadius.circular(180),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(180),
                        child: widget.content,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: animateClickButton,
                  child: SizedBox(
                    width: 35,
                    height: 50,
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        AnimatedContainer(
                          width: 12.7 + size,
                          height: 20,
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
                            width: 10,
                            height: 30,
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
    );
  }

  Widget _getBracelet(String direction) {
    final isTop = direction == "top";
    return Positioned(
      top: isTop ? context.height * .20 : null,
      bottom: !isTop ? context.height * .20 : null,
      child: RotatedBox(
        quarterTurns: isTop ? 0 : 2,
        child: SizedBox(
          width: 200,
          height: 150,
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
