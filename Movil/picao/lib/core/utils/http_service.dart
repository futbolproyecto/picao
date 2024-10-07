import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:picao/core/exception/custom_exception.dart';
import 'package:picao/core/exception/models/error_model.dart';

class HttpService {
  static const String baseUrl = 'http://10.103.1.71:8092';

  final String endPoint;
  HttpService(this.endPoint);

  Future<Object?> post(Map<String, dynamic>? body) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/$endPoint'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      if (response.statusCode != HttpStatus.ok) {
        throw CustomException(
            ErrorModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes))));
      }

      return response.body;
    } on CustomException catch (_) {
      rethrow;
    } on Exception catch (_) {
      throw CustomException(ErrorModel().uncontrolledError());
    }
  }
}
