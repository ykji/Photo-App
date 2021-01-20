import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_app_assignment/presentations/homepage.dart';
import 'package:photo_app_assignment/utils/string_values.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = "SplashPage";
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      timerFunction();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.grey[100], Colors.grey[600]]),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                StringValue.appTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(34),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: ScreenUtil().setHeight(30)),
              CircularProgressIndicator(
                  valueColor:
                      new AlwaysStoppedAnimation<Color>(Colors.grey[700]))
            ],
          ),
        ),
      ),
    );
  }

  timerFunction() {
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, HomePage.routeName);
      // Navigator.push(
      //     context, CupertinoPageRoute(builder: (context) => IntroPage()));
    });
  }
}
