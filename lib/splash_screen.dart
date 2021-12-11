import 'dart:async';
import 'dart:ui';

import 'package:clay_containers/constants.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:whatsub/state_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoad = false;

  @override
  void initState() {
    super.initState();

    /// [This one is for dummy purpose only. To debug within screen go to state-wrapper-screen]
    Timer(Duration(milliseconds: 2000), () {
      isLoad = true;
      setState(() {});
    });
  }

  Future<SharedPreferences> _getPrefs() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: FutureBuilder(
        future: _getPrefs(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData || !isLoad)
            return Container(
              constraints: BoxConstraints.expand(),
              color: Color.fromRGBO(27, 27, 27, 1.0),
              child: Column(
                children: [
                  Spacer(),
                  Container(
                      height: screenHeight * 0.25,
                      width: screenHeight * 0.25,
                      child: ClayContainer(
                          color: Colors.grey[900],
                          curveType: CurveType.none,
                          parentColor: Colors.grey[900],
                          spread: 4,
                          depth: 20,
                          borderRadius: 200,
                          // style: NeumorphicStyle(
                          //     intensity: .4,
                          //     color: Colors.grey[900],
                          //     depth: 10,
                          //     boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(200))
                          // ),

                          child: Container(
                              padding: const EdgeInsets.all(20),
                              child: SvgPicture.asset(
                                  'assets/images/dogespace_circle.svg',
                                  semanticsLabel: 'Doge')
                              // Image.asset(
                              //   'assets/images/dogespace_circle.svg',
                              // ),
                              ))),
                  Spacer(),
                  Text(
                    "Welcome to DogeSpace",
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                    // textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Text(
                    "developed by fachas of IIT Madras",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    // textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  )
                ],
              ),
            );
          return StateWrapperScreen(
            preferences: snapshot.data,
          );
        },
      ),
    );
  }
}
