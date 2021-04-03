enum Gender {FEMALE, MALE, OTHER}
enum Mood {HAPPY, SAD, ANGRY, OTHER}

class Journal{
  final String entry;
  final Gender gender;
  final Set<Mood> mood;
  final bool isRecommend;

  Journal(
  {this.entry, this.gender, this.mood, this.isRecommend});
}