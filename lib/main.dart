import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_app_assignment/presentations/custom/image_post.dart';
import 'package:photo_app_assignment/presentations/homepage.dart';
import 'presentations/splash_page.dart';
import 'package:photo_app_assignment/utils/string_values.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(ImagePostAdapter());
  await Hive.openBox<ImagePost>(StringValue.postsWord);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  double defaultHeight = 812;
  double defaultWidth = 375;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(defaultWidth, defaultHeight),
      allowFontScaling: true,
      child: MaterialApp(
        title: StringValue.appTitle,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.grey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: SplashPage.routeName,
        routes: {
          SplashPage.routeName: (BuildContext context) => SplashPage(),
          HomePage.routeName: (BuildContext context) => HomePage(),
        },
      ),
    );
  }
}