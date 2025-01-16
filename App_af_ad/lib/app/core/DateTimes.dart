import 'package:intl/intl.dart';

class DateTimes {
  static int today() {
    var d = new DateTime.now();
    return int.parse(d.year.toString() + formatInt(d.month) + formatInt(d.day));
  }

  static int now() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  static String formatInt(int date) {
    String _value = date >= 10 ? date.toString() : ("0" + date.toString());
    return _value;
  }

  static String dateToString({int datetime, int type = 1}) {
    String year = datetime.toString().substring(0, 4);
    String month = datetime.toString().substring(4, 6);
    String day = datetime.toString().substring(6, 8);
    if (type == 1)
      return day.toString() + "/" + month.toString() + "/" + year.toString();
    else
      return year.toString() + "-" + month.toString() + "-" + day.toString();
  }

  static String dateIntToString({int date, int type = 1}) {
    String year = date.toString().substring(0, 4);
    String month = date.toString().substring(4, 6);
    String day = date.toString().substring(6, 8);
    if (type == 1) {
      return day.toString() + "-" + month.toString() + "-" + year.toString();
    } else {
      return day.toString() + "/" + month.toString() + "/" + year.toString();
    }
  }

  static int dateTimeToInt(DateTime dateTime) {
    return int.parse(dateTime.year.toString() +
        formatInt(dateTime.month) +
        formatInt(dateTime.day));
  }

  static int getDateBeforeAboutDay(int dateInt, int numOfDay) {
    int year, month, day;
    try {
      year = int.tryParse(dateInt.toString().substring(0, 4));
      month = int.tryParse(dateInt.toString().substring(4, 6));
      day = int.tryParse(dateInt.toString().substring(6, 8));
    } catch (ex) {
      return null;
    }
    DateTime date = new DateTime(year, month, day);
    date = date.subtract(new Duration(days: numOfDay));
    return int.parse(
        date.year.toString() + formatInt(date.month) + formatInt(date.day));
  }

  static String dayHourMinuteSecondFormatted(Duration duration) {
    duration.toString();
    return [
      duration.inHours.remainder(24),
      duration.inMinutes.remainder(60),
      duration.inSeconds.remainder(60)
    ].map((seg) {
      return seg.toString().padLeft(2, '0');
    }).join(':');
  }

  static int numOfWeeks(int year) {
    DateTime dec28 = DateTime(year, 12, 28);
    int dayOfDec28 = int.parse(DateFormat("D").format(dec28));
    return ((dayOfDec28 - dec28.weekday + 10) / 7).floor();
  }

  static int weekNumber(DateTime date) {
    int dayOfYear = int.parse(DateFormat("D").format(date));
    int woy = ((dayOfYear - date.weekday + 10) / 7).floor();
    if (woy < 1) {
      woy = numOfWeeks(date.year - 1);
    } else if (woy > numOfWeeks(date.year)) {
      woy = 1;
    }
    return woy;
  }
}
