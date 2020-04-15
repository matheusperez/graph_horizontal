import 'package:flutter/material.dart';

import 'graph_item.dart';
import 'graph_label_widget.dart';

enum GraphType { one, two, three }

class GraphHorizontal extends StatefulWidget {
  final List<GraphItem> items;
  final GraphType type;
  final TextStyle textLabelStyle;
  final TextStyle textValueStyle;
  final Color colorBackground;
  final Color colorItem;
  final bool shouldAnimate;
  final Duration duration;
  final double height;
  final Color tooltipColor;
  final TextStyle tooltipTextStyle;
  GraphHorizontal(
      {Key key,
      @required this.items,
      this.type = GraphType.three,
      this.colorBackground,
      this.colorItem,
      this.shouldAnimate = true,
      this.duration,
      this.textLabelStyle,
      this.textValueStyle,
      this.height = 20,
      this.tooltipColor,
      this.tooltipTextStyle})
      : super(key: key);

  @override
  _GraphHorizontalState createState() => _GraphHorizontalState();
}

class _GraphHorizontalState extends State<GraphHorizontal> {
  List<GraphItem> get _mountGraph {
    final list = <GraphItem>[];
    var total = 0.0;

    widget.items.forEach((element) {
      print(element.value);
      total += element.value;
    });
    if (total > 0) {
      for (var item in widget.items) {
        list.add(item.copyWith(
            value: item.value / total, tooltip: item.value.toString()));
      }
      return list;
    } else {
      return widget.items;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _mountGraph
          .map((e) => GraphLabelWidget(
                tooltipColor: widget.tooltipColor,
                tooltipTextStyle: widget.tooltipTextStyle,
                heigth: widget.height,
                shouldAnimate: widget.shouldAnimate,
                duration: widget.duration,
                type: widget.type,
                item: e,
                colorBackground: widget.colorBackground ?? Colors.grey[300],
                colorItem: widget.colorItem ?? Theme.of(context).primaryColor,
              ))
          .toList(),
    );
  }
}
