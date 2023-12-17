
import '../constants/arrays.dart';

const _defaultValue = (0, 0, 0.0);

List<(int, int, double)> convertFromSavedStatisticData(List<String>? savedStatisticData) {
  if (savedStatisticData != null && savedStatisticData.length == questions.length) {
    return savedStatisticData.map((e) => e.split(","))
        .map((e) {
      var result = e.toList();
      if (result.length == 3) {
        var (first, second, third) = (int.tryParse(result[0]), int.tryParse(result[1]), double.tryParse(result[2]));
        if (first != null && second != null && third != null) {
          return (first, second, third);
        }
        else {
          return _defaultValue;
        }
      }
      else {
        return _defaultValue;
      }
    }).toList();
  }
  else {
    return defaultSavedStatisticData;
  }
}

List<(int, int, double)> get defaultSavedStatisticData => [
  for(int i = 0; i < questions.length; i++)
    _defaultValue,
];

List<String> convertToSavedStatisticData(List<(int, int, double)> savedStatisticData) {
  return savedStatisticData.map((e) => "${e.$1},${e.$2},${e.$3.toStringAsFixed(2)}").toList();
}