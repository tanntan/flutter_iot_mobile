// lib/app_config.dart
import 'dart:convert';

class AppConfig {
  final String? apiUrl;

  AppConfig({this.apiUrl});

  static Future<AppConfig> forEnvironment(String env) async {
    // set default to dev if nothing was passed
    env = env;

    // load the json file
    final contents = 'assets/config/$env.json';

    // decode our json
    final json = jsonDecode(contents);

    // convert our JSON into an instance of our AppConfig class
    return AppConfig(apiUrl: json['apiUrl']);
  }
}
