import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../state/speech_controller.dart';
import '../theme/brand_colors.dart';

/// Quiet listen/stop control. Matches [ThemeToggle]'s gold circle.
class SpeakButton extends StatelessWidget {
  const SpeakButton({
    super.key,
    required this.speechKey,
    required this.text,
    this.compact = false,
  });

  final String speechKey;
  final String text;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final speech = context.watch<SpeechController>();
    final brand = context.brand;
    final l10n = AppLocalizations.of(context);
    final active = speech.isSpeakingKey(speechKey);
    final label = active ? l10n.stop : l10n.listen;
    final icon = Icon(
      active ? Icons.stop_outlined : Icons.volume_up_outlined,
      color: brand.accentGold,
      size: compact ? 22 : 20,
    );

    if (compact) {
      return IconButton(
        tooltip: label,
        onPressed: () => speech.toggle(speechKey, text),
        icon: icon,
      );
    }

    return Tooltip(
      message: label,
      child: Material(
        color: brand.card,
        shape: CircleBorder(side: BorderSide(color: brand.cardBorder)),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: () => speech.toggle(speechKey, text),
          child: SizedBox(
            width: 42,
            height: 42,
            child: icon,
          ),
        ),
      ),
    );
  }
}

/// Stops speech when this route leaves the tree.
class StopSpeechOnExit extends StatefulWidget {
  const StopSpeechOnExit({super.key, required this.child});

  final Widget child;

  @override
  State<StopSpeechOnExit> createState() => _StopSpeechOnExitState();
}

class _StopSpeechOnExitState extends State<StopSpeechOnExit> {
  SpeechController? _speech;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _speech = context.read<SpeechController>();
  }

  @override
  void dispose() {
    _speech?.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
