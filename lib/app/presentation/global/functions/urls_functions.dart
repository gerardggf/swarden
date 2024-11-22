import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

Future<void> launchCustomUrl(String url) async {
  if (!url.startsWith('https://')) {
    url = 'https://$url';
  }
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch: $url');
  }
}

// String getFaviconUrl(String url) {
//   Uri uri = Uri.parse(url);
//   if (uri.scheme.isEmpty) {
//     uri = Uri.parse('https://$url');
//   }
//   return '${uri.scheme}://${uri.host}/favicon.ico';
// }

final getFaviconFutureProvider =
    FutureProvider.family.autoDispose<String?, String?>(
  (ref, url) => getFaviconUrl(url),
);

Future<String?> getFaviconUrl(String? url) async {
  if (url == null) return null;
  Uri uri = Uri.parse(url);
  if (uri.scheme.isEmpty) {
    uri = Uri.parse('https://$url');
  }
  String faviconUrl = '${uri.scheme}://${uri.host}/favicon.ico';
  try {
    final response = await http.head(Uri.parse(faviconUrl));
    if (response.statusCode == HttpStatus.ok) {
      return faviconUrl;
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}
