import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/ui/homepage.dart';
import 'package:restaurant_app/ui/search_screen.dart';
import 'package:restaurant_app/ui/splash_screen.dart';
import 'package:restaurant_app/common/styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resto Mana?',
      theme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: primaryColor,
              onPrimary: Colors.black,
              secondary: secondaryColor,
            ),
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: restaurantTextTheme,
        appBarTheme: const AppBarTheme(elevation: 0),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: secondaryColor,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(0),
              ),
            ),
          ),
        ),
        useMaterial3: true,
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => const SplashScreen(),
        RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
            restaurantId: ModalRoute.of(context)?.settings.arguments as String),
        SearchScreen.routeName: (context) => const SearchScreen(),
      },
    );
  }
}
