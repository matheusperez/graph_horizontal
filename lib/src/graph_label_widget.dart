import 'package:flutter/material.dart';

import 'graph_horizontal.dart';
import 'graph_item.dart';
import 'graph_item_widget.dart';

class GraphLabelWidget extends StatefulWidget {
  final GraphItem item;
  final Color colorBackground;
  final Color colorItem;
  final GraphType type;
  final TextStyle textLabelStyle;
  final TextStyle textValueStyle;
  final bool shouldAnimate;
  final Duration duration;
  final double heigth;
  final Color tooltipColor;
  final TextStyle tooltipTextStyle;
  final double paddingBottom;
  GraphLabelWidget(
      {Key key,
      @required this.item,
      @required this.colorBackground,
      @required this.colorItem,
      @required this.type,
      this.shouldAnimate,
      this.duration,
      this.textLabelStyle,
      this.textValueStyle,
      this.heigth,
      this.tooltipColor,
      this.tooltipTextStyle,
      this.paddingBottom})
      : super(key: key);

  @override
  _GraphLabelWidgetState createState() => _GraphLabelWidgetState();
}

class _GraphLabelWidgetState extends State<GraphLabelWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _item;

  GlobalKey keyGraph = GlobalKey();
  double width = 0.0;

  _getSize(_) {
    final RenderBox render = keyGraph.currentContext.findRenderObject();
    setState(() {
      width = render.size.width;
    });
    if (widget.shouldAnimate) {
      _controller.forward();
    } else {
      _controller.animateTo(1.0, duration: Duration(milliseconds: 10));
    }
  }

  initAnimation() {
    _controller = AnimationController(
        vsync: this, duration: widget.duration ?? Duration(milliseconds: 500));
    _item = Tween(begin: 0.0, end: widget.item.value).animate(_controller);
  }

  @override
  void initState() {
    initAnimation();
    WidgetsBinding.instance.addPostFrameCallback(_getSize);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ///BASED TYPE GRAPHTYPE
    _one() => Row(
          children: <Widget>[
            Expanded(flex: 1, child: Container()),
            Expanded(
              key: keyGraph,
              flex: 4,
              child: GraphItemWidget(
                tooltipColor: widget.tooltipColor,
                tooltipTextStyle: widget.tooltipTextStyle,
                height: widget.heigth,
                controller: _controller,
                item: widget.item,
                width: width,
                colorBackground: widget.colorBackground,
                colorItem: widget.colorItem,
              ),
            ),
            Expanded(flex: 1, child: Container()),
          ],
        );

    _two() => Row(
          children: <Widget>[
            Expanded(flex: 1, child: Container()),
            Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: widget.item.label != null
                      ? Text(
                          widget.item.label,
                          style: widget.textLabelStyle ?? TextStyle(),
                          textDirection: TextDirection.rtl,
                        )
                      : widget.item.icon,
                )),
            Expanded(
              key: keyGraph,
              flex: 4,
              child: GraphItemWidget(
                tooltipColor: widget.tooltipColor,
                tooltipTextStyle: widget.tooltipTextStyle,
                height: widget.heigth,
                controller: _controller,
                item: widget.item,
                width: width,
                colorBackground: widget.colorBackground,
                colorItem: widget.colorItem,
              ),
            ),
            Expanded(flex: 2, child: Container()),
          ],
        );

_three() => Row(
          children: <Widget>[
            Expanded(
                flex: widget.item.label == null ? 2 : 3 ,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: widget.item.label != null
                      ? Text(
                          widget.item.label,
                          style: widget.textLabelStyle ?? TextStyle(),
                          textDirection: TextDirection.rtl,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                        )
                      : Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      widget.item.icon
                    ],
                  ),
                )),
            Expanded(
              key: keyGraph,
              flex: 4,
              child: GraphItemWidget(
                tooltipColor: widget.tooltipColor,
                tooltipTextStyle: widget.tooltipTextStyle,
                height: widget.heigth,
                controller: _controller,
                item: widget.item,
                width: width,
                colorBackground: widget.colorBackground,
                colorItem: widget.colorItem,
              ),
            ),
            Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, snapshot) {
                        return Text(
                          widget.item.valueToString(_item.value),
                          style: widget.textValueStyle ?? TextStyle(),
                        );
                      }),
                )),
          ],
        );

    switch (widget.type) {
      case GraphType.one:
        {
          return Padding(
            padding: EdgeInsets.only(bottom: widget.paddingBottom),
            child: _one(),
          );
        }

        break;
      case GraphType.two:
        {
          return Padding(
            padding: EdgeInsets.only(bottom: widget.paddingBottom),
            child: _two(),
          );
        }

        break;
      default:
        {
          return Padding(
            padding: EdgeInsets.only(bottom: widget.paddingBottom),
            child: _three(),
          );
        }
    }
  }
}
