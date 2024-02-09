

import '../../../domain/models/user/preferenceDb/user_preferences.dart';
import '../db/user_db_connection.dart';

class UserRepositoryDB {
  final UserDBConnection _userDBConnection;

  UserRepositoryDB(
    this._userDBConnection,
  );

  void addUserPreferencesToDB(UserPreferences userPreferences) {
    _userDBConnection.addUserPreferences(userPreferences);
  }

  bool checkWalkthroughWatched() {
    bool checkWalkthroughWatched = true;
    UserPreferences? userPreferences = _userDBConnection.getUserPreferences();
    if (userPreferences != null) {
      checkWalkthroughWatched = userPreferences.introWatched;
    } else {
      checkWalkthroughWatched = false;
    }

    return checkWalkthroughWatched;
  }
}
