main(List<String> args) {
  DateTime timenow = DateTime.now();
  // print(DateTime.fromMillisecondsSinceEpoch(1072915200));
  var resultDivide = ((timenow.millisecondsSinceEpoch) / 1000);
  print(resultDivide);
  print(resultDivide.round());
  print(timenow);
  String timeInString = timenow.millisecondsSinceEpoch.toString();
  print("time in string - $timeInString");
  print(timeInString.runtimeType);
  int timeInInt = int.parse(timeInString);
  print("time in int again - $timeInInt");
  print(timeInInt.runtimeType);
}
