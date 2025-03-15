import 'package:shared_preferences/shared_preferences.dart';

class ChangeModalService {
  static const String _modalKey = 'selected_modal';

  static Future<void> saveModalState(String modalName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_modalKey, modalName);
  }

  static Future<String?> getModalState() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_modalKey);
  }
}
