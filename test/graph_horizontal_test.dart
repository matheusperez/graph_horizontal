import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graph_horizontal/graph_horizontal.dart';
import 'package:graph_horizontal/src/graph_item.dart';
import 'package:graph_horizontal/src/graph_label_widget.dart';

main() {
  group("Graph Horizontal Test", () {
    testWidgets("Test GraphType.one", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: GraphHorizontal(
          type: GraphType.one,
          items: [
            GraphItem(value: 50, label: "A"),
            GraphItem(value: 20, label: "B"),
          ],
        ),
      ));
      expect(find.byType(GraphLabelWidget), findsWidgets);
    });

    testWidgets("Test GraphType.two", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: GraphHorizontal(
          type: GraphType.two,
          items: [
            GraphItem(value: 50, label: "A"),
            GraphItem(value: 20, label: "B"),
          ],
        ),
      ));
      expect(find.byType(GraphLabelWidget), findsWidgets);
      expect(find.text("A"), findsOneWidget);
      expect(find.text("B"), findsOneWidget);
    });

    testWidgets("Test GraphType.three", (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: GraphHorizontal(
            type: GraphType.three,
            items: [
              GraphItem(value: 50, label: "A"),
              GraphItem(value: 20, label: "B"),
            ],
          ),
        ),
      );

      expect(find.byType(GraphLabelWidget), findsWidgets);
      expect(find.text("A"), findsOneWidget);
      expect(find.text("B"), findsOneWidget);
      expect(find.widgetWithText(GraphLabelWidget, "(0%)"), findsWidgets);
      expect(find.widgetWithText(GraphLabelWidget, "(0%)"), findsWidgets);
    });

    testWidgets("Test GraphType.three - zero value",
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: GraphHorizontal(
          type: GraphType.three,
          items: [
            GraphItem(value: 0, label: "A"),
            GraphItem(value: 0, label: "B"),
          ],
        ),
      ));
      expect(find.byType(GraphLabelWidget), findsWidgets);
      expect(find.text("A"), findsOneWidget);
      expect(find.text("B"), findsOneWidget);
      expect(find.widgetWithText(GraphLabelWidget, "(0%)"), findsWidgets);
    });

    testWidgets("Test GraphType.three - 100% value",
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: GraphHorizontal(
          type: GraphType.three,
          items: [
            GraphItem(value: 0, label: "A"),
            GraphItem(value: 200, label: "B"),
          ],
        ),
      ));
      expect(find.byType(GraphLabelWidget), findsWidgets);
      expect(find.text("A"), findsOneWidget);
      expect(find.text("B"), findsOneWidget);
    });

    testWidgets("Test GraphType.three - 100% value and one label",
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: GraphHorizontal(
          shouldAnimate: false,
          type: GraphType.three,
          items: [
            GraphItem(value: 200, label: "A"),
          ],
        ),
      ));

      expect(find.byType(GraphLabelWidget), findsWidgets);
      expect(find.text("A"), findsOneWidget);
    });

    testWidgets("Test GraphType.three - 0% value and one label",
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: GraphHorizontal(
          type: GraphType.three,
          items: [
            GraphItem(value: 0, label: "A"),
          ],
        ),
      ));
      expect(find.byType(GraphLabelWidget), findsWidgets);
      expect(find.text("A"), findsOneWidget);
      expect(find.widgetWithText(GraphLabelWidget, "(0%)"), findsOneWidget);
    });
  });
}
