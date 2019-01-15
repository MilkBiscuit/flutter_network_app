class StringUtil {

  static int parseInt(String input) {
    return int.tryParse(input) ?? 0;
  }

}