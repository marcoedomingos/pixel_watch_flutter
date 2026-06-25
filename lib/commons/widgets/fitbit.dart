import 'package:flutter/material.dart';
import 'package:smart_watch/commons/extension.dart';

class FitbitWidget extends StatelessWidget {
  final double size;

  const FitbitWidget({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size * 5,
      height: size * 5,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Card(
            elevation: 0,
            color: context.primaryBlack,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
            child: const Padding(
              padding: EdgeInsets.all(2.0),
              child: CircularProgressIndicator(
                backgroundColor: Colors.white10,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.transparent),
              ),
            ),
          ),
          Positioned(
            top: 10,
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
              color: context.primaryBlack,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Icon(
                  Icons.fitbit,
                  color: const Color(0xfffffdd0),
                  size: size * 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
