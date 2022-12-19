import 'package:flutter/material.dart';
import 'package:free_to_game/core/themes.dart';
import 'package:free_to_game/providers/app_provider.dart';
import 'package:free_to_game/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({key,});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApplicationProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: MyTheme().darkTheme,
        home:  HomeScreen(),
      ),
    );
  }
}
