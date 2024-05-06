import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'widgets/homepage.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expense',
      theme: ThemeData(
        primaryColor: Colors.purple,
        appBarTheme: AppBarTheme(
          toolbarTextStyle: ThemeData.light()
              .textTheme
              .copyWith(
                titleLarge: TextStyle(
                  fontFamily: 'Quicksand',
                  color: Colors.white,
                  fontSize: 20,
                ),
              )
              .bodyMedium,
          titleTextStyle: ThemeData.light()
              .textTheme
              .copyWith(
                titleLarge: TextStyle(
                  fontFamily: 'Quicksand',
                  color: Colors.white,
                  fontSize: 20,
                ),
              )
              .titleLarge,
        ),
      ),
      home: MyHomePage(),
    );
  }
}
