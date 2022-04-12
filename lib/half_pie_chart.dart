// Copyright 2018 the Charts project authors. Please see the AUTHORS file
// for details.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/// Gauge chart example, where the data does not cover a full revolution in the
/// chart.
import 'dart:math';

// EXCLUDE_FROM_GALLERY_DOCS_END
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class GaugeChart extends StatelessWidget {
  final List<charts.Series<dynamic, String>> seriesList;
  final bool animate;

  GaugeChart(this.seriesList, {this.animate = false});

  /// Creates a [PieChart] with sample data and no transition.
  factory GaugeChart.withSampleData() {
    return GaugeChart(
      _createSampleData(),

      // Disable animations for image tests.
      animate: true,
    );
  }

  // EXCLUDE_FROM_GALLERY_DOCS_START
  // This section is excluded from being copied to the gallery.
  // It is used for creating random series data to demonstrate animation in
  // the example app only.

  // EXCLUDE_FROM_GALLERY_DOCS_END

  @override
  Widget build(BuildContext context) {
    return charts.PieChart<String>(
      seriesList,
      animate: animate,

      // Configure the width of the pie slices to 30px. The remaining space in
      // the chart will be left as a hole in the center. Adjust the start
      // angle and the arc length of the pie so it resembles a gauge.
      defaultRenderer: charts.ArcRendererConfig(
          arcWidth: 25,
          strokeWidthPx: 0.0,
          startAngle: 3,
          arcLength: 5.5 / 5 * pi,
          arcRendererDecorators: [
            charts.ArcLabelDecorator(showLeaderLines: false)
          ]),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<GaugeSegment, String>> _createSampleData() {
    final data = [
      GaugeSegment('Correct', 95, Colors.greenAccent),
      GaugeSegment('Incorrect', 25, Colors.redAccent),
      GaugeSegment('No Answer', 31, Colors.black12),
      // new GaugeSegment('Highly Unusual', 5),
    ];

    return [
      charts.Series<GaugeSegment, String>(
        id: 'Segments',
        domainFn: (GaugeSegment segment, _) => segment.segment,
        measureFn: (GaugeSegment segment, _) => segment.size,
        colorFn: (GaugeSegment segment, _) =>
            charts.ColorUtil.fromDartColor(segment.color),
        data: data,
        labelAccessorFn: (GaugeSegment segment, _) =>
            '${segment.size} ${segment.segment}',
      )
    ];
  }
}

/// Sample data type.
class GaugeSegment {
  final String segment;
  final int size;
  final Color color;

  GaugeSegment(this.segment, this.size, this.color);
}

typedef Widget GalleryWidgetBuilder();

/// Helper to build gallery.
class GalleryScaffold extends StatefulWidget {
  /// The widget used for leading in a [ListTile].
  final Widget listTileIcon;
  final String title;
  final String subtitle;
  final GalleryWidgetBuilder childBuilder;

  GalleryScaffold({
    required this.listTileIcon,
    required this.title,
    required this.subtitle,
    required this.childBuilder,
  });

  /// Gets the gallery
  Widget buildGalleryListTile(BuildContext context) => ListTile(
      leading: listTileIcon,
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => this));
      });

  @override
  _GalleryScaffoldState createState() => _GalleryScaffoldState();
}

class _GalleryScaffoldState extends State<GalleryScaffold> {
  void _handleButtonPress() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: <Widget>[
            SizedBox(height: 200.0, child: widget.childBuilder()),
          ])),
      floatingActionButton: FloatingActionButton(
          onPressed: _handleButtonPress, child: Icon(Icons.refresh)),
    );
  }
}
