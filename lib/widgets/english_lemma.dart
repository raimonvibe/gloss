import 'package:flutter/material.dart';

/// Keep English headwords, pronunciations, and etymons left-to-right
/// even when the rest of the UI is Arabic, Hebrew, or Urdu.
class EnglishLemma extends StatelessWidget {
  const EnglishLemma({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: child,
    );
  }
}
