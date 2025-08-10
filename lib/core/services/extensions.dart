extension NumNull on int? {
  int get orZero => this ?? 0;
}

extension StringNull on String? {
  String orEmpty() => this ?? "";
}
