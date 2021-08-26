import 'package:flutter/material.dart';
import 'package:myapp/custom_text.dart';
import 'package:myapp/widgets/loading.dart';
import 'package:myapp/widgets/style.dart';


class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomText(text: "Loading"),
            Loading(),
          ],
        ));
  }
}
