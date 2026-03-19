import 'dart:io';

import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todolistapp/common/common_theme.dart';
import 'package:todolistapp/firebase_options.dart';
import 'package:todolistapp/views/splash_screen/splash.dart';

void main() async{
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  Directory document = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(document.path);
  await Hive.openBox("tasks_box");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // ignore: deprecated_member_use
  CloudinaryContext.cloudinary = Cloudinary.fromCloudName(cloudName: dotenv.env['CLOUD_NAME']!);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812), //default size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'To do list',
          theme: CommonTheme.lightTheme,
          darkTheme: CommonTheme.darkTheme,
          home: Splash(),
        );
      },
    );
  }
}