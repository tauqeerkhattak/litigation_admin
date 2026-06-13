extension StringUtils on String {
  String get capitalize {
    if (length <= 1) {
      return this.toUpperCase();
    }
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
