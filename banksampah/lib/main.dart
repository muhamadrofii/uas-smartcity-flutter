import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'api_helper.dart';
import 'demo_mw_tab_bar_screen3.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final ApiHelper apiHelper = ApiHelper();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login & Registration Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<String?>(
        future: apiHelper.getToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data != null) {
            return DemoMWTabBarScreen3();
          } else {
            return HomeScreen();
          }
        },
      ),
    );
  }
}
