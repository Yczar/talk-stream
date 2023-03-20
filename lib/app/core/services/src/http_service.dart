import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpService {
  HttpService({required String baseUrl}) : _baseUrl = baseUrl;
  final String _baseUrl;

  Future<http.Response> get(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    final response = await http.get(
      Uri.parse(
        '$_baseUrl$endpoint',
      ),
      headers: headers,
    );
    return _handleResponse(response);
  }

  Future<http.Response> post(
    String endpoint, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    final response = await http.post(
      Uri.parse(
        '$_baseUrl$endpoint',
      ),
      headers: headers,
      body: json.encode(body),
    );
    return _handleResponse(response);
  }

  Future<http.Response> put(
    String endpoint, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    final response = await http.put(
      Uri.parse('$_baseUrl$endpoint'),
      headers: headers,
      body: json.encode(body),
    );
    return _handleResponse(response);
  }

  Future<http.Response> delete(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    final response =
        await http.delete(Uri.parse('$_baseUrl$endpoint'), headers: headers);
    return _handleResponse(response);
  }

  http.Response _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response;
    } else {
      throw HttpException(
        (jsonDecode(response.body) as Map?)?['message'].toString() ??
            response.reasonPhrase ??
            'Something went wrong',
      );
    }
  }
}

class HttpException implements Exception {
  HttpException(this.message);
  final String message;
}
