import 'package:url_launcher/url_launcher.dart';

Future<void> launchCustomUrl(String url) async {
  if (!url.startsWith('https://')) {
    url = 'https://$url';
  }
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch: $url');
  }
}

String getFaviconUrl(String url) {
  Uri uri = Uri.parse(url);
  if (uri.scheme.isEmpty) {
    uri = Uri.parse('https://$url');
  }
  return '${uri.scheme}://${uri.host}/favicon.ico';
}
