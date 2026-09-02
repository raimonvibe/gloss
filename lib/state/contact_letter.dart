import 'dart:convert';
import 'dart:math' as math;

import 'package:http/http.dart' as http;

/// The letter the contact page composes, and everything about it that can be
/// decided without a screen.
///
/// The letter is posted to the same Formspree form the website's contact
/// page submits to, so a letter written on a phone files beside one written
/// in a browser rather than arriving in a shape of its own.
///
/// It is copied to the clipboard first and always, before anything is sent:
/// a post can fail for a hundred reasons a reader cannot see, and none of
/// them should cost them what they wrote. When the post does fail, the mail
/// composer below is the way out.

/// Where a letter goes when it cannot be posted. The address the Play
/// listing gives for support.
const kContactAddress = 'info@raimonvibe.com';

/// The website's own form id, from `src/app/contact/page.tsx`. It is public
/// in a browser bundle already, so it is no more exposed in an APK.
const kFormspreeForm = 'xwplqeky';

Uri get formspreeEndpoint => Uri.parse('https://formspree.io/f/$kFormspreeForm');

/// What Formspree is told, under the website form's own field names.
///
/// `category` and `priority` are sent in English however the page was
/// written: sixty languages of "Something is wrong" would leave an inbox
/// that cannot be sorted. What the reader wrote stays in their language, and
/// `language` says which one that is.
///
/// `_subject` is Formspree's own field for the subject line of the mail it
/// forwards; `email` is the one it uses as the reply-to.
Map<String, String> formspreeFields({
  required String name,
  required String email,
  required String reason,
  required String priority,
  required String message,
  required String language,
  String? details,
}) {
  return {
    'name': name.trim(),
    'email': email.trim(),
    'category': reason,
    'priority': priority,
    'message': message.trim(),
    'language': language,
    if (details != null && details.isNotEmpty) 'details': details,
    '_subject': 'Gloss — $reason',
  };
}

/// The English name of a reason, for the inbox rather than the reader.
///
/// Deliberately a second copy of what `app_en.arb` says: the ARB answers to
/// the reader's language, and this must not. Whichever of the sixty the page
/// is written in, a letter about a fault files under "Something is wrong".
String englishReason(ContactReason reason) => switch (reason) {
      ContactReason.word => 'A word to add',
      ContactReason.problem => 'Something is wrong',
      ContactReason.question => 'A question',
      ContactReason.praise => 'Feedback',
      ContactReason.other => 'Something else',
    };

String englishPriority(ContactPriority priority) => switch (priority) {
      ContactPriority.low => 'Low',
      ContactPriority.normal => 'Normal',
      ContactPriority.high => 'High',
    };

/// How the page posts a letter. Injected by tests, so no test ever reaches
/// the real form.
typedef PostLetter = Future<bool> Function(Uri url, Map<String, String> fields);

/// Posts the letter, and says only whether it arrived.
///
/// The `Accept` header is what makes Formspree answer in JSON; without it
/// the answer is a web page and a redirect, which is no use to an app. Every
/// way of failing — a refusal, a rate limit, no network at all — is the same
/// answer here, because the page does the same thing about all of them.
Future<bool> postLetter(Uri url, Map<String, String> fields) async {
  final response = await http.post(
    url,
    headers: const {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    },
    body: jsonEncode(fields),
  );
  return response.statusCode >= 200 && response.statusCode < 300;
}

/// Why someone is writing. The website offers five reasons; these are the
/// five a lexicon gets.
enum ContactReason { word, problem, question, praise, other }

/// How pressing it is — the website's own three.
enum ContactPriority { low, normal, high }

/// The domains a slip of the finger usually means.
///
/// Short enough to be honest about what it covers: these are the addresses
/// people mistype, not a census of mail providers.
const kCommonMailDomains = <String>[
  'gmail.com',
  'googlemail.com',
  'outlook.com',
  'hotmail.com',
  'live.com',
  'yahoo.com',
  'yahoo.co.uk',
  'icloud.com',
  'me.com',
  'proton.me',
  'protonmail.com',
  'aol.com',
  'gmx.com',
  'gmx.net',
  'web.de',
  'mail.com',
  'yandex.com',
  'zoho.com',
];

/// Loose on purpose. An address is only ever proved by a reply arriving, and
/// a pattern strict enough to be interesting rejects addresses that work.
final _emailShape = RegExp(r'^[^@\s]+@[^@\s.]+(\.[^@\s.]+)+$');

bool looksLikeEmail(String value) => _emailShape.hasMatch(value.trim());

String? emailDomainOf(String value) {
  final at = value.trim().lastIndexOf('@');
  if (at < 0) return null;
  final domain = value.trim().substring(at + 1).toLowerCase();
  return domain.isEmpty ? null : domain;
}

/// "gmial.com" → "gmail.com", and nothing at all for a domain that is
/// already one of the common ones or nowhere near any of them.
///
/// Two edits is the whole allowance: one transposition, one dropped letter,
/// one wrong letter. Past that a suggestion stops being a correction and
/// starts being a guess about somebody's employer.
String? suggestEmailDomain(String value) {
  final domain = emailDomainOf(value);
  if (domain == null || !domain.contains('.')) return null;
  if (kCommonMailDomains.contains(domain)) return null;

  String? best;
  var bestDistance = 3;
  for (final candidate in kCommonMailDomains) {
    final distance = _editDistance(domain, candidate);
    if (distance < bestDistance) {
      bestDistance = distance;
      best = candidate;
    }
  }
  return best;
}

/// Replaces the domain in [value] with [domain], leaving the rest alone.
String withEmailDomain(String value, String domain) {
  final trimmed = value.trim();
  final at = trimmed.lastIndexOf('@');
  if (at < 0) return trimmed;
  return '${trimmed.substring(0, at)}@$domain';
}

int _editDistance(String a, String b) {
  var previous = List<int>.generate(b.length + 1, (i) => i);
  final current = List<int>.filled(b.length + 1, 0);
  for (var i = 1; i <= a.length; i++) {
    current[0] = i;
    for (var j = 1; j <= b.length; j++) {
      final cost = a.codeUnitAt(i - 1) == b.codeUnitAt(j - 1) ? 0 : 1;
      current[j] = math.min(
        math.min(current[j - 1] + 1, previous[j] + 1),
        previous[j - 1] + cost,
      );
    }
    previous = List<int>.from(current);
  }
  return previous[b.length];
}

/// One line saying which Gloss this is, for the letters that need it.
///
/// Offered rather than taken: the switch is off until the reader turns it on,
/// and what it would add is written out above it rather than described.
String appDetailsLine({
  required String version,
  required String localeId,
  required String theme,
  required int textScalePercent,
  required String platform,
}) =>
    'Gloss $version · $localeId · $theme · text $textScalePercent% · $platform';

/// The letter itself: what was written, then who wrote it, then the two
/// words of filing the website's form asks for.
String composeLetter({
  required String name,
  required String email,
  required String reason,
  required String priority,
  required String message,
  String? details,
}) {
  final buffer = StringBuffer()
    ..writeln(message.trim())
    ..writeln()
    ..writeln('— ${name.trim()} <${email.trim()}>')
    ..writeln('$reason · $priority');
  if (details != null && details.isNotEmpty) buffer.writeln(details);
  return buffer.toString().trimRight();
}

/// A `mailto:` with the subject and body already filled in.
///
/// The query is encoded by hand: [Uri.queryParameters] writes a space as
/// '+', which the web understands and a mail composer prints literally.
Uri contactMailto({
  required String subject,
  required String body,
  String address = kContactAddress,
}) {
  final query = 'subject=${Uri.encodeComponent(subject)}'
      '&body=${Uri.encodeComponent(body)}';
  return Uri(scheme: 'mailto', path: address, query: query);
}

/// An unsent letter, kept between visits.
///
/// Someone types half a thought, a message arrives, and the app is gone from
/// memory by the time they come back. Without this that half-thought is gone
/// with it — which is the one thing a contact form must never do.
class ContactDraft {
  const ContactDraft({
    this.name = '',
    this.email = '',
    this.reason = ContactReason.question,
    this.priority = ContactPriority.normal,
    this.message = '',
    this.includeDetails = false,
  });

  final String name;
  final String email;
  final ContactReason reason;
  final ContactPriority priority;
  final String message;
  final bool includeDetails;

  /// Nothing worth keeping, and nothing worth telling the reader about.
  bool get isEmpty =>
      name.trim().isEmpty && email.trim().isEmpty && message.trim().isEmpty;

  Map<String, Object?> toJson() => {
        'name': name,
        'email': email,
        'reason': reason.name,
        'priority': priority.name,
        'message': message,
        'includeDetails': includeDetails,
      };

  String encode() => jsonEncode(toJson());

  /// Anything unreadable is treated as no draft at all. A stored draft is
  /// never worth an exception on the way into a page.
  static ContactDraft? decode(String? source) {
    if (source == null || source.isEmpty) return null;
    try {
      final json = jsonDecode(source);
      if (json is! Map<String, dynamic>) return null;
      return ContactDraft(
        name: json['name'] as String? ?? '',
        email: json['email'] as String? ?? '',
        reason: _byName(ContactReason.values, json['reason']) ??
            ContactReason.question,
        priority: _byName(ContactPriority.values, json['priority']) ??
            ContactPriority.normal,
        message: json['message'] as String? ?? '',
        includeDetails: json['includeDetails'] as bool? ?? false,
      );
    } catch (_) {
      return null;
    }
  }

  static T? _byName<T extends Enum>(List<T> values, Object? name) {
    for (final value in values) {
      if (value.name == name) return value;
    }
    return null;
  }
}
