import 'package:animation_app/providerPage.dart';
import 'package:animation_app/screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    // systemNavigationBarColor: Colors.blue, // navigation bar color
    statusBarColor: Color(0xff97D558), // status bar color
  ));

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_)=> ShoppingCart(),
        )
      ],
      child: MyApp()
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen()
    );
  }
}
