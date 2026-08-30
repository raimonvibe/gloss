import 'package:flutter/material.dart';

/// The height a pill stands at with one line of words in it.
///
/// Measured rather than reckoned from the font size: a line is as tall as the
/// style's `height` and the reader's text size make it, and neither of those
/// is knowable from the number a call site passes for the size.
double _pillHeight(
  BuildContext context, {
  required TextStyle style,
  required double verticalPadding,
}) {
  // [Text] merges an inheriting style over the ambient one before it lays
  // anything out, and that is where a line's `height` usually comes from.
  final resolved =
      style.inherit ? DefaultTextStyle.of(context).style.merge(style) : style;
  final painter = TextPainter(
    text: TextSpan(text: 'Ag', style: resolved),
    textDirection: Directionality.of(context),
    textScaler: MediaQuery.textScalerOf(context),
    maxLines: 1,
  )..layout();
  final line = painter.height;
  painter.dispose();
  return line + verticalPadding * 2;
}

/// How far a pill may curve its ends without eating the words inside it.
///
/// A stadium's radius is half its height, which is right for the one line of
/// words a pill is drawn for and wrong for anything taller. Origin reads
/// "Greek" in English and "старафранцузская / англійская" in Belarusian, and
/// at the largest text size even a shrunk label takes two lines — at which
/// point the ends curve in far enough to cross the first line's first letter,
/// the same way a button's label ended up printed across the outside of its
/// own shape.
///
/// So a pill curves by the half-height it would have had with one line in it,
/// and no more. Flutter clamps a radius to half the smallest side, so this is
/// still a stadium while the words fit on one line, in any language and at any
/// text size; past that the ends stop growing and the shape settles into a
/// rounded rectangle that the words stay inside.
double pillRadius(
  BuildContext context, {
  required TextStyle style,
  required double verticalPadding,
}) =>
    _pillHeight(context, style: style, verticalPadding: verticalPadding) / 2;
