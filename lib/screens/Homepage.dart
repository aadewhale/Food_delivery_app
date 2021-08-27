import 'package:flutter/material.dart';
import 'package:myapp/custom_text.dart';

import 'package:myapp/screens/login.dart';
import 'package:myapp/widgets/loading.dart';
import 'package:myapp/widgets/pageindicator/effects/expanding_dots_effect.dart';
import 'package:myapp/widgets/pageindicator/smooth_page_indicator.dart';
import 'package:myapp/provider/app.dart';
import 'package:myapp/widgets/style.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final controller = PageController(viewportFraction: 0.8);

  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppProvider>(context);
    return Scaffold(
      backgroundColor: Colors.orange.shade200,
      body: app.isLoading
          ? Loading()
          : Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Image.asset(
                    "assets/images/chef.png",
                    fit: BoxFit.cover,
                    height: 500.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                        color: Colors.white),
                    height: 300,
                    width: double.infinity,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 45,
                        ),
                        Container(
                            child: SmoothPageIndicator(
                          controller: controller,
                          count: 6,
                          effect: ExpandingDotsEffect(
                            expansionFactor: 4,
                          ),
                          onDotClicked: (int index) {},
                        )),
                        Text(
                          'Quick delivery at',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 32,
                              fontWeight: FontWeight.bold),
                        ),
                        RichText(
                            text: TextSpan(
                                text: 'your ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                              TextSpan(
                                text: 'Doorstep',
                                style: TextStyle(color: Colors.red),
                              )
                            ])),
                        SizedBox(
                          height: 35,
                        ),
                        Text('Our app will make your food ordering',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            )),
                        Text('pleasant and fast',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            )),
                        SizedBox(
                          height: 35,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 20),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  child: CustomText(
                                    text: 'Skip',
                                    color: black,
                                  ),
                                  onTap: () {},
                                ),
                                MaterialButton(
                                  onPressed: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()));
                                  },
                                  color: Colors.red,
                                  child: CustomText(
                                    text: 'Next',
                                    color: white,
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  elevation: 2.0,
                                )
                              ]),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
