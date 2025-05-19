extension NullCheckExtension on String? {
  bool get isEmptyOrNull {
    return this != null ? this!.isEmpty : true;
  }
}
