import 'package:intl/intl.dart';

DateTime dateOnly(DateTime date) {
  return DateTime(date.year, date.month, date.day);
}

String howMuchHasPassed(DateTime date) {
  var dateTreated = dateOnly(date);
  var todayTreated = dateOnly(DateTime.now());

  var difference = todayTreated.difference(dateTreated).inDays;

  if (dateTreated == todayTreated)
    return DateFormat("HH:mm").format(date);
  else if (dateTreated.add(Duration(days: 1)) == todayTreated)
    return "Yesterday";
  else if (dateTreated.isAfter(todayTreated.subtract(Duration(days: 31))))
    return "$difference days ago";
  else if (dateTreated.isAfter(todayTreated.subtract(Duration(days: 365))))
    return "${(difference / 31).floor()} months ago";
  else if (dateTreated.isBefore(todayTreated.subtract(Duration(days: 365))))
    return "${(difference / 365).floor()} years ago";
  return "Long ago";
}
