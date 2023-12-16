import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

// Function to load and parse JSON data
Future<String> loadJsonData(String assetName) async {
  // Load the JSON file from the assets
  String jsonString = await rootBundle.loadString('assets/$assetName');

  // Parse the JSON data
  return jsonString;
}

fetchData() async {
  String jsonData = await loadJsonData('local_restaurant.json');
  List<dynamic> data = json.decode(jsonData)['restaurants'];

  // Now you can use the data as needed
  return data;
}
