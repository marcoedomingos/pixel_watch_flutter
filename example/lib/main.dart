import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_watch/smart_watch.dart' as watch;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  await watch.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Pixel Watch Example',
      debugShowCheckedModeBanner: false,
      home: watch.HomePage(),
    );
  }
}
