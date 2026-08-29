import 'package:flutter/material.dart';

/// A button's words, fitted to the room the button actually has.
///
/// English says "See results" in eleven characters; German needs "Ergebnisse
/// ansehen", Hungarian "Eredmények megtekintése", and the button is the same
/// half of a phone in every one of the sixty languages. Left to itself the
/// label wraps onto a second line, which grows the pill, which grows the
/// radius of its rounded ends — and the words end up sitting outside the
/// shape they belong to.
///
/// So the label gives ground in the order that keeps a button looking like a
/// button: it shrinks a step at a time down to [minScale] of its font size to
/// stay on one line, and only takes a second line ([maxLines]) when even the
/// smallest step will not hold it. A whole word made smaller reads better on
/// a pill than a line broken in half.
class ButtonLabel extends StatelessWidget {
  const ButtonLabel(
    this.text, {
    super.key,
    this.style,
    this.maxLines = 2,
    this.minScale = 0.75,
  });

  final String text;

  /// Merged over the style the button already hands down, so a call site only
  /// names what it changes.
  final TextStyle? style;

  /// How many lines the label may take once shrinking has run out.
  final int maxLines;

  /// How far the font size may fall, as a fraction of what it started at.
  final double minScale;

  @override
  Widget build(BuildContext context) {
    final resolved = DefaultTextStyle.of(context).style.merge(style);
    final base = resolved.fontSize ?? 14;
    final scaler = MediaQuery.textScalerOf(context);
    final direction = Directionality.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        var fontSize = base;
        var lines = 1;

        if (width.isFinite && text.isNotEmpty) {
          final painter = TextPainter(
            textDirection: direction,
            textScaler: scaler,
            textAlign: TextAlign.center,
          );
          bool fits(double size, int lineCount) {
            painter
              ..text = TextSpan(text: text, style: resolved.copyWith(fontSize: size))
              ..maxLines = lineCount
              ..layout(maxWidth: width);
            return !painter.didExceedMaxLines && painter.width <= width;
          }

          final floor = base * minScale;
          // One line for as long as shrinking can pay for it.
          double? single;
          for (var size = base; size >= floor; size -= 0.5) {
            if (fits(size, 1)) {
              single = size;
              break;
            }
          }
          if (single != null) {
            fontSize = single;
          } else {
            // Even the smallest step will not hold it on one line, so spend
            // the allowance on lines instead and keep the type as large as
            // those lines allow.
            lines = maxLines;
            fontSize = floor;
            for (var size = base; size >= floor; size -= 0.5) {
              if (fits(size, maxLines)) {
                fontSize = size;
                break;
              }
            }
          }
          painter.dispose();
        }

        return Text(
          text,
          textAlign: TextAlign.center,
          maxLines: lines,
          overflow: TextOverflow.ellipsis,
          style: resolved.copyWith(fontSize: fontSize),
        );
      },
    );
  }
}
