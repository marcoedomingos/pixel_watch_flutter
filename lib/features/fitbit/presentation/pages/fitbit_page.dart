import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:smart_watch/commons/colors.dart';
import 'package:smart_watch/commons/size/size.dart';
import 'package:smart_watch/commons/widgets/heart.dart';
import 'package:smart_watch/commons/widgets/pointers.dart';

class FitbitPage extends StatefulWidget {
  const FitbitPage({Key? key}) : super(key: key);

  @override
  State<FitbitPage> createState() => _FitbitPageState();
}

class _FitbitPageState extends State<FitbitPage> {
  FlipCardController controller = FlipCardController();

  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBlack(),
      body: GestureDetector(
        onPanEnd: (details) {
          Navigator.of(context).pop();
        },
        child: SizedBox(
          width: width(context) * .72,
          height: width(context) * .72,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: width(context) * .52,
                child: Text(
                  "FitBit menu only available in physical watch",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: primaryWhite()),
                ),
              ),
              SizedBox(height: height(context) * .02),
              FlipCard(
                key: cardKey,
                direction: FlipDirection.HORIZONTAL,
                // default
                speed: 300,
                front: Card(
                  color: primaryGrey(),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.asset("assets/images/search.png"),
                    ),
                  ),
                ),
                back: Card(
                  color: primaryRed(),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.asset(
                        "assets/images/smartphone.png",
                        color: primaryWhite(),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
