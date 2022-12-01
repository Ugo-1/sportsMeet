class ValidatorUtils {

  static bool isEmpty(String? value){
    return value == null || value.isEmpty;
  }

  static bool isNotEmail(String? value){
    return !(value != null && value.contains('@'));
  }

  static bool noCountryCode(String? value){
    return !(value != null && value.startsWith('+'));
  }

  static bool shortPassword(String? value){
    return value == null || value.length < 6;
  }

}