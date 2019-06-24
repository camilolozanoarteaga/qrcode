import 'package:flutter/material.dart';
import 'package:qrcodeapp/src/pages/home_page.dart';
import 'package:qrcodeapp/src/pages/mapa_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'qr Reader',
      initialRoute: 'home',
      routes: {
        'home' : (BuildContext context) => HomePate(),
        'mapa' : (BuildContext context) => MapaPage(),
      },
      theme: ThemeData(
        primaryColor: Colors.deepPurple
      ),
    );
  }
}