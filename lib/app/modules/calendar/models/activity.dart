
enum ActivityCardType { regular, strengthTraining }

class Activity {
  final String month;
  final int day;
  final String title;
  final String subtitle;
  final String time;
  final bool isSunny;
  final ActivityCardType cardType;
  final String? cardDescription;
  final String? cardIconEmoji;

  const Activity({
    required this.month,
    required this.day,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.isSunny,
    this.cardType = ActivityCardType.regular,
    this.cardDescription,
    this.cardIconEmoji,
  });
}