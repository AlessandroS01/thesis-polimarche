


class FirestoreStringNumberConverter {
  static String numberToString(num number) {
    return number.toString();
  }

  static num? stringToNumber(String stringValue) {
    return num.tryParse(stringValue);
  }
}