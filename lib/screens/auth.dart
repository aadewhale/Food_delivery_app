import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/widgets/pageindicator/effects/expanding_dots_effect.dart';
import 'package:myapp/widgets/pageindicator/smooth_page_indicator.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final controller = PageController(viewportFraction: 0.8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Center(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 16),
              SizedBox(
                height: 300,
                child: PageView(
                  controller: controller,
                  children: List.generate(
                      6,
                      (_) => Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            child: Container(height: 280),
                          )),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 8),
                child: Text("Worm"),
              ),
              Container(
                child: SmoothPageIndicator(
                  controller: controller,
                  count: 6,
                  onDotClicked: (int index) {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 8),
                child: Text("Expanding Dots "),
              ),
              Container(
                child: SmoothPageIndicator(
                  controller: controller,
                  count: 6,
                  effect: ExpandingDotsEffect(
                    expansionFactor: 4,
                  ),
                  onDotClicked: (int index) {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
