import 'package:flutter/foundation.dart';

class GraphItem {
  final num value;
  final String label;
  final String tooltip;

  GraphItem({@required this.value, @required this.label, this.tooltip});

  GraphItem copyWith({num value, String label, String tooltip}) {
    return GraphItem(
        value: value ?? this.value,
        label: label ?? this.label,
        tooltip: tooltip ?? this.tooltip);
  }

  String valueToString(num value) {
    if (value <= 1) {
      final newValue = value * 100;
      return "(${newValue.toStringAsFixed(0)}%)";
    } else {
      return "(${value.toStringAsFixed(0)}%)";
    }
  }
}
