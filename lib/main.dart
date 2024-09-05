import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ketabok/home/views/home_view.dart';
import 'package:ketabok/splash/views/splash_view.dart';
import 'package:ketabok/style/my_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ketabok',
      theme: MyTheme.darkTheme,
      darkTheme:MyTheme.darkTheme ,
      themeMode:ThemeMode.dark ,
      home:const HomeView() ,
    );
  }
}
