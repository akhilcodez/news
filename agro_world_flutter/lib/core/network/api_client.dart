import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  @override
  String toString() => "ApiException: $message (Status: $statusCode)";
}

class NetworkUnavailableException implements Exception {
  final String message;
  NetworkUnavailableException([this.message = "Backend server unreachable. Switched to offline mode."]);

  @override
  String toString() => message;
}

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;
  ApiClient._internal();

  final http.Client _httpClient = http.Client();
  static const Duration _timeout = Duration(seconds: 8);

  String get baseUrl {
    // Android emulator cannot access 127.0.0.1 on the host machine; it routes to host via 10.0.2.2
    if (!kIsWeb && Platform.isAndroid) {
      if (ApiConstants.flaskBaseUrl.contains("127.0.0.1") || ApiConstants.flaskBaseUrl.contains("localhost")) {
        return ApiConstants.emulatorFlaskBaseUrl;
      }
    }
    return ApiConstants.flaskBaseUrl;
  }

  // Check if Flask ML backend is reachable
  Future<bool> checkBackendHealth() async {
    try {
      final uri = Uri.parse("$baseUrl${ApiConstants.healthEndpoint}");
      final response = await _httpClient.get(uri).timeout(const Duration(seconds: 4));
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        return decoded['status'] == 'healthy';
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  // Generic GET request
  Future<dynamic> get(String endpoint, {Map<String, String>? queryParams}) async {
    final uri = Uri.parse("$baseUrl$endpoint").replace(queryParameters: queryParams);

    try {
      final response = await _httpClient
          .get(uri, headers: {"Content-Type": "application/json", "Accept": "application/json"})
          .timeout(_timeout);

      return _handleResponse(response);
    } on SocketException {
      throw NetworkUnavailableException();
    } on TimeoutException {
      throw NetworkUnavailableException("Request timed out while contacting backend.");
    } catch (e) {
      if (e is ApiException || e is NetworkUnavailableException) rethrow;
      throw ApiException(e.toString());
    }
  }

  // Generic POST request
  Future<dynamic> post(String endpoint, {Map<String, dynamic>? body}) async {
    final uri = Uri.parse("$baseUrl$endpoint");

    try {
      final response = await _httpClient
          .post(
            uri,
            headers: {"Content-Type": "application/json", "Accept": "application/json"},
            body: body != null ? json.encode(body) : null,
          )
          .timeout(_timeout);

      return _handleResponse(response);
    } on SocketException {
      throw NetworkUnavailableException();
    } on TimeoutException {
      throw NetworkUnavailableException("Request timed out while contacting backend.");
    } catch (e) {
      if (e is ApiException || e is NetworkUnavailableException) rethrow;
      throw ApiException(e.toString());
    }
  }

  // Multipart request for image-based disease detection
  Future<dynamic> postMultipart(
    String endpoint, {
    Map<String, String>? fields,
    String? filePath,
    List<int>? fileBytes,
    String? filename,
  }) async {
    final uri = Uri.parse("$baseUrl$endpoint");

    try {
      final request = http.MultipartRequest("POST", uri);

      if (fields != null) {
        request.fields.addAll(fields);
      }

      if (fileBytes != null && filename != null) {
        request.files.add(
          http.MultipartFile.fromBytes('image', fileBytes, filename: filename),
        );
      } else if (filePath != null && File(filePath).existsSync()) {
        request.files.add(
          await http.MultipartFile.fromPath('image', filePath),
        );
      }

      final streamedResponse = await request.send().timeout(_timeout);
      final response = await http.Response.fromStream(streamedResponse);

      return _handleResponse(response);
    } on SocketException {
      throw NetworkUnavailableException();
    } on TimeoutException {
      throw NetworkUnavailableException("Request timed out while uploading image.");
    } catch (e) {
      if (e is ApiException || e is NetworkUnavailableException) rethrow;
      throw ApiException(e.toString());
    }
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return {};
      return json.decode(response.body);
    } else {
      String errorMessage = "Server error occurred (${response.statusCode})";
      try {
        final decoded = json.decode(response.body);
        if (decoded is Map && decoded.containsKey('error')) {
          errorMessage = decoded['error'];
        } else if (decoded is Map && decoded.containsKey('message')) {
          errorMessage = decoded['message'];
        }
      } catch (_) {}
      throw ApiException(errorMessage, statusCode: response.statusCode);
    }
  }
}
