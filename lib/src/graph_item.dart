import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GraphItem {
  final num value;
  final String label;
  final Widget icon;
  final String tooltip;

  GraphItem({this.icon, @required this.value, this.label, this.tooltip});

  GraphItem copyWith({num value, String label, String tooltip}) {
    return GraphItem(
        icon: this.icon,
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

  @override
  String toString() => '${label}';
}
