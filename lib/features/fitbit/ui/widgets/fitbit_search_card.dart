import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:smart_watch/commons/extension.dart';

class FitbitSearchCard extends StatelessWidget {
  const FitbitSearchCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      direction: FlipDirection.HORIZONTAL,
      speed: 300,
      front: Card(
        color: context.primaryGrey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
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
        color: context.primaryRed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 50,
            height: 50,
            child: Image.asset(
              "assets/images/smartphone.png",
              color: context.primaryWhite,
            ),
          ),
        ),
      ),
    );
  }
}
