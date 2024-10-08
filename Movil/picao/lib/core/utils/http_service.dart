import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:picao/core/constants/constant_endpoints.dart';
import 'package:picao/core/exception/custom_exception.dart';
import 'package:picao/core/exception/models/error_model.dart';

class HttpService {
  final String endPoint;
  HttpService(this.endPoint);

  Future<Object?> post(Map<String, dynamic>? body) async {
    try {
      final response = await http.post(
        Uri.http(ConstantEndpoints.baseUrl, endPoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
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

  Future<Object?> postRequesParam(Map<String, String>? parameters) async {
    try {
      final response = await http.post(
        Uri.http(ConstantEndpoints.baseUrl, endPoint, parameters),
        headers: {'Content-Type': 'application/json'},
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

  Future<Object?> putRequesParam(Map<String, String>? parameters) async {
    try {
      final response = await http.put(
        Uri.http(ConstantEndpoints.baseUrl, endPoint, parameters),
        headers: {'Content-Type': 'application/json'},
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
