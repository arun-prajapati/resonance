import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:resonance/ui/newscreen.dart';
import 'package:resonance/ui/splash/splashscreen.dart';
import 'package:resonance/volume/pref.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await MobileAds.instance.initialize();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      home: newscreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
