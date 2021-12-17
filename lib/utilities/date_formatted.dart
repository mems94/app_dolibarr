import 'package:intl/intl.dart';

String dateFormatted() {
  var now = DateTime.now();
  // var formatter = new DateFormat("EEE, MM d, ''yy");
  var formatter = new DateFormat("yyyy-MM-d");
  String formatted = formatter.format(now);

  return formatted;
}

String convertDateSecondeTodateFormatter(String dateString) {
  DateTime dateEntier =
      DateTime.fromMillisecondsSinceEpoch((int.parse(dateString) * 1000));
  String dateFormatter = "${dateEntier.day}" +
      "/" +
      "${dateEntier.month}" +
      "/" +
      "${dateEntier.year}";
  return dateFormatter;
}

String convertDateToSeconds() {
  var now = DateTime.now();
  var nowToMilliSec = now.millisecondsSinceEpoch;
  var nowToSecBrute = (nowToMilliSec / 1000);
  var nowToSec = nowToSecBrute.round();
  print(nowToSec);
  return nowToSec.toString();
}

// String convertTimeStampToDate(String timeStamp) {
//    timeStampInt = int.parse(timeStamp);

//   return normalDate;
// }

DateTime dateFormattedAPI(String date) {
  var newDate = DateTime.parse(date);
  // var formatter = DateFormat("yy-MM-d");
  // String dateFormatted = formatter.format(newDate);
  return newDate;
}
