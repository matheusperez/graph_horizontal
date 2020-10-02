import 'package:flutter/material.dart';

import 'graph_item.dart';
import 'tooltip_widget.dart';

class GraphItemWidget extends StatefulWidget {
  final GraphItem item;
  final Color colorBackground;
  final Color colorItem;
  final Color tooltipColor;
  final TextStyle tooltipTextStyle;
  final double width;
  final double height;
  final AnimationController controller;

  const GraphItemWidget({
    Key key,
    @required this.item,
    @required this.colorBackground,
    @required this.colorItem,
    @required this.width,
    this.height = 20,
    this.controller,
    this.tooltipColor,
    this.tooltipTextStyle,
  }) : super(key: key);

  @override
  _GraphItemWidgetState createState() => _GraphItemWidgetState();
}

class _GraphItemWidgetState extends State<GraphItemWidget>
    with SingleTickerProviderStateMixin {
  Animation _width;

  void initAnimation() {
    _width =
        Tween(begin: 0.0, end: widget.item.value).animate(widget.controller);
  }

  bool clicked = false;

  void _change(bool value) {
    setState(() {
      clicked = value;
    });
  }

  void _click() async {
    if (clicked == false) {
      _change(true);
      await Future.delayed(Duration(seconds: 1));
      _change(false);
    } else {
      _change(false);
    }
  }

  @override
  void initState() {
    initAnimation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _click,
      child: Container(
        decoration: BoxDecoration(
            color: widget.colorBackground,
            borderRadius: BorderRadius.circular(30)),
        key: widget.key,
        height: widget.height,
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            AnimatedBuilder(
                animation: widget.controller,
                builder: (context, child) {
                  return Container(
                    decoration: BoxDecoration(
                        color: widget.colorItem,
                        borderRadius: BorderRadius.circular(30)),
                    width: widget.width * _width.value,
                    height: widget.height,
                  );
                }),
            if (clicked)
              Center(
                child: TooltipWidget(
                  title: widget.item.tooltip,
                  style: widget.tooltipTextStyle,
                  color: widget.tooltipColor,
                ),
              )
          ],
        ),
      ),
    );
  }
}
