import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smart_watch/commons/colors.dart';
import 'package:smart_watch/commons/size/size.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: width(context)*.72,
        height: width(context)*.72,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: width(context)*.72,
              height: width(context)*.72,
              color: primaryBlack(),
            ),
            CachedNetworkImage(
              imageUrl: "https://cdn.dribbble.com/users/2261149/screenshots/5404967/media/05ec2ecd82b69728b6eb4fa7c2b565cd.gif",
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
