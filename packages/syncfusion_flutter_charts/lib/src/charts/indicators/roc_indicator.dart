import 'dart:math';

import 'package:flutter/material.dart';

import '../behaviors/trackball.dart';
import '../common/callbacks.dart';
import '../common/chart_point.dart';
import '../series/chart_series.dart';
import '../utils/constants.dart';
import '../utils/enum.dart';
import '../utils/helper.dart';
import '../utils/typedef.dart';
import 'technical_indicator.dart';

/// Renders the ROC indicator.
///
/// It's commonly used in technical analysis to identify trends and potential reversal points,
/// and it suggests increasing momentum in the direction of the trend. A positive ROC indicates
/// that the price is increasing, a negative ROC indicates that the price is decreasing, and
/// the magnitude of the ROC indicates the strength of the price change.
///
/// The indicator elements are:
///
/// * The [dataSource], which is used provide data for the technical indicators without any series.
/// * The [xValueMapper], which is a value mapper to map the x values with the technical indicator.
/// * The [highValueMapper], which is a value mapper to map the high values with the technical indicator.
/// * The [lowValueMapper], which is a value mapper to map the low values with the technical indicator.
/// * The [openValueMapper], which is a value mapper to map the open values with the technical indicator.
/// * The [closeValueMapper], which is a value mapper to map the close values with the technical indicator.
/// * The [xAxisName] and [yAxisName], which is used map the technical indicator with the multiple axes.
/// * The [seriesName], which is used map the technical indicator with the series based on names.
/// * The [centerLineColor] and [centerLineWidth], which is used to customize center line color and its width.
/// * The [period], which is used determines the start point for the rendering of technical indicator.
///
/// ## Formula
///
/// Data (Closing Prices for Each Day):
///
/// *  Day 1: $100
/// *  Day 2: $105
/// *  Day 3: $110
/// *  Day 4: $120
/// *  Day 5: $103
/// *  ...
/// *  Day 15: $110
/// *  Day 16: $108
/// *  …
/// *  Day 29: $110
/// *  Day 30: $120
///
///
/// Calculation of ROC:
/// *  ROC = ((currentPrice - priceNPeriodsAgo) / priceNPeriodsAgo) * 100;
///
/// *  ROC on Day 3:
/// *  If we need to calculate the 3rd day ROC, the current value is 110, and previous 2nd day value is 105
/// (110-105/105) × 100 = 4.76%
///
/// *  ROC on Day 16:
/// *  If we need to calculate the 16th day ROC, the current value is 108, the previous 15th day value is 110
/// (108-110/110) × 100 = -1.8%
///
/// *  ROC on Day 30:
/// *  (120−110/110) × 100 = 9.09%
///
/// ## Example
///
/// This snippet shows how to create a [RocIndicator] by mapping the series data source.
///
/// ```dart
///
///  @override
///  Widget build(BuildContext context) {
///    return MaterialApp(
///      home: Scaffold(
///        body: Center(
///          child: SfCartesianChart(
///            primaryXAxis: const DateTimeAxis(),
///            primaryYAxis: const NumericAxis(),
///            axes: const <ChartAxis>[
///              NumericAxis(
///                majorGridLines: MajorGridLines(width: 0),
///                opposedPosition: true,
///                name: 'yAxis',
///              ),
///            ],
///            indicators: <TechnicalIndicator<ChartSampleData, DateTime>>[
///              RocIndicator<ChartSampleData, DateTime>(
///                seriesName: 'AAPL',
///                yAxisName: 'yAxis',
///                period: 15,
///              ),
///            ],
///            series: <CartesianSeries<ChartSampleData, DateTime>>[
///              HiloOpenCloseSeries<ChartSampleData, DateTime>(
///                dataSource: getChartData(),
///                xValueMapper: (ChartSampleData sales, _) => sales.x as DateTime,
///                lowValueMapper: (ChartSampleData sales, _) => sales.low,
///                highValueMapper: (ChartSampleData sales, _) => sales.high,
///                openValueMapper: (ChartSampleData sales, _) => sales.open,
///                closeValueMapper: (ChartSampleData sales, _) => sales.close,
///                name: 'AAPL',
///              ),
///            ],
///          ),
///        ),
///      ),
///    );
///  }
/// ```
/// This snippet shows how to create a [RocIndicator] using a direct data source.
///
/// ```dart
///
///  @override
///  Widget build(BuildContext context) {
///    return MaterialApp(
///      home: Scaffold(
///        body: Center(
///          child: SfCartesianChart(
///            primaryXAxis: const DateTimeAxis(),
///            primaryYAxis: const NumericAxis(),
///            axes: const <ChartAxis>[
///              NumericAxis(
///                majorGridLines: MajorGridLines(width: 0),
///                opposedPosition: true,
///                name: 'yAxis',
///              ),
///            ],
///            indicators: <TechnicalIndicator<ChartSampleData, DateTime>>[
///              RocIndicator<ChartSampleData, DateTime>(
///                dataSource: getChartData(),
///                xValueMapper: (ChartSampleData sales, _) => sales.x as DateTime,
///                lowValueMapper: (ChartSampleData sales, _) => sales.low,
///                highValueMapper: (ChartSampleData sales, _) => sales.high,
///                openValueMapper: (ChartSampleData sales, _) => sales.open,
///                closeValueMapper: (ChartSampleData sales, _) => sales.close,
///                yAxisName: 'yAxis',
///                period: 15,
///              ),
///            ],
///          ),
///        ),
///      ),
///    );
///  }
/// ```
///
@immutable
class RocIndicator<T, D> extends TechnicalIndicator<T, D> {
  /// Creating an argument constructor of ROCIndicator class.
  RocIndicator({
    super.isVisible = true,
    super.xAxisName,
    super.yAxisName,
    super.seriesName,
    super.dashArray,
    super.animationDuration,
    super.animationDelay,
    super.dataSource,
    ChartValueMapper<T, D>? xValueMapper,
    ChartValueMapper<T, num>? highValueMapper,
    ChartValueMapper<T, num>? lowValueMapper,
    ChartValueMapper<T, num>? openValueMapper,
    ChartValueMapper<T, num>? closeValueMapper,
    super.name,
    super.isVisibleInLegend,
    super.legendIconType,
    super.legendItemText,
    super.signalLineColor,
    super.signalLineWidth,
    this.period = 14,
    this.centerLineColor = Colors.red,
    this.centerLineWidth = 2,
    super.onRenderDetailsUpdate,
  }) : super(
          xValueMapper: xValueMapper != null && dataSource != null
              ? (int index) => xValueMapper(dataSource[index], index)
              : null,
          highValueMapper: highValueMapper != null && dataSource != null
              ? (int index) => highValueMapper(dataSource[index], index)
              : null,
          lowValueMapper: lowValueMapper != null && dataSource != null
              ? (int index) => lowValueMapper(dataSource[index], index)
              : null,
          openValueMapper: openValueMapper != null && dataSource != null
              ? (int index) => openValueMapper(dataSource[index], index)
              : null,
          closeValueMapper: closeValueMapper != null && dataSource != null
              ? (int index) => closeValueMapper(dataSource[index], index)
              : null,
        );

  /// Center line color of the ROC indicator.
  ///
  /// Defaults to `Colors.red`.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return SfCartesianChart(
  ///    indicators: <TechnicalIndicator<Sample, num>>[
  ///      RocIndicator<Sample, num>(
  ///        seriesName: 'Series1'
  ///        centerLineColor : Colors.green
  ///      ),
  ///    ],
  ///    series: <CartesianSeries<Sample, num>>[
  ///      HiloOpenCloseSeries<Sample, num>(
  ///        name: 'Series1'
  ///      )
  ///    ]
  ///  );
  /// }
  /// ```
  final Color centerLineColor;

  /// Center line width of the ROC indicator.
  ///
  /// Defaults to `2`.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return SfCartesianChart(
  ///    indicators: <TechnicalIndicator<Sample, num>>[
  ///      RocIndicator<Sample, num>(
  ///        seriesName: 'Series1'
  ///        centerLineWidth: 3
  ///      ),
  ///    ],
  ///    series: <CartesianSeries<Sample, num>>[
  ///      HiloOpenCloseSeries<Sample, num>(
  ///        name: 'Series1'
  ///      )
  ///    ]
  ///  );
  /// }
  /// ```
  final double centerLineWidth;

  /// Period determines the start point for the rendering of
  /// technical indicators.
  ///
  /// Defaults to `14`.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return SfCartesianChart(
  ///    indicators: <TechnicalIndicator<Sample, num>>[
  ///      RocIndicator<Sample, num>(
  ///        period : 4
  ///      ),
  ///    ],
  ///  );
  /// }
  /// ```
  final int period;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    return other is RocIndicator &&
        other.isVisible == isVisible &&
        other.xAxisName == xAxisName &&
        other.yAxisName == yAxisName &&
        other.seriesName == seriesName &&
        other.dashArray == dashArray &&
        other.animationDuration == animationDuration &&
        other.animationDelay == animationDelay &&
        other.dataSource == dataSource &&
        other.xValueMapper == xValueMapper &&
        other.highValueMapper == highValueMapper &&
        other.lowValueMapper == lowValueMapper &&
        other.openValueMapper == openValueMapper &&
        other.closeValueMapper == closeValueMapper &&
        other.period == period &&
        other.name == name &&
        other.isVisibleInLegend == isVisibleInLegend &&
        other.legendIconType == legendIconType &&
        other.legendItemText == legendItemText &&
        other.signalLineColor == signalLineColor &&
        other.signalLineWidth == signalLineWidth &&
        other.centerLineColor == centerLineColor &&
        other.centerLineWidth == centerLineWidth;
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      isVisible,
      xAxisName,
      yAxisName,
      seriesName,
      dashArray,
      animationDuration,
      animationDelay,
      dataSource,
      xValueMapper,
      highValueMapper,
      lowValueMapper,
      openValueMapper,
      closeValueMapper,
      name,
      isVisibleInLegend,
      legendIconType,
      legendItemText,
      signalLineColor,
      signalLineWidth,
      period,
      centerLineColor,
      centerLineWidth
    ];
    return Object.hashAll(values);
  }

  @override
  String toString() => 'ROC';
}

class RocIndicatorWidget extends IndicatorWidget {
  const RocIndicatorWidget({
    super.key,
    required super.vsync,
    required super.isTransposed,
    required super.indicator,
    required super.index,
    super.onLegendTapped,
    super.onLegendItemRender,
  });

  // Create the RocIndicatorRenderer renderer.
  @override
  RocIndicatorRenderer createRenderer() {
    return RocIndicatorRenderer();
  }

  @override
  RenderObject createRenderObject(BuildContext context) {
    final RocIndicatorRenderer renderer =
        super.createRenderObject(context) as RocIndicatorRenderer;
    final RocIndicator roc = indicator as RocIndicator;
    renderer
      ..highValueMapper = roc.highValueMapper
      ..lowValueMapper = roc.lowValueMapper
      ..openValueMapper = roc.openValueMapper
      ..closeValueMapper = roc.closeValueMapper
      ..centerLineColor = roc.centerLineColor
      ..centerLineWidth = roc.centerLineWidth
      ..period = roc.period;

    return renderer;
  }

  @override
  void updateRenderObject(
      BuildContext context, RocIndicatorRenderer renderObject) {
    super.updateRenderObject(context, renderObject);
    final RocIndicator roc = indicator as RocIndicator;
    renderObject
      ..highValueMapper = roc.highValueMapper
      ..lowValueMapper = roc.lowValueMapper
      ..openValueMapper = roc.openValueMapper
      ..closeValueMapper = roc.closeValueMapper
      ..centerLineColor = roc.centerLineColor
      ..centerLineWidth = roc.centerLineWidth
      ..period = roc.period;
  }
}

class RocIndicatorRenderer<T, D> extends IndicatorRenderer<T, D> {
  late List<double>? _dashArray;

  final List<Offset> _signalLineActualValues = <Offset>[];
  final List<Offset> _centerLineActualValues = <Offset>[];
  final List<Offset> _centerLinePoints = <Offset>[];
  final Path _centerLinePath = Path();
  List<num> _highValues = <num>[];
  List<num> _lowValues = <num>[];
  List<num> _openValues = <num>[];
  List<num> _closeValues = <num>[];

  Color get centerLineColor => _centerLineColor;
  Color _centerLineColor = Colors.red;
  set centerLineColor(Color value) {
    if (_centerLineColor != value) {
      _centerLineColor = value;
      markNeedsPaint();
    }
  }

  double get centerLineWidth => _centerLineWidth;
  double _centerLineWidth = 2;
  set centerLineWidth(double value) {
    if (_centerLineWidth != value) {
      _centerLineWidth = value;
      markNeedsPaint();
    }
  }

  int get period => _period;
  int _period = 14;
  set period(int value) {
    if (_period != value) {
      _period = value;
      markNeedsPopulateAndLayout();
    }
  }

  @override
  void populateDataSource([
    List<T>? seriesDataSource,
    ChartIndexedValueMapper<D>? xPath,
    List<num>? xList,
    List<ChartIndexedValueMapper<num?>?>? yPaths,
    List<List<num>?>? yList,
  ]) {
    if (dataSource != null) {
      super.populateDataSource(
        dataSource,
        xValueMapper,
        xValues,
        <ChartIndexedValueMapper<num?>?>[
          highValueMapper,
          lowValueMapper,
          openValueMapper,
          closeValueMapper
        ],
        <List<num>>[_highValues, _lowValues, _openValues, _closeValues],
      );
    } else {
      if (seriesName != null) {
        if (dependent is FinancialSeriesRendererBase<T, D>) {
          final FinancialSeriesRendererBase<T, D> series =
              dependent! as FinancialSeriesRendererBase<T, D>;
          seriesDataSource = series.dataSource;
          xValues = series.xValues;
          xRawValues = series.xRawValues;
          _highValues = series.highValues;
          _lowValues = series.lowValues;
          _openValues = series.openValues;
          _closeValues = series.closeValues;
          dataCount = xValues.length;
        }
      }
    }

    _calculateCenterAndSignalValues();
    populateChartPoints();
  }

  void _calculateCenterAndSignalValues() {
    if (dataCount >= period && period > 0) {
      _signalLineActualValues.clear();
      _centerLineActualValues.clear();

      num xMinimum = double.infinity;
      num xMaximum = double.negativeInfinity;
      num yMinimum = double.infinity;
      num yMaximum = double.negativeInfinity;
      final bool isCenterLineVisible = centerLineWidth > 0;
      final bool isSignalLineVisible = signalLineWidth > 0;

      for (int i = 0; i < dataCount; i++) {
        final double x = xValues[i].toDouble();
        if (isCenterLineVisible) {
          xMinimum = min(xMinimum, x);
          xMaximum = max(xMaximum, x);
          yMinimum = min(yMinimum, 0);
          yMaximum = max(yMaximum, 0);
          _centerLineActualValues.add(Offset(x, 0));
        }

        if (isSignalLineVisible) {
          if (!(i < period)) {
            final num prevY = _closeValues[i - period];
            final double y = ((_closeValues[i] - prevY) / prevY) * 100;
            if (y.isNaN) {
              continue;
            }

            xMinimum = min(xMinimum, x);
            xMaximum = max(xMaximum, x);
            yMinimum = min(yMinimum, y);
            yMaximum = max(yMaximum, y);
            _signalLineActualValues.add(Offset(x, y));
          }
        }
      }

      xMin = xMinimum.isInfinite ? xMin : xMinimum;
      xMax = xMaximum.isInfinite ? xMax : xMaximum;
      yMin = yMinimum.isInfinite ? yMin : yMinimum;
      yMax = yMaximum.isInfinite ? yMax : yMaximum;
    }
  }

  @override
  void populateChartPoints({
    List<ChartDataPointType>? positions,
    List<List<num>>? yLists,
  }) {
    yLists = <List<num>>[_highValues, _lowValues, _openValues, _closeValues];
    positions = <ChartDataPointType>[
      ChartDataPointType.high,
      ChartDataPointType.low,
      ChartDataPointType.open,
      ChartDataPointType.close,
    ];
    super.populateChartPoints(positions: positions, yLists: yLists);
  }

  @override
  String defaultLegendItemText() => 'ROC';

  @override
  Color effectiveLegendIconColor() => signalLineColor;

  @override
  void transformValues() {
    signalLinePoints.clear();
    _centerLinePoints.clear();

    if (_centerLineActualValues.isNotEmpty) {
      final int length = _centerLineActualValues.length;
      for (int i = 0; i < length; i++) {
        final num x = _centerLineActualValues[i].dx;
        final num y = _centerLineActualValues[i].dy;
        _centerLinePoints.add(Offset(pointToPixelX(x, y), pointToPixelY(x, y)));
      }
    }

    if (_signalLineActualValues.isNotEmpty) {
      final int length = _signalLineActualValues.length;
      for (int i = 0; i < length; i++) {
        final num x = _signalLineActualValues[i].dx;
        final num y = _signalLineActualValues[i].dy;
        signalLinePoints.add(Offset(pointToPixelX(x, y), pointToPixelY(x, y)));
      }
    }
  }

  @override
  List<TrackballInfo>? trackballInfo(Offset position) {
    final List<ChartTrackballInfo<T, D>> trackballInfo =
        <ChartTrackballInfo<T, D>>[];
    final int rocPointIndex = _findNearestPoint(signalLinePoints, position);
    if (rocPointIndex != -1) {
      final CartesianChartPoint<D> rocPoint = _chartPoint(rocPointIndex, 'roc');
      final String text = defaultLegendItemText();
      trackballInfo.add(ChartTrackballInfo<T, D>(
        position: signalLinePoints[rocPointIndex],
        point: rocPoint,
        series: this,
        pointIndex: rocPointIndex,
        segmentIndex: rocPointIndex,
        seriesIndex: index,
        name: text,
        header: tooltipHeaderText(rocPoint),
        text: trackballText(rocPoint, text),
        color: signalLineColor,
      ));
    }
    final int centerPointIndex = _findNearestPoint(_centerLinePoints, position);
    if (centerPointIndex != -1) {
      final CartesianChartPoint<D> centerPoint =
          _chartPoint(centerPointIndex, 'center');
      trackballInfo.add(ChartTrackballInfo<T, D>(
        position: _centerLinePoints[centerPointIndex],
        point: centerPoint,
        series: this,
        pointIndex: centerPointIndex,
        segmentIndex: centerPointIndex,
        seriesIndex: index,
        name: trackballCenterText,
        header: tooltipHeaderText(centerPoint),
        text: trackballText(centerPoint, trackballCenterText),
        color: _centerLineColor,
      ));
    }

    return trackballInfo;
  }

  int _findNearestPoint(List<Offset> points, Offset position) {
    double delta = 0;
    num? nearPointX;
    num? nearPointY;
    int? pointIndex;
    final int length = points.length;
    for (int i = 0; i < length; i++) {
      nearPointX ??= points[0].dx;
      nearPointY ??= yAxis!.visibleRange!.minimum;

      final num touchXValue = position.dx;
      final num touchYValue = position.dy;
      final double curX = points[i].dx;
      final double curY = points[i].dy;
      if (isTransposed) {
        if (delta == touchYValue - curY) {
          pointIndex = i;
        } else if ((touchYValue - curY).abs() <=
            (touchYValue - nearPointY).abs()) {
          nearPointX = curX;
          nearPointY = curY;
          delta = touchYValue - curY;
          pointIndex = i;
        }
      } else {
        if (delta == touchXValue - curX) {
          pointIndex = i;
        } else if ((touchXValue - curX).abs() <=
            (touchXValue - nearPointX).abs()) {
          nearPointX = curX;
          nearPointY = curY;
          delta = touchXValue - curX;
          pointIndex = i;
        }
      }
    }
    return pointIndex ?? -1;
  }

  CartesianChartPoint<D> _chartPoint(int pointIndex, String type) {
    return CartesianChartPoint<D>(
      x: type == 'roc'
          ? xRawValues[pointIndex + period - 1]
          : xRawValues[pointIndex],
      xValue:
          type == 'roc' ? xValues[pointIndex + period] : xValues[pointIndex],
      y: type == 'roc'
          ? _signalLineActualValues[pointIndex].dy
          : _centerLineActualValues[pointIndex].dy,
    );
  }

  @override
  void customizeIndicator() {
    if (onRenderDetailsUpdate != null) {
      final RocIndicatorRenderParams params = RocIndicatorRenderParams(
        _centerLineActualValues.first.dy,
        chartPoints,
        legendItemText ?? name ?? defaultLegendItemText(),
        signalLineWidth,
        signalLineColor,
        dashArray,
      );
      final TechnicalIndicatorRenderDetails details =
          onRenderDetailsUpdate!(params);
      strokePaint
        ..color = details.signalLineColor
        ..strokeWidth = details.signalLineWidth;
      _dashArray = details.signalLineDashArray;
    } else {
      strokePaint
        ..color = signalLineColor
        ..strokeWidth = signalLineWidth;
      _dashArray = dashArray;
    }
  }

  @override
  void onPaint(PaintingContext context, Offset offset) {
    context.canvas.save();
    final Rect clip = clipRect(paintBounds, animationFactor,
        isInversed: xAxis!.isInversed, isTransposed: isTransposed);
    context.canvas.clipRect(clip);

    int length = signalLinePoints.length - 1;
    if (strokePaint.color != Colors.transparent &&
        strokePaint.strokeWidth > 0) {
      for (int i = 0; i < length; i++) {
        drawDashes(
          context.canvas,
          _dashArray,
          strokePaint,
          start: signalLinePoints[i],
          end: signalLinePoints[i + 1],
        );
      }
    }

    if (_centerLinePoints.isNotEmpty) {
      final Paint paint = Paint()
        ..isAntiAlias = true
        ..color = centerLineColor
        ..strokeWidth = centerLineWidth
        ..style = PaintingStyle.stroke;

      if (paint.color != Colors.transparent && paint.strokeWidth > 0) {
        _centerLinePath.reset();
        length = _centerLinePoints.length;
        _centerLinePath.moveTo(
            _centerLinePoints.first.dx, _centerLinePoints.first.dy);
        for (int i = 1; i < length; i++) {
          _centerLinePath.lineTo(
              _centerLinePoints[i].dx, _centerLinePoints[i].dy);
        }
        drawDashes(context.canvas, _dashArray, paint, path: _centerLinePath);
      }
    }
    context.canvas.restore();
  }

  @override
  void dispose() {
    _signalLineActualValues.clear();
    _centerLineActualValues.clear();
    _centerLinePoints.clear();
    _centerLinePath.reset();
    _highValues.clear();
    _lowValues.clear();
    _openValues.clear();
    _closeValues.clear();
    _dashArray = null;
    super.dispose();
  }
}
