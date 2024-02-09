
import 'package:hive/hive.dart';

import '../../../domain/models/user/preferenceDb/user_preferences.dart';

class UserDBConnection {
  final Box _userPreferencesBox;

  UserDBConnection(this._userPreferencesBox);

  void addUserPreferences(UserPreferences userPreferences) {
    _userPreferencesBox.add(userPreferences);
  }

  UserPreferences? getUserPreferences() {
    UserPreferences? userPreferences;

    if (_userPreferencesBox.isNotEmpty) {
      userPreferences = _userPreferencesBox.get(0);
    }
    return userPreferences;
  }
}
