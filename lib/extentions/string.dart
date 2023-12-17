List<String> _stringFormatters = [
  "%%", "%s", "%d", "%x", "%t", "%n", "%o",
  "%f", "%e", "%g", "%h", "%c", "%b", "%a",
];
String _regularExpression =
    r"%(?:([0-9]+)?"
    r"(d|u|x|o|b|e|c|p|h|l|t|n|s|f|g|a|%)"
    r"|"
    r"([#0]+)"
    r"([0-9]+)?"
    r"([a-zA-Z]))";

extension StringFormatExtention on String {
  String format(List<dynamic> arguments) {
    RegExp regExp = RegExp(_regularExpression, multiLine: true, caseSensitive: false);
    List<RegExpMatch> matches = regExp.allMatches(this).toList();
    String resultString = this;
    if (matches.any((element) => !_stringFormatters.contains(element.group(0)))) {
      throw ArgumentError("${matches.firstWhere((element) => !_stringFormatters.contains(element.group(0)))} is invalid string formatter.");
    }
    else if (matches.length < arguments.length) {
      throw ArgumentError("Arguments size is bigger than matches(${matches.length} matches to ${arguments.length} arguments). String: $this. Regex: $regExp.");
    }
    else {
      for (var (index, match) in matches.indexed) {
        resultString = resultString.replaceFirst(match.pattern, arguments[index].toString());
      }
    }
    return resultString;
  }
}