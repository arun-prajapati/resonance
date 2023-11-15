import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:resonance/ui/musicscreen.dart';
import 'package:resonance/ui/newscreen.dart';

class splashscreen extends StatefulWidget {
  //  splashscreen({super.key});

  @override
  State<splashscreen> createState() => splashscreenState();
}

class splashscreenState extends State<splashscreen> {
  @override
  void initState() {
    super.initState();

    new Future.delayed(
        const Duration(seconds: 4),
        () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => newscreen()),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: Stack(
        alignment: Alignment.center,
        children: [
          Lottie.asset(
            'assets/lottie/c.json',
            height: 420,
            fit: BoxFit.cover,
          ),
          Image.asset(
            "assets/images/resonancewhite.png",
            fit: BoxFit.cover,
            // height: 190,
            // width: 170,
          ),
        ],
      )),
    );
  }
}
