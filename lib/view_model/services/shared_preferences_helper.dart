import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String PROFILE_COMPLETED_KEY = 'profile_completed';
  static const String FITNESS_COMPLETED_KEY = 'fitness_completed';
  static const String HEALTH_COMPLETED_KEY = 'health_completed';

  static Future<bool> isProfileCompleted() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(PROFILE_COMPLETED_KEY) ?? false;
  }

  static Future<void> setProfileCompleted(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(PROFILE_COMPLETED_KEY, value); // Fix: use the passed value
  }

  static Future<bool> isFitnessCompleted() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(FITNESS_COMPLETED_KEY) ?? false;
  }

  static Future<void> setFitnessCompleted(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(FITNESS_COMPLETED_KEY, value); // Fix: use the passed value
  }

  static Future<bool> isHealthCompleted() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(HEALTH_COMPLETED_KEY) ?? false;
  }

  static Future<void> setHealthCompleted(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(HEALTH_COMPLETED_KEY, value); // Fix: use the passed value
  }
}
