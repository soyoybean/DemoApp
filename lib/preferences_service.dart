import 'package:shared_preferences/shared_preferences.dart';

import 'models.dart';

class PreferencesService{
  Future saveJournal(Journal journal) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setString('entry', journal.entry);
    await preferences.setBool('isRecommend', journal.isRecommend);
    await preferences.setInt('gender', journal.gender.index);
    await preferences.setStringList('mood', journal.mood.map((lang) => lang.index.toString()).toList());

    print('Saved Settings');
  }

  Future<Journal> getJournal() async {
    final preferences = await SharedPreferences.getInstance();

    final entry = preferences.getString('entry') ?? "no entry";
    final isRecommend = preferences.getBool('isRecommend') ?? false;
    final gender = Gender.values[preferences.getInt('gender') ?? 0];
    final moodIndices = preferences.getStringList('mood') ?? [];
    final mood = moodIndices.map((stringIndex) => Mood.values[int.parse(stringIndex)]).toSet();

    return Journal(
      entry: entry,
      gender: gender,
      mood: mood,
      isRecommend: isRecommend
    );
  }
}