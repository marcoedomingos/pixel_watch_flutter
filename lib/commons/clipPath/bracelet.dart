import 'package:flutter/material.dart';

class Bracelet extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path = Path();

    path.moveTo(size.width*0.12,0); // Point 1 - TopLeft
    path.quadraticBezierTo(size.width*0.1, size.height*1, 0, size.height); // Point 2 - Left
    path.quadraticBezierTo(size.width*0.5, size.height -78, size.width, size.height); // Point 3 - bottom
    path.quadraticBezierTo(size.width*0.92, size.height*1, size.width*0.87, 0);  // Point 4 - Right

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}