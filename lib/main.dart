import 'dart:async';

import 'package:capital/src/provider/main_provider.dart';
import 'package:capital/src/theme/colors.dart';
import 'package:capital/src/ui/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(  MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => MainProvider(),
    )
  ], child: const MyApp()),);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: false,
      stream: ThemeStream.setTheme.stream,
        builder: (BuildContext context,AsyncSnapshot<dynamic> snapshot){
      return MaterialApp(
          title: 'Flutter Demo',
          theme: snapshot.data ? AppTheme.dark() : AppTheme.light(),
          home: HomeScreen()
      );
    });
  }
}
class ThemeStream {
  static StreamController<bool> setTheme = StreamController();
}

