import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:resto_mana/common/navigation.dart';
import 'package:resto_mana/data/api/api_service.dart';
import 'package:resto_mana/data/preferences/preferences_helper.dart';
import 'package:resto_mana/provider/preferences_provider.dart';
import 'package:resto_mana/provider/restaurants_provider.dart';
import 'package:resto_mana/provider/scheduling_provider.dart';
import 'package:resto_mana/ui/detail_page.dart';
import 'package:resto_mana/ui/favorite_restaurant.dart';
import 'package:resto_mana/ui/homepage.dart';
import 'package:resto_mana/ui/search_screen.dart';
import 'package:resto_mana/ui/splash_screen.dart';
import 'package:resto_mana/utils/background_service.dart';
import 'package:resto_mana/utils/notification_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();
  service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RestaurantsProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (context) => SchedulingProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
                sharedPreferences: SharedPreferences.getInstance()),
          ),
        )
      ],
      child: Consumer<PreferencesProvider>(
        builder:
            (BuildContext context, PreferencesProvider value, Widget? child) {
          return MaterialApp(
            title: 'Resto Mana?',
            theme: value.themeData,
            initialRoute: HomePage.routeName,
            routes: {
              HomePage.routeName: (context) => const SplashScreen(),
              RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
                  restaurantId:
                      ModalRoute.of(context)?.settings.arguments as String),
              SearchScreen.routeName: (context) => const SearchScreen(),
              FavoriteRestaurantPage.routeName: (context) =>
                  const FavoriteRestaurantPage(),
            },
            builder: (context, child) {
              return CupertinoTheme(
                  data: CupertinoThemeData(
                      brightness: value.isDarkTheme
                          ? Brightness.dark
                          : Brightness.light),
                  child: Material(child: child));
            },
            navigatorKey: navigatorKey,
          );
        },
      ),
    );
  }
}
