import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../l10n/app_localizations.dart';
import '../theme/brand_colors.dart';
import 'social_links.dart';

const _glyph = 20.0;

/// The nine brand marks, wrapped so they reflow rather than crush together
/// when the reader has enlarged the text.
class SocialRow extends StatelessWidget {
  const SocialRow({super.key, this.onOpen});

  /// Injected by tests so no browser is launched.
  final Future<bool> Function(Uri url)? onOpen;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 6,
      runSpacing: 6,
      children: [
        for (final link in socialLinks) _SocialIcon(link: link, onOpen: onOpen),
      ],
    );
  }
}

class _SocialIcon extends StatelessWidget {
  const _SocialIcon({required this.link, this.onOpen});

  final SocialLink link;
  final Future<bool> Function(Uri url)? onOpen;

  Future<void> _open(BuildContext context) async {
    final messenger = ScaffoldMessenger.maybeOf(context);
    final l10n = AppLocalizations.of(context);
    final launcher = onOpen ??
        (Uri url) => launchUrl(url, mode: LaunchMode.externalApplication);
    var opened = false;
    try {
      opened = await launcher(Uri.parse(link.url));
    } catch (_) {
      opened = false;
    }
    if (!opened) {
      messenger?.showSnackBar(
        SnackBar(content: Text(l10n.couldNotOpenLink(link.label))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final brand = context.brand;
    return Tooltip(
      message: link.label,
      child: Semantics(
        button: true,
        label: link.label,
        child: Material(
          color: brand.card,
          shape: CircleBorder(side: BorderSide(color: brand.cardBorder)),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () => _open(context),
            child: SizedBox(
              width: 44,
              height: 44,
              child: Center(child: _mark(brand.foreground)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _mark(Color ink) {
    switch (link.fill) {
      case BrandFill.solid:
        return FaIcon(link.icon, size: _glyph, color: link.resolve(ink));
      case BrandFill.gradient:
        return ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: instagramGradient.createShader,
          child: FaIcon(link.icon, size: _glyph, color: Colors.white),
        );
      case BrandFill.chromatic:
        return Stack(
          alignment: Alignment.center,
          children: [
            Transform.translate(
              offset: const Offset(-1.5, -1.5),
              child: FaIcon(link.icon, size: _glyph, color: tiktokCyan),
            ),
            Transform.translate(
              offset: const Offset(1.5, 1.5),
              child: FaIcon(link.icon, size: _glyph, color: tiktokMagenta),
            ),
            FaIcon(link.icon, size: _glyph, color: link.resolve(ink)),
          ],
        );
    }
  }
}
