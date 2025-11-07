import 'dart:convert';

import 'package:http/http.dart' as http;

/// Small HTTP wrapper using `package:http`.
///
/// Provides basic GET/POST helpers that decode JSON and throw a
/// simple [HttpRequestException] on non-2xx responses.
class HttpService {
  final Duration timeout;

  HttpService({this.timeout = const Duration(seconds: 10)});

  Future<dynamic> getJson(String url, {Map<String, String>? headers}) async {
    final uri = Uri.parse(url);
    final resp = await http.get(uri, headers: headers).timeout(timeout);

    if (resp.statusCode >= 200 && resp.statusCode < 300) {
      if (resp.body.isEmpty) return null;
      return json.decode(resp.body);
    }

    throw HttpRequestException(
      uri: uri,
      statusCode: resp.statusCode,
      body: resp.body,
    );
  }

  Future<dynamic> postJson(
    String url,
    Object body, {
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse(url);
    final allHeaders = <String, String>{
      'Content-Type': 'application/json',
      ...?headers,
    };
    final resp = await http
        .post(uri, headers: allHeaders, body: json.encode(body))
        .timeout(timeout);

    if (resp.statusCode >= 200 && resp.statusCode < 300) {
      if (resp.body.isEmpty) return null;
      return json.decode(resp.body);
    }

    throw HttpRequestException(
      uri: uri,
      statusCode: resp.statusCode,
      body: resp.body,
    );
  }
}

class HttpRequestException implements Exception {
  final Uri uri;
  final int statusCode;
  final String body;

  HttpRequestException({
    required this.uri,
    required this.statusCode,
    required this.body,
  });

  @override
  String toString() =>
      'HttpRequestException: $statusCode on $uri — ${body.length > 200 ? body.substring(0, 200) + "..." : body}';
}
