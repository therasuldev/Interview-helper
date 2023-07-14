extension ParseToPercent on double? {
  String toPercent() {
    return '${(double.parse(this?.toStringAsFixed(2) ?? '0') * 100).toInt()} %';
  }
}
