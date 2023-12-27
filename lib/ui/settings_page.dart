import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_mana/provider/preferences_provider.dart';
import 'package:resto_mana/provider/scheduling_provider.dart';
import 'package:resto_mana/widgets/custom_dialog.dart';
import 'package:resto_mana/widgets/platform_widget.dart';

class SettingsPage extends StatelessWidget {
  static const String settingsTitle = 'Settings';

  const SettingsPage({super.key});

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(settingsTitle),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(settingsTitle),
      ),
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<PreferencesProvider>(builder: (context, provider, child) {
      return ListView(
        children: [
          Material(
            child: ListTile(
              title: const Text('Dark Theme'),
              trailing: Switch.adaptive(
                value: provider.isDarkTheme,
                onChanged: (value) => provider.enableDarkTheme(value),
              ),
            ),
          ),
          Material(
            child: ListTile(
              title: const Text('Scheduling Recommendation'),
              trailing: Consumer<SchedulingProvider>(
                builder: (context, scheduled, _) {
                  return Switch.adaptive(
                    value: provider.isDailyRecommmendationActive,
                    onChanged: (value) async {
                      if (Platform.isIOS) {
                        customDialog(context);
                      } else {
                        provider.enableDailyRecommendation(value);
                        scheduled.scheduledResto(value);
                      }
                    },
                  );
                },
              ),
            ),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
