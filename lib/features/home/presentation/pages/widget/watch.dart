import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smart_watch/commons/clipPath/bracelet.dart';
import 'package:smart_watch/commons/colors.dart';
import 'package:smart_watch/commons/size/size.dart';

class WatchWidget extends StatefulWidget {
  final Widget content;
  final Function(bool, double) enableWidget;
  const WatchWidget({Key? key, required this.content, required this.enableWidget,}) : super(key: key);

  @override
  State<WatchWidget> createState() => _WatchWidgetState();
}

class _WatchWidgetState extends State<WatchWidget> {
  double size = 2;
  double opacity = 1.0;
  Offset offset = Offset.zero;

  void animateClickButton() {
    setState(() {
      size = 0;
      Future.delayed(Duration(milliseconds: 50), () {
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
      width: width(context),
      height: height(context),
      child: Stack(
        alignment: Alignment.center,
        children: [
          getBracelet("top"),
          getBracelet("bottom"),
          SizedBox(
            width: width(context)*.9,
            height: width(context)*.85,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: width(context)*.72,
                  height: width(context)*.72,
                  decoration: BoxDecoration(
                    color: primaryBlack(),
                    gradient: RadialGradient(
                      colors: [
                        secondaryBlack(),
                        primaryBlack(),
                        secondaryBlack(),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(180),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: width(context)*.7,
                        height: width(context)*.7,
                        decoration: BoxDecoration(
                          color: primaryBlack(),
                          borderRadius: BorderRadius.circular(180),
                        ),
                        child: SizedBox(
                          width: width(context)*.72,
                          child: Stack(
                            children: [
                              Container(
                                width: width(context)*.72,
                                height: width(context)*.72,
                                decoration: BoxDecoration(
                                  color: primaryBlack(),
                                  borderRadius: BorderRadius.circular(180),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(180),
                                  child: widget.content,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    animateClickButton();
                  },
                  child: SizedBox(
                    width: 35,
                    height: 50,
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        AnimatedContainer(
                          width: 12.7 + size,
                          height: 20,
                          duration: Duration(milliseconds: 50),
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
                            borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(5)),
                          ),
                        ),
                        AnimatedPositioned(
                          left: 1 + size,
                          duration: Duration(milliseconds: 50),
                          child: Container(
                            width: 10,
                            height: 30,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  primaryBlack(),
                                  Color(0xdd696969),
                                  primaryBlack(),
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

  Widget getBracelet(String direction){
    switch(direction){
      case "top":
        return Positioned(
          top: height(context)*.20,
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
                      secondaryBlack(),
                      secondaryBlack(),
                      primaryBlack(),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.only(topLeft: Radius.elliptical(46, 90),
                    topRight: Radius.elliptical(42, 80),
                  ),
                ),
              ),
            ),
          ),
        );

      default:
        return Positioned(
          bottom: height(context)*.20,
          child: RotatedBox(
            quarterTurns: 2,
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
                        secondaryBlack(),
                        secondaryBlack(),
                        primaryBlack(),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.only(topLeft: Radius.elliptical(46, 90),
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
}
