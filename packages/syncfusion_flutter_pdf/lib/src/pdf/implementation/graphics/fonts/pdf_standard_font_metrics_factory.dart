import 'enums.dart';
import 'pdf_font.dart';
import 'pdf_font_metrics.dart';

/// Factory of the standard fonts metrics.
class PdfStandardFontMetricsFactory {
  /// internal constructor
  PdfStandardFontMetricsFactory();

  /// Multiplier os subscript superscript.
  static const double _subSuperscriptFactor = 1.52;

  /// Ascender value for the font.
  static const double _helveticaAscent = 931;

  /// Ascender value for the font.
  static const double _helveticaDescent = -225;

  /// Font type
  static const String _helveticaName = 'Helvetica';

  /// Ascender value for the font.
  static const double _helveticaBoldAscent = 962;

  /// Ascender value for the font.
  final double _helveticaBoldDescent = -228;

  /// Font type
  static const String _helveticaBoldName = 'Helvetica-Bold';

  /// Ascender value for the font.
  static const double _helveticaItalicAscent = 931;

  /// Ascender value for the font.
  static const double _helveticaItalicDescent = -225;

  /// Font type
  static const String _helveticaItalicName = 'Helvetica-Oblique';

  /// Ascender value for the font.
  static const double _helveticaBoldItalicAscent = 962;

  /// Ascender value for the font.
  static const double _helveticaBoldItalicDescent = -228;

  /// Font type
  static const String _helveticaBoldItalicName = 'Helvetica-BoldOblique';

  /// Ascender value for the font.
  static const double _courierAscent = 805;

  /// Ascender value for the font.
  static const double _courierDescent = -250;

  /// Font type.
  static const String _courierName = 'Courier';

  /// Ascender value for the font.
  static const double _courierBoldAscent = 801;

  /// Ascender value for the font.
  static const double _courierBoldDescent = -250;

  /// Font type.
  static const String _courierBoldName = 'Courier-Bold';

  /// Ascender value for the font.
  static const double _courierItalicAscent = 805;

  /// Ascender value for the font.
  static const double _courierItalicDescent = -250;

  /// Font type.
  static const String _courierItalicName = 'Courier-Oblique';

  /// Ascender value for the font.
  static const double _courierBoldItalicAscent = 801;

  /// Ascender value for the font.
  static const double _courierBoldItalicDescent = -250;

  /// Font type.
  static const String _courierBoldItalicName = 'Courier-BoldOblique';

  /// Ascender value for the font.
  static const double _timesAscent = 898;

  /// Ascender value for the font.
  static const double _timesDescent = -218;

  /// Font type.
  static const String _timesName = 'Times-Roman';

  /// Ascender value for the font.
  static const double _timesBoldAscent = 935;

  /// Ascender value for the font.
  static const double _timesBoldDescent = -218;

  /// Font type.
  static const String _timesBoldName = 'Times-Bold';

  /// Ascender value for the font.
  static const double _timesItalicAscent = 883;

  /// Ascender value for the font.
  static const double _timesItalicDescent = -217;

  /// Font type.
  static const String _timesItalicName = 'Times-Italic';

  /// Ascender value for the font.
  static const double _timesBoldItalicAscent = 921;

  /// Ascender value for the font.
  static const double _timesBoldItalicDescent = -218;

  /// Font type.
  static const String _timesBoldItalicName = 'Times-BoldItalic';

  /// Ascender value for the font.
  static const double _symbolAscent = 1010;

  /// Ascender value for the font.
  static const double _symbolDescent = -293;

  /// Font type.
  static const String _symbolName = 'Symbol';

  /// Ascender value for the font.
  static const double _zapfDingbatsAscent = 820;

  /// Ascender value for the font.
  static const double _zapfDingbatsDescent = -143;

  /// Font type.
  static const String _zapfDingbatsName = 'ZapfDingbats';

  /// Returns metrics of the font.
  static PdfFontMetrics getMetrics(
      PdfFontFamily? fontFamily, int? fontStyle, double size) {
    PdfFontMetrics metrics;
    switch (fontFamily) {
      case PdfFontFamily.helvetica:
        metrics = _getHelveticaMetrics(fontFamily, fontStyle!, size);
        break;
      case PdfFontFamily.courier:
        metrics = _getCourierMetrics(fontFamily, fontStyle!, size);
        break;
      case PdfFontFamily.timesRoman:
        metrics = _getTimesMetrics(fontFamily, fontStyle!, size);
        break;
      case PdfFontFamily.symbol:
        metrics = _getSymbolMetrics(fontFamily, size);
        break;
      case PdfFontFamily.zapfDingbats:
        metrics = _getZapfDingbatsMetrics(fontFamily, size);
        break;
      // ignore: no_default_cases
      default:
        metrics =
            _getHelveticaMetrics(PdfFontFamily.helvetica, fontStyle!, size);
        break;
    }
    metrics.name = PdfFontHelper.standardFontNames[fontFamily!.index];
    metrics.subscriptSizeFactor = _subSuperscriptFactor;
    metrics.superscriptSizeFactor = _subSuperscriptFactor;
    return metrics;
  }

  /// Creates Helvetica font metrics.
  static PdfFontMetrics _getHelveticaMetrics(
      PdfFontFamily? fontFamily, int fontStyle, double size) {
    final PdfFontMetrics metrics = PdfFontMetrics();
    final PdfStandardFontMetricsFactory standardFontMetricsFactory =
        PdfStandardFontMetricsFactory();
    if (fontStyle & PdfFontHelper.getPdfFontStyle(PdfFontStyle.bold) > 0 &&
        fontStyle & PdfFontHelper.getPdfFontStyle(PdfFontStyle.italic) > 0) {
      metrics.ascent = _helveticaBoldItalicAscent;
      metrics.descent = _helveticaBoldItalicDescent;
      metrics.postScriptName = _helveticaBoldItalicName;
      metrics.size = size;
      metrics.widthTable =
          StandardWidthTable(_StandardFontWidth._arialBoldWidth);
      metrics.height = metrics.ascent - metrics.descent;
    } else if (fontStyle & PdfFontHelper.getPdfFontStyle(PdfFontStyle.bold) >
        0) {
      metrics.ascent = _helveticaBoldAscent;
      metrics.descent = standardFontMetricsFactory._helveticaBoldDescent;
      metrics.postScriptName = _helveticaBoldName;
      metrics.size = size;
      metrics.widthTable =
          StandardWidthTable(_StandardFontWidth._arialBoldWidth);
      metrics.height = metrics.ascent - metrics.descent;
    } else if (fontStyle & PdfFontHelper.getPdfFontStyle(PdfFontStyle.italic) >
        0) {
      metrics.ascent = _helveticaItalicAscent;
      metrics.descent = _helveticaItalicDescent;
      metrics.postScriptName = _helveticaItalicName;
      metrics.size = size;
      metrics.widthTable = StandardWidthTable(_StandardFontWidth._arialWidth);
      metrics.height = metrics.ascent - metrics.descent;
    } else {
      metrics.ascent = _helveticaAscent;
      metrics.descent = _helveticaDescent;
      metrics.postScriptName = _helveticaName;
      metrics.size = size;
      metrics.widthTable = StandardWidthTable(_StandardFontWidth._arialWidth);
      metrics.height = metrics.ascent - metrics.descent;
    }
    return metrics;
  }

  /// Creates Courier font metrics.
  static PdfFontMetrics _getCourierMetrics(
      PdfFontFamily? fontFamily, int fontStyle, double size) {
    final PdfFontMetrics metrics = PdfFontMetrics();
    if (fontStyle & PdfFontHelper.getPdfFontStyle(PdfFontStyle.bold) > 0 &&
        fontStyle & PdfFontHelper.getPdfFontStyle(PdfFontStyle.italic) > 0) {
      metrics.ascent = _courierBoldItalicAscent;
      metrics.descent = _courierBoldItalicDescent;
      metrics.postScriptName = _courierBoldItalicName;
      metrics.size = size;
      metrics.widthTable = StandardWidthTable(_StandardFontWidth._fixedWidth);
      metrics.height = metrics.ascent - metrics.descent;
    } else if (fontStyle & PdfFontHelper.getPdfFontStyle(PdfFontStyle.bold) >
        0) {
      metrics.ascent = _courierBoldAscent;
      metrics.descent = _courierBoldDescent;
      metrics.postScriptName = _courierBoldName;
      metrics.size = size;
      metrics.widthTable = StandardWidthTable(_StandardFontWidth._fixedWidth);
      metrics.height = metrics.ascent - metrics.descent;
    } else if (fontStyle & PdfFontHelper.getPdfFontStyle(PdfFontStyle.italic) >
        0) {
      metrics.ascent = _courierItalicAscent;
      metrics.descent = _courierItalicDescent;
      metrics.postScriptName = _courierItalicName;
      metrics.size = size;
      metrics.widthTable = StandardWidthTable(_StandardFontWidth._fixedWidth);
      metrics.height = metrics.ascent - metrics.descent;
    } else {
      metrics.ascent = _courierAscent;
      metrics.descent = _courierDescent;
      metrics.postScriptName = _courierName;
      metrics.size = size;
      metrics.widthTable = StandardWidthTable(_StandardFontWidth._fixedWidth);
      metrics.height = metrics.ascent - metrics.descent;
    }
    return metrics;
  }

  /// Creates Times font metrics.
  static PdfFontMetrics _getTimesMetrics(
      PdfFontFamily? fontFamily, int fontStyle, double size) {
    final PdfFontMetrics metrics = PdfFontMetrics();
    if (fontStyle & PdfFontHelper.getPdfFontStyle(PdfFontStyle.bold) > 0 &&
        fontStyle & PdfFontHelper.getPdfFontStyle(PdfFontStyle.italic) > 0) {
      metrics.ascent = _timesBoldItalicAscent;
      metrics.descent = _timesBoldItalicDescent;
      metrics.postScriptName = _timesBoldItalicName;
      metrics.size = size;
      metrics.widthTable =
          StandardWidthTable(_StandardFontWidth._timesRomanBoldItalicWidth);
      metrics.height = metrics.ascent - metrics.descent;
    } else if (fontStyle & PdfFontHelper.getPdfFontStyle(PdfFontStyle.bold) >
        0) {
      metrics.ascent = _timesBoldAscent;
      metrics.descent = _timesBoldDescent;
      metrics.postScriptName = _timesBoldName;
      metrics.size = size;
      metrics.widthTable =
          StandardWidthTable(_StandardFontWidth._timesRomanBoldWidth);
      metrics.height = metrics.ascent - metrics.descent;
    } else if (fontStyle & PdfFontHelper.getPdfFontStyle(PdfFontStyle.italic) >
        0) {
      metrics.ascent = _timesItalicAscent;
      metrics.descent = _timesItalicDescent;
      metrics.postScriptName = _timesItalicName;
      metrics.size = size;
      metrics.widthTable =
          StandardWidthTable(_StandardFontWidth._timesRomanItalicWidth);
      metrics.height = metrics.ascent - metrics.descent;
    } else {
      metrics.ascent = _timesAscent;
      metrics.descent = _timesDescent;
      metrics.postScriptName = _timesName;
      metrics.size = size;
      metrics.widthTable =
          StandardWidthTable(_StandardFontWidth._timesRomanWidth);
      metrics.height = metrics.ascent - metrics.descent;
    }
    return metrics;
  }

  /// Creates Symbol font metrics.
  static PdfFontMetrics _getSymbolMetrics(
      PdfFontFamily? fontFamily, double size) {
    final PdfFontMetrics metrics = PdfFontMetrics();

    metrics.ascent = _symbolAscent;
    metrics.descent = _symbolDescent;
    metrics.postScriptName = _symbolName;
    metrics.size = size;
    metrics.widthTable = StandardWidthTable(_StandardFontWidth._symbolWidth);
    metrics.height = metrics.ascent - metrics.descent;
    return metrics;
  }

  /// Creates ZapfDingbats font metrics.
  static PdfFontMetrics _getZapfDingbatsMetrics(
      PdfFontFamily? fontFamily, double size) {
    final PdfFontMetrics metrics = PdfFontMetrics();
    metrics.ascent = _zapfDingbatsAscent;
    metrics.descent = _zapfDingbatsDescent;
    metrics.postScriptName = _zapfDingbatsName;
    metrics.size = size;
    metrics.widthTable =
        StandardWidthTable(_StandardFontWidth._zapfDingbatsWidth);
    metrics.height = metrics.ascent - metrics.descent;
    return metrics;
  }
}

class _StandardFontWidth {
  static const List<int> _arialWidth = <int>[
    278,
    278,
    355,
    556,
    556,
    889,
    667,
    191,
    333,
    333,
    389,
    584,
    278,
    333,
    278,
    278,
    556,
    556,
    556,
    556,
    556,
    556,
    556,
    556,
    556,
    556,
    278,
    278,
    584,
    584,
    584,
    556,
    1015,
    667,
    667,
    722,
    722,
    667,
    611,
    778,
    722,
    278,
    500,
    667,
    556,
    833,
    722,
    778,
    667,
    778,
    722,
    667,
    611,
    722,
    667,
    944,
    667,
    667,
    611,
    278,
    278,
    278,
    469,
    556,
    333,
    556,
    556,
    500,
    556,
    556,
    278,
    556,
    556,
    222,
    222,
    500,
    222,
    833,
    556,
    556,
    556,
    556,
    333,
    500,
    278,
    556,
    500,
    722,
    500,
    500,
    500,
    334,
    260,
    334,
    584,
    0,
    556,
    0,
    222,
    556,
    333,
    1000,
    556,
    556,
    333,
    1000,
    667,
    333,
    1000,
    0,
    611,
    0,
    0,
    222,
    222,
    333,
    333,
    350,
    556,
    1000,
    333,
    1000,
    500,
    333,
    944,
    0,
    500,
    667,
    0,
    333,
    556,
    556,
    556,
    556,
    260,
    556,
    333,
    737,
    370,
    556,
    584,
    0,
    737,
    333,
    400,
    584,
    333,
    333,
    333,
    556,
    537,
    278,
    333,
    333,
    365,
    556,
    834,
    834,
    834,
    611,
    667,
    667,
    667,
    667,
    667,
    667,
    1000,
    722,
    667,
    667,
    667,
    667,
    278,
    278,
    278,
    278,
    722,
    722,
    778,
    778,
    778,
    778,
    778,
    584,
    778,
    722,
    722,
    722,
    722,
    667,
    667,
    611,
    556,
    556,
    556,
    556,
    556,
    556,
    889,
    500,
    556,
    556,
    556,
    556,
    278,
    278,
    278,
    278,
    556,
    556,
    556,
    556,
    556,
    556,
    556,
    584,
    611,
    556,
    556,
    556,
    556,
    500,
    556,
    500
  ];
  static const List<int> _arialBoldWidth = <int>[
    278,
    333,
    474,
    556,
    556,
    889,
    722,
    238,
    333,
    333,
    389,
    584,
    278,
    333,
    278,
    278,
    556,
    556,
    556,
    556,
    556,
    556,
    556,
    556,
    556,
    556,
    333,
    333,
    584,
    584,
    584,
    611,
    975,
    722,
    722,
    722,
    722,
    667,
    611,
    778,
    722,
    278,
    556,
    722,
    611,
    833,
    722,
    778,
    667,
    778,
    722,
    667,
    611,
    722,
    667,
    944,
    667,
    667,
    611,
    333,
    278,
    333,
    584,
    556,
    333,
    556,
    611,
    556,
    611,
    556,
    333,
    611,
    611,
    278,
    278,
    556,
    278,
    889,
    611,
    611,
    611,
    611,
    389,
    556,
    333,
    611,
    556,
    778,
    556,
    556,
    500,
    389,
    280,
    389,
    584,
    0,
    556,
    0,
    278,
    556,
    500,
    1000,
    556,
    556,
    333,
    1000,
    667,
    333,
    1000,
    0,
    611,
    0,
    0,
    278,
    278,
    500,
    500,
    350,
    556,
    1000,
    333,
    1000,
    556,
    333,
    944,
    0,
    500,
    667,
    0,
    333,
    556,
    556,
    556,
    556,
    280,
    556,
    333,
    737,
    370,
    556,
    584,
    0,
    737,
    333,
    400,
    584,
    333,
    333,
    333,
    611,
    556,
    278,
    333,
    333,
    365,
    556,
    834,
    834,
    834,
    611,
    722,
    722,
    722,
    722,
    722,
    722,
    1000,
    722,
    667,
    667,
    667,
    667,
    278,
    278,
    278,
    278,
    722,
    722,
    778,
    778,
    778,
    778,
    778,
    584,
    778,
    722,
    722,
    722,
    722,
    667,
    667,
    611,
    556,
    556,
    556,
    556,
    556,
    556,
    889,
    556,
    556,
    556,
    556,
    556,
    278,
    278,
    278,
    278,
    611,
    611,
    611,
    611,
    611,
    611,
    611,
    584,
    611,
    611,
    611,
    611,
    611,
    556,
    611,
    556
  ];
  static const List<int> _fixedWidth = <int>[
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600,
    600
  ];
  static const List<int> _timesRomanWidth = <int>[
    250,
    333,
    408,
    500,
    500,
    833,
    778,
    180,
    333,
    333,
    500,
    564,
    250,
    333,
    250,
    278,
    500,
    500,
    500,
    500,
    500,
    500,
    500,
    500,
    500,
    500,
    278,
    278,
    564,
    564,
    564,
    444,
    921,
    722,
    667,
    667,
    722,
    611,
    556,
    722,
    722,
    333,
    389,
    722,
    611,
    889,
    722,
    722,
    556,
    722,
    667,
    556,
    611,
    722,
    722,
    944,
    722,
    722,
    611,
    333,
    278,
    333,
    469,
    500,
    333,
    444,
    500,
    444,
    500,
    444,
    333,
    500,
    500,
    278,
    278,
    500,
    278,
    778,
    500,
    500,
    500,
    500,
    333,
    389,
    278,
    500,
    500,
    722,
    500,
    500,
    444,
    480,
    200,
    480,
    541,
    000,
    500,
    000,
    333,
    500,
    444,
    1000,
    500,
    500,
    333,
    1000,
    556,
    333,
    889,
    0,
    611,
    000,
    000,
    333,
    333,
    444,
    444,
    350,
    500,
    1000,
    333,
    980,
    389,
    333,
    722,
    0,
    444,
    722,
    000,
    333,
    500,
    500,
    500,
    500,
    200,
    500,
    333,
    760,
    276,
    500,
    564,
    0,
    760,
    333,
    400,
    564,
    300,
    300,
    333,
    500,
    453,
    250,
    333,
    300,
    310,
    500,
    750,
    750,
    750,
    444,
    722,
    722,
    722,
    722,
    722,
    722,
    889,
    667,
    611,
    611,
    611,
    611,
    333,
    333,
    333,
    333,
    722,
    722,
    722,
    722,
    722,
    722,
    722,
    564,
    722,
    722,
    722,
    722,
    722,
    722,
    556,
    500,
    444,
    444,
    444,
    444,
    444,
    444,
    667,
    444,
    444,
    444,
    444,
    444,
    278,
    278,
    278,
    278,
    500,
    500,
    500,
    500,
    500,
    500,
    500,
    564,
    500,
    500,
    500,
    500,
    500,
    500,
    500,
    500
  ];
  static const List<int> _timesRomanBoldWidth = <int>[
    250,
    333,
    555,
    500,
    500,
    1000,
    833,
    278,
    333,
    333,
    500,
    570,
    250,
    333,
    250,
    278,
    500,
    500,
    500,
    500,
    500,
    500,
    500,
    500,
    500,
    500,
    333,
    333,
    570,
    570,
    570,
    500,
    930,
    722,
    667,
    722,
    722,
    667,
    611,
    778,
    778,
    389,
    500,
    778,
    667,
    944,
    722,
    778,
    611,
    778,
    722,
    556,
    667,
    722,
    722,
    1000,
    722,
    722,
    667,
    333,
    278,
    333,
    581,
    500,
    333,
    500,
    556,
    444,
    556,
    444,
    333,
    500,
    556,
    278,
    333,
    556,
    278,
    833,
    556,
    500,
    556,
    556,
    444,
    389,
    333,
    556,
    500,
    722,
    500,
    500,
    444,
    394,
    220,
    394,
    520,
    0,
    500,
    0,
    333,
    500,
    500,
    1000,
    500,
    500,
    333,
    1000,
    556,
    333,
    1000,
    0,
    667,
    0,
    0,
    333,
    333,
    500,
    500,
    350,
    500,
    1000,
    333,
    1000,
    389,
    333,
    722,
    0,
    444,
    722,
    0,
    333,
    500,
    500,
    500,
    500,
    220,
    500,
    333,
    747,
    300,
    500,
    570,
    0,
    747,
    333,
    400,
    570,
    300,
    300,
    333,
    556,
    540,
    250,
    333,
    300,
    330,
    500,
    750,
    750,
    750,
    500,
    722,
    722,
    722,
    722,
    722,
    722,
    1000,
    722,
    667,
    667,
    667,
    667,
    389,
    389,
    389,
    389,
    722,
    722,
    778,
    778,
    778,
    778,
    778,
    570,
    778,
    722,
    722,
    722,
    722,
    722,
    611,
    556,
    500,
    500,
    500,
    500,
    500,
    500,
    722,
    444,
    444,
    444,
    444,
    444,
    278,
    278,
    278,
    278,
    500,
    556,
    500,
    500,
    500,
    500,
    500,
    570,
    500,
    556,
    556,
    556,
    556,
    500,
    556,
    500
  ];
  static const List<int> _timesRomanItalicWidth = <int>[
    250,
    333,
    420,
    500,
    500,
    833,
    778,
    214,
    333,
    333,
    500,
    675,
    250,
    333,
    250,
    278,
    500,
    500,
    500,
    500,
    500,
    500,
    500,
    500,
    500,
    500,
    333,
    333,
    675,
    675,
    675,
    500,
    920,
    611,
    611,
    667,
    722,
    611,
    611,
    722,
    722,
    333,
    444,
    667,
    556,
    833,
    667,
    722,
    611,
    722,
    611,
    500,
    556,
    722,
    611,
    833,
    611,
    556,
    556,
    389,
    278,
    389,
    422,
    500,
    333,
    500,
    500,
    444,
    500,
    444,
    278,
    500,
    500,
    278,
    278,
    444,
    278,
    722,
    500,
    500,
    500,
    500,
    389,
    389,
    278,
    500,
    444,
    667,
    444,
    444,
    389,
    400,
    275,
    400,
    541,
    0,
    500,
    0,
    333,
    500,
    556,
    889,
    500,
    500,
    333,
    1000,
    500,
    333,
    944,
    0,
    556,
    0,
    0,
    333,
    333,
    556,
    556,
    350,
    500,
    889,
    333,
    980,
    389,
    333,
    667,
    0,
    389,
    556,
    0,
    389,
    500,
    500,
    500,
    500,
    275,
    500,
    333,
    760,
    276,
    500,
    675,
    0,
    760,
    333,
    400,
    675,
    300,
    300,
    333,
    500,
    523,
    250,
    333,
    300,
    310,
    500,
    750,
    750,
    750,
    500,
    611,
    611,
    611,
    611,
    611,
    611,
    889,
    667,
    611,
    611,
    611,
    611,
    333,
    333,
    333,
    333,
    722,
    667,
    722,
    722,
    722,
    722,
    722,
    675,
    722,
    722,
    722,
    722,
    722,
    556,
    611,
    500,
    500,
    500,
    500,
    500,
    500,
    500,
    667,
    444,
    444,
    444,
    444,
    444,
    278,
    278,
    278,
    278,
    500,
    500,
    500,
    500,
    500,
    500,
    500,
    675,
    500,
    500,
    500,
    500,
    500,
    444,
    500,
    444
  ];
  static const List<int> _timesRomanBoldItalicWidth = <int>[
    250,
    389,
    555,
    500,
    500,
    833,
    778,
    278,
    333,
    333,
    500,
    570,
    250,
    333,
    250,
    278,
    500,
    500,
    500,
    500,
    500,
    500,
    500,
    500,
    500,
    500,
    333,
    333,
    570,
    570,
    570,
    500,
    832,
    667,
    667,
    667,
    722,
    667,
    667,
    722,
    778,
    389,
    500,
    667,
    611,
    889,
    722,
    722,
    611,
    722,
    667,
    556,
    611,
    722,
    667,
    889,
    667,
    611,
    611,
    333,
    278,
    333,
    570,
    500,
    333,
    500,
    500,
    444,
    500,
    444,
    333,
    500,
    556,
    278,
    278,
    500,
    278,
    778,
    556,
    500,
    500,
    500,
    389,
    389,
    278,
    556,
    444,
    667,
    500,
    444,
    389,
    348,
    220,
    348,
    570,
    0,
    500,
    0,
    333,
    500,
    500,
    1000,
    500,
    500,
    333,
    1000,
    556,
    333,
    944,
    0,
    611,
    0,
    0,
    333,
    333,
    500,
    500,
    350,
    500,
    1000,
    333,
    1000,
    389,
    333,
    722,
    0,
    389,
    611,
    0,
    389,
    500,
    500,
    500,
    500,
    220,
    500,
    333,
    747,
    266,
    500,
    606,
    0,
    747,
    333,
    400,
    570,
    300,
    300,
    333,
    576,
    500,
    250,
    333,
    300,
    300,
    500,
    750,
    750,
    750,
    500,
    667,
    667,
    667,
    667,
    667,
    667,
    944,
    667,
    667,
    667,
    667,
    667,
    389,
    389,
    389,
    389,
    722,
    722,
    722,
    722,
    722,
    722,
    722,
    570,
    722,
    722,
    722,
    722,
    722,
    611,
    611,
    500,
    500,
    500,
    500,
    500,
    500,
    500,
    722,
    444,
    444,
    444,
    444,
    444,
    278,
    278,
    278,
    278,
    500,
    556,
    500,
    500,
    500,
    500,
    500,
    570,
    500,
    556,
    556,
    556,
    556,
    444,
    500,
    444
  ];
  static const List<int> _symbolWidth = <int>[
    250,
    333,
    713,
    500,
    549,
    833,
    778,
    439,
    333,
    333,
    500,
    549,
    250,
    549,
    250,
    278,
    500,
    500,
    500,
    500,
    500,
    500,
    500,
    500,
    500,
    500,
    278,
    278,
    549,
    549,
    549,
    444,
    549,
    722,
    667,
    722,
    612,
    611,
    763,
    603,
    722,
    333,
    631,
    722,
    686,
    889,
    722,
    722,
    768,
    741,
    556,
    592,
    611,
    690,
    439,
    768,
    645,
    795,
    611,
    333,
    863,
    333,
    658,
    500,
    500,
    631,
    549,
    549,
    494,
    439,
    521,
    411,
    603,
    329,
    603,
    549,
    549,
    576,
    521,
    549,
    549,
    521,
    549,
    603,
    439,
    576,
    713,
    686,
    493,
    686,
    494,
    480,
    200,
    480,
    549,
    750,
    620,
    247,
    549,
    167,
    713,
    500,
    753,
    753,
    753,
    753,
    1042,
    987,
    603,
    987,
    603,
    400,
    549,
    411,
    549,
    549,
    713,
    494,
    460,
    549,
    549,
    549,
    549,
    1000,
    603,
    1000,
    658,
    823,
    686,
    795,
    987,
    768,
    768,
    823,
    768,
    768,
    713,
    713,
    713,
    713,
    713,
    713,
    713,
    768,
    713,
    790,
    790,
    890,
    823,
    549,
    250,
    713,
    603,
    603,
    1042,
    987,
    603,
    987,
    603,
    494,
    329,
    790,
    790,
    786,
    713,
    384,
    384,
    384,
    384,
    384,
    384,
    494,
    494,
    494,
    494,
    329,
    274,
    686,
    686,
    686,
    384,
    384,
    384,
    384,
    384,
    384,
    494,
    494,
    494,
    -1
  ];
  static const List<int> _zapfDingbatsWidth = <int>[
    278,
    974,
    961,
    974,
    980,
    719,
    789,
    790,
    791,
    690,
    960,
    939,
    549,
    855,
    911,
    933,
    911,
    945,
    974,
    755,
    846,
    762,
    761,
    571,
    677,
    763,
    760,
    759,
    754,
    494,
    552,
    537,
    577,
    692,
    786,
    788,
    788,
    790,
    793,
    794,
    816,
    823,
    789,
    841,
    823,
    833,
    816,
    831,
    923,
    744,
    723,
    749,
    790,
    792,
    695,
    776,
    768,
    792,
    759,
    707,
    708,
    682,
    701,
    826,
    815,
    789,
    789,
    707,
    687,
    696,
    689,
    786,
    787,
    713,
    791,
    785,
    791,
    873,
    761,
    762,
    762,
    759,
    759,
    892,
    892,
    788,
    784,
    438,
    138,
    277,
    415,
    392,
    392,
    668,
    668,
    390,
    390,
    317,
    317,
    276,
    276,
    509,
    509,
    410,
    410,
    234,
    234,
    334,
    334,
    732,
    544,
    544,
    910,
    667,
    760,
    760,
    776,
    595,
    694,
    626,
    788,
    788,
    788,
    788,
    788,
    788,
    788,
    788,
    788,
    788,
    788,
    788,
    788,
    788,
    788,
    788,
    788,
    788,
    788,
    788,
    788,
    788,
    788,
    788,
    788,
    788,
    788,
    788,
    788,
    788,
    788,
    788,
    788,
    788,
    788,
    788,
    788,
    788,
    788,
    788,
    894,
    838,
    1016,
    458,
    748,
    924,
    748,
    918,
    927,
    928,
    928,
    834,
    873,
    828,
    924,
    924,
    917,
    930,
    931,
    463,
    883,
    836,
    836,
    867,
    867,
    696,
    696,
    874,
    874,
    760,
    946,
    771,
    865,
    771,
    888,
    967,
    888,
    831,
    873,
    927,
    970,
    918
  ];
}
