import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it_done/models/color_theme_data.dart';
import 'package:get_it_done/models/items_data.dart';
import 'package:provider/provider.dart';
import './screens/home_page.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await ColorThemeData().createPrefObject();
  await ItemData().createPrefObject();


  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ItemData>(
      create: (context) => ItemData(),
    ),
    ChangeNotifierProvider<ColorThemeData>(
      create: (BuildContext context) => ColorThemeData(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Provider.of<ColorThemeData>(context).loadThemeFromSharedPref();
    // Provider.of<ItemData>(context).loadItemsFromSharedPref(); //Consumer ile bu iki sınıfı aynı anda dinleyebiliyoruz

    return Consumer2<ItemData, ColorThemeData>( //2 sınıfı aynı anda dinle
        builder: (context, itemData, colorThemeData, child) {
          itemData.loadItemsFromSharedPref();
          colorThemeData.loadThemeFromSharedPref();
          return MaterialApp(
            theme: Provider
                .of<ColorThemeData>(context)
                .selectedThemeData,
            home: AnimatedSplash(),
          );
        });
  }
}

class AnimatedSplash extends StatelessWidget {
  const AnimatedSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        duration: 3,
        animationDuration: Duration(seconds: 2),
        splashIconSize: 150,
        splash: "assets/splash.png",
        curve: Curves.easeInCirc,
        nextScreen: HomePage(),
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: null,
        backgroundColor: Colors.grey,
    );
  }
}
