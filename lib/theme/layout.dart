import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Where the page changes shape. The numbers follow Material's window size
/// classes, except that the rail only appears at [expanded]: a 600pt tablet
/// held upright still reads like a phone, and the bottom bar suits it.
abstract final class Breakpoints {
  static const double medium = 600;
  static const double expanded = 840;
  static const double wide = 1280;
}

enum LayoutSize { compact, medium, expanded, wide }

/// The one place that decides how wide a column of text may grow, how much
/// air sits at the edge of the page, and how many cards fit side by side.
///
/// Read it with `context.layout`. It measures the space the page was handed
/// — not the window — so a screen sitting beside the navigation rail knows
/// it is that much narrower.
@immutable
class Layout {
  const Layout(this.width, this.height);

  Layout.fromConstraints(BoxConstraints constraints)
      : width = constraints.maxWidth,
        height = constraints.maxHeight;

  /// The nearest measured page, or the window when nothing has measured one.
  factory Layout.of(BuildContext context) {
    final scope = LayoutScope.maybeOf(context);
    if (scope != null) return scope;
    final size = MediaQuery.sizeOf(context);
    return Layout(size.width, size.height);
  }

  final double width;
  final double height;

  LayoutSize get size {
    if (width >= Breakpoints.wide) return LayoutSize.wide;
    if (width >= Breakpoints.expanded) return LayoutSize.expanded;
    if (width >= Breakpoints.medium) return LayoutSize.medium;
    return LayoutSize.compact;
  }

  bool get isCompact => size == LayoutSize.compact;
  bool get isAtLeastMedium => width >= Breakpoints.medium;
  bool get isAtLeastExpanded => width >= Breakpoints.expanded;

  /// A phone on its side, or a window squashed down to a strip. The hero on
  /// the home page has to give up some of its height here.
  bool get isShort => height.isFinite && height < 560;

  /// The rail replaces the bottom bar once there is room beside the page,
  /// which is also where a bottom bar starts to look marooned.
  bool get usesRail => isAtLeastExpanded;

  /// Labels beside the rail icons rather than under them.
  bool get usesExtendedRail => width >= Breakpoints.wide;

  /// The breathing room at the edge of a page.
  double get gutter => switch (size) {
        LayoutSize.compact => 20,
        LayoutSize.medium => 28,
        LayoutSize.expanded => 32,
        LayoutSize.wide => 40,
      };

  /// How wide a single column of prose may become. Past roughly this, the
  /// eye loses its way back to the start of the next line.
  double get readingWidth => 720;

  /// How wide a page of cards or rows may become.
  double get contentWidth => 1080;

  /// Side padding that centres a column of at most [maxWidth] and never
  /// leaves it less than the page gutter.
  double sideInset([double? maxWidth]) =>
      math.max(gutter, (width - (maxWidth ?? readingWidth)) / 2);

  /// Symmetric page padding, centred the same way.
  EdgeInsets pagePadding({
    double? maxWidth,
    double top = 0,
    double bottom = 0,
  }) {
    final side = sideInset(maxWidth);
    return EdgeInsets.fromLTRB(side, top, side, bottom);
  }

  /// Cards laid out in columns once a single column would leave them
  /// stretched across the page.
  int columnsFor({double tile = 420, double? maxWidth}) {
    final usable = math.min(width - gutter * 2, maxWidth ?? contentWidth);
    return math.max(1, usable ~/ tile);
  }

  @override
  bool operator ==(Object other) =>
      other is Layout && other.width == width && other.height == height;

  @override
  int get hashCode => Object.hash(width, height);

  @override
  String toString() => 'Layout(${width}x$height, ${size.name})';
}

/// Publishes the measurement taken by [LayoutBoundary].
class LayoutScope extends InheritedWidget {
  const LayoutScope({
    super.key,
    required this.layout,
    required super.child,
  });

  final Layout layout;

  static Layout? maybeOf(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<LayoutScope>()
      ?.layout;

  @override
  bool updateShouldNotify(LayoutScope oldWidget) => oldWidget.layout != layout;
}

/// Measures the room a page actually has and hands it to everything below.
///
/// The window is the wrong ruler once a navigation rail stands beside the
/// page: the page is that much narrower, and its gutters and columns have to
/// be worked out from what is left.
class LayoutBoundary extends StatelessWidget {
  const LayoutBoundary({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => LayoutScope(
        layout: Layout.fromConstraints(constraints),
        child: child,
      ),
    );
  }
}

extension LayoutContext on BuildContext {
  Layout get layout => Layout.of(this);
}

/// Centres a page and stops it from stretching. Use it around anything that
/// is not itself a scroll view — a scroll view takes [Layout.pagePadding]
/// instead, so its scrollbar stays at the edge of the screen.
class PageWidth extends StatelessWidget {
  const PageWidth({super.key, required this.child, this.maxWidth});

  final Widget child;
  final double? maxWidth;

  @override
  Widget build(BuildContext context) {
    final layout = context.layout;
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? layout.readingWidth,
        ),
        child: child,
      ),
    );
  }
}
