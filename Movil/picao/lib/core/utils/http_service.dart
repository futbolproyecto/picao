import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:picao/core/exception/custom_exception.dart';
import 'package:picao/core/constants/constant_endpoints.dart';
import 'package:picao/core/exception/models/error_model.dart';
import 'package:picao/core/utils/general_model.dart';

class HttpService {
  final String endPoint;
  HttpService(this.endPoint);

  Future<Map<String, dynamic>> post(Map<String, dynamic>? body) async {
    try {
      final response = await http.post(
        Uri.parse('${ConstantEndpoints.baseUrl}/$endPoint'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode != HttpStatus.ok) {
        throw CustomException(
            ErrorModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes))));
      }
      final generalModel =
          GeneralModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

      return generalModel.jsonStringifyToMaps(generalModel.payload);
    } on CustomException catch (_) {
      rethrow;
    } on Exception catch (_) {
      throw CustomException(ErrorModel().uncontrolledError());
    }
  }

  Future<Object?> put(Map<String, dynamic>? body) async {
    try {
      final response = await http.put(
        Uri.parse('${ConstantEndpoints.baseUrl}/$endPoint'),
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
        Uri.parse('${ConstantEndpoints.baseUrl}/$endPoint'),
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
        Uri.parse('${ConstantEndpoints.baseUrl}/$endPoint'),
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
