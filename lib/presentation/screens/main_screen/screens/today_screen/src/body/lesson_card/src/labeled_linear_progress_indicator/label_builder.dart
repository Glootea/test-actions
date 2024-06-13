part of 'labeled_linear_progress_indicator.dart';

class _LabelBuilder extends LeafRenderObjectWidget {
  const _LabelBuilder({
    required this.message,
    required this.style,
    this.value,
    this.valuePresentation,
    this.expandIcon,
    this.iconSize,
  });
  final String? message;
  final String? valuePresentation;
  final double? value;
  final TextStyle? style;
  final IconData? expandIcon;
  final double? iconSize;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _LabelRenderObject(
      message: message,
      value: value,
      valuePresentation: valuePresentation,
      style: style,
      expandIcon: expandIcon,
      iconSize: iconSize,
    );
  }

  @override
  void updateRenderObject(BuildContext context, _LabelRenderObject renderObject) {
    renderObject
      ..message = message
      ..value = value
      ..style = style
      ..valuePresentation = valuePresentation
      ..expandIcon = expandIcon;
    super.updateRenderObject(context, renderObject);
  }
}

class _LabelRenderObject extends RenderBox {
  _LabelRenderObject({
    required String? message,
    required double? value,
    required String? valuePresentation,
    required TextStyle? style,
    required IconData? expandIcon,
    required double? iconSize,
  }) {
    _message = message;
    _value = value;
    _style = style;
    _valuePresentation = valuePresentation;
    _messagePainter = TextPainter(text: messageTextSpan, textDirection: TextDirection.ltr);
    _valuePainter = TextPainter(text: valueTextSpan, textDirection: TextDirection.ltr);
    _expandIcon = expandIcon;
    _iconSize = iconSize;
    if (_iconSize != null && _expandIcon != null) {
      _iconPainter = TextPainter(text: iconTextSpan, textDirection: TextDirection.ltr);
    }
  }
  late String? _message;
  late double? _value;
  late String? _valuePresentation;
  late TextStyle? _style;

  late TextPainter _messagePainter;
  late TextPainter _valuePainter;

  late IconData? _expandIcon;
  late double? _iconSize;
  late TextPainter? _iconPainter;

  String? get message => _message;
  set message(String? value) {
    if (_message == value) return;
    _message = value;
    _messagePainter.text = messageTextSpan;
    markNeedsPaint();
    markNeedsLayout();
  }

  double? get value => _value;
  set value(double? value) {
    if (_value == value) return;
    _value = value;
    _valuePainter.text = valueTextSpan;
    markNeedsPaint();
    markNeedsLayout();
  }

  String? get valuePresentation => _valuePresentation;
  set valuePresentation(String? value) {
    if (_valuePresentation == value) return;
    _valuePresentation = value;
    _valuePainter.text = valueTextSpan;
    markNeedsPaint();
    markNeedsLayout();
  }

  TextStyle? get style => _style;
  set style(TextStyle? value) {
    if (_style == value) return;
    _style = value;
    _messagePainter.text = messageTextSpan;
    _valuePainter.text = valueTextSpan;
    markNeedsPaint();
    markNeedsLayout();
  }

  IconData? get expandIcon => _expandIcon;
  set expandIcon(IconData? value) {
    if (_expandIcon == value) return;
    _expandIcon = value;
    markNeedsPaint();
    markNeedsLayout();
  }

  double? get iconSize => _iconSize;
  set iconSize(double? value) {
    if (_iconSize == value) return;
    _iconSize = value;
    _iconPainter = TextPainter(text: iconTextSpan, textDirection: TextDirection.ltr);
    markNeedsPaint();
    markNeedsLayout();
  }

  TextSpan get messageTextSpan => TextSpan(text: _message, style: _style);
  TextSpan get valueTextSpan => TextSpan(text: _valuePresentation, style: _style);
  TextSpan get iconTextSpan => TextSpan(
        text: String.fromCharCode(expandIcon!.codePoint),
        style: _style?.copyWith(fontSize: _iconSize, fontFamily: expandIcon!.fontFamily),
      );

  double _longestLineWidth = 0;
  late double _lineHeight = _iconSize ?? 24;
  int _numMessageLines = 0;
  bool _messageFitsLeft = true;
  double _valueWidth = 0;
  double _valuePosition = double.infinity;
  double _lastLineWidth = 0;
  bool _iconFitLastLine = true;
  double _messageHeight = 0;

  final double padding = 8;

  @override
  void performLayout() {
    if (_message != null) {
      _messagePainter.layout(maxWidth: constraints.maxWidth);
      final messageLines = _messagePainter.computeLineMetrics();
      _longestLineWidth = messageLines.reduce((a, b) => a.width > b.width ? a : b).width;
      _lineHeight = messageLines.first.height;
      _numMessageLines = messageLines.length;
      _lastLineWidth = messageLines.last.width;
    }

    if (_value == null || _valuePresentation == null) {
      _iconFitLastLine = _lastLineWidth < constraints.maxWidth - (_iconSize ?? 0) - padding;
      size = Size(
        constraints.maxWidth,
        padding + _lineHeight * (_numMessageLines + (_iconFitLastLine ? 0 : 1)),
      ); // TODO: will cause error
      return;
    } else {
      _valuePainter.layout(maxWidth: constraints.maxWidth);
      _valueWidth = _valuePainter.computeLineMetrics().first.width;
      _lineHeight = _lineHeight == 0 ? _valuePainter.computeLineMetrics().first.height : _lineHeight;
    }
    _valuePosition = _value! * constraints.maxWidth + _valueWidth;
    _messageFitsLeft = _longestLineWidth < _valuePosition - padding - _valueWidth;
    if (_iconSize != null) {
      var maxOcupiedWidth = 0.0;
      _iconPainter!.layout();
      if (_value != null || _valuePresentation != null) {
        maxOcupiedWidth = max(_valuePosition + _valueWidth, maxOcupiedWidth);
      }
      if (_message != null) {
        if (_numMessageLines > 1) {
          maxOcupiedWidth = _lastLineWidth;
        } else {
          maxOcupiedWidth = max(_lastLineWidth, maxOcupiedWidth);
        }
      }
      _iconFitLastLine = maxOcupiedWidth < constraints.maxWidth - _iconSize!;
    }

    final additionaLines = (_messageFitsLeft ? 0 : 1) + (_iconFitLastLine ? 0 : 1);
    _messageHeight = _lineHeight * (_numMessageLines + additionaLines);
    final computedSize = Size(constraints.maxWidth, _messageHeight);

    size = constraints.constrain(computedSize);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (_value != null && _valuePresentation != null) {
      _valuePosition = _value! * constraints.maxWidth - _valueWidth / 2;
      _valuePainter.paint(context.canvas, offset + Offset(_valuePosition, 0));
    }
    if (_message != null) {
      if (_messageFitsLeft) {
        _messagePainter.paint(context.canvas, offset + Offset(0, padding));
      } else {
        _messagePainter.paint(context.canvas, offset + Offset(0, _lineHeight));
      }
    }

    if (expandIcon != null && _iconSize != null && _iconPainter != null) {
      final initialIconHeight = (_messageFitsLeft ? padding : _lineHeight) +
          (_iconFitLastLine ? 0 : _lineHeight) +
          _lineHeight * _numMessageLines -
          _iconSize! / 2 -
          _lineHeight / 2;

      // if (_value == null) initialIconHeight += padding;

      _iconPainter!.paint(
        context.canvas,
        offset +
            Offset(
              constraints.maxWidth - _iconSize!,
              initialIconHeight,
            ),
      );
    }
  }
}
