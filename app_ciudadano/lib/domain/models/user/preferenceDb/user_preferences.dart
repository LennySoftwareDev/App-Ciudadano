import 'package:app_ciudadano/utils/constants.dart';
import 'package:hive/hive.dart';
part 'user_preferences.g.dart';

@HiveType(typeId: TABLE_PREFERENCES_USER)
class UserPreferences {
  @HiveField(0)
  bool introWatched;

  UserPreferences(
    this.introWatched,
  );

}
