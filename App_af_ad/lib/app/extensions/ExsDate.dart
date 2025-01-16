import 'package:intl/intl.dart';
import 'package:syngentaaudit/app/core/DateTimes.dart';

extension ExsDate on DateTime {
  int now() => this.millisecondsSinceEpoch;
  int toDay() => int.parse(this.year.toString() +
      DateTimes.formatInt(this.month) +
      DateTimes.formatInt(this.day));
  int toInt(DateTime date) => int.parse(date.year.toString() +
      DateTimes.formatInt(date.month) +
      DateTimes.formatInt(date.day));
  String nowFormat({String format = "yyyy-MM-dd HH:mm:ss"}) =>
      new DateFormat(format)
          .format(new DateTime.fromMillisecondsSinceEpoch(now()));
}
