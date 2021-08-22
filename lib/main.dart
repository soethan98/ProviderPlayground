import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_playgroud/counter.dart';
import 'package:provider_playgroud/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
       /*Wrap with provider type we want
       home: ChangeNotifierProvider<Counter>(
           create: (_) => Counter(),
           child: MyHomePage(title: 'Flutter Demo Home Page')), */

      //For single value,we can use valuenotifier rather than changenotifier extend class
      home: ChangeNotifierProvider<ValueNotifier<int>>(
          create: (_) => ValueNotifier<int>(0),
          child: HomePage(title: 'Provider Playground')),
    );
  }
}
