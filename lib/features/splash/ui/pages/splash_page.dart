import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smart_watch/commons/extension.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: context.width * .72,
          height: context.width * .72,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: context.width * .72,
                height: context.width * .72,
                color: context.primaryBlack,
              ),
              CachedNetworkImage(
                imageUrl: "https://cdn.dribbble.com/users/2261149/screenshots/5404967/media/05ec2ecd82b69728b6eb4fa7c2b565cd.gif",
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
