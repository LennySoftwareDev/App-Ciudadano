// Can be generated automatically

import 'package:hive/hive.dart';

import '../../../domain/models/user/preferenceDb/user_preferences.dart';

class UserPreferencesAdapter extends TypeAdapter<UserPreferences> {
  @override
  final typeId = 0;

  @override
  UserPreferences read(BinaryReader reader) {
    return UserPreferences(reader.read());
  }

  @override
  void write(BinaryWriter writer, UserPreferences obj) {
    writer.write(obj);
  }
}
