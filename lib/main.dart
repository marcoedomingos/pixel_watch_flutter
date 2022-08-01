import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_watch/features/home/presentation/pages/home_page.dart';
import 'core/injection_container/injection_container.dart' as injection;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  await injection.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pixel Watch',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
