import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LangController extends ChangeNotifier {
  Locale locale = Locale("en");

  changeLang({required String langCode}) async {
    locale = Locale(langCode);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("lang", langCode);

    notifyListeners();
  }

  getLang() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String langCode = prefs.getString("lang") ?? "en";
    locale = Locale(langCode);
    notifyListeners();
  }
}