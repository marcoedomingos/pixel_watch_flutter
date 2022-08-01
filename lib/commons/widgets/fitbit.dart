import 'package:flutter/material.dart';
import 'package:smart_watch/commons/colors.dart';

class FitbitWidget extends StatefulWidget {
  final double size;

  const FitbitWidget({Key? key, required this.size}) : super(key: key);

  @override
  State<FitbitWidget> createState() => _FitbitWidgetState();
}

class _FitbitWidgetState extends State<FitbitWidget> {
  double size = 50;

  @override
  void initState() {
    super.initState();
    setState(() {
      size = widget.size;
    });
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size*5,
      height: widget.size*5,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Card(
            elevation: 0,
            color: primaryBlack(),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80)),
              color: primaryBlack(),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Icon(
                  Icons.fitbit,
                  color: Color(0xfffffdd0),
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
