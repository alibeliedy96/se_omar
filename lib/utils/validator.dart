class Validator {
  static const String _emailPattern =
      "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$";
  static final RegExp _emailRegex = RegExp(_emailPattern);

  static bool validateEmail(String value) {
    return _emailRegex.hasMatch(value);
  }

  /// يتحقق من رقم الموبايل (يقبل رقم دولي أو محلي)
  static bool validateMobile(String value) {
    // يقبل +201 أو 01 أو 00201 وبعدها 9 أرقام
    final RegExp mobileRegex = RegExp(r'^(?:\+?20|0)?1[0125][0-9]{8}$');
    return mobileRegex.hasMatch(value.trim());
  }
}
