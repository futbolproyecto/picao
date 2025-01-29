import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:golpi/core/utils/general_model.dart';
import 'package:golpi/data/service/secure_storage.dart';
import 'package:golpi/core/exception/custom_exception.dart';
import 'package:golpi/core/constants/constant_endpoints.dart';
import 'package:golpi/core/exception/models/error_model.dart';
import 'package:golpi/core/constants/constant_secure_storage.dart';

class HttpService {
  final String endPoint;
  HttpService(this.endPoint);

  Future<Map<String, dynamic>> post(Map<String, dynamic>? body) async {
    try {
      final response = await http
          .post(
            Uri.http(ConstantEndpoints.baseUrl, endPoint),
            headers: await getHeaders(),
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 20));

      if (response.statusCode != HttpStatus.ok) {
        throw BadRequestException(
            ErrorModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes))));
      }

      final generalModel =
          GeneralModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

      return generalModel.jsonStringifyToMaps(generalModel.payload);
    } on BadRequestException catch (e) {
      throw FetchDataException(e.error);
    } on SocketException {
      throw FetchDataException(ErrorModel().socektError());
    } on TimeoutException {
      throw FetchDataException(ErrorModel().timeOutError());
    } on Exception catch (_) {
      throw FetchDataException(ErrorModel().uncontrolledError());
    }
  }

  Future<Object?> put(Map<String, dynamic>? body) async {
    try {
      final response = await http
          .put(Uri.http(ConstantEndpoints.baseUrl, endPoint),
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode(body))
          .timeout(const Duration(seconds: 20));

      if (response.statusCode != HttpStatus.ok) {
        throw BadRequestException(
            ErrorModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes))));
      }

      return response.body;
    } on BadRequestException catch (e) {
      throw FetchDataException(e.error);
    } on SocketException {
      throw FetchDataException(ErrorModel().socektError());
    } on TimeoutException {
      throw FetchDataException(ErrorModel().timeOutError());
    } on Exception catch (_) {
      throw FetchDataException(ErrorModel().uncontrolledError());
    }
  }

  Future<Object?> postRequesParam(Map<String, String>? parameters) async {
    try {
      final response = await http.post(
        Uri.http(ConstantEndpoints.baseUrl, endPoint, parameters),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 20));

      if (response.statusCode != HttpStatus.ok) {
        throw BadRequestException(
            ErrorModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes))));
      }

      return response.body;
    } on BadRequestException catch (e) {
      throw FetchDataException(e.error);
    } on SocketException {
      throw FetchDataException(ErrorModel().socektError());
    } on TimeoutException {
      throw FetchDataException(ErrorModel().timeOutError());
    } on Exception catch (_) {
      throw FetchDataException(ErrorModel().uncontrolledError());
    }
  }

  Future<Object?> putRequesParam(Map<String, String>? parameters) async {
    try {
      final response = await http.post(
        Uri.http(ConstantEndpoints.baseUrl, endPoint, parameters),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 20));

      if (response.statusCode != HttpStatus.ok) {
        throw BadRequestException(
            ErrorModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes))));
      }

      return response.body;
    } on BadRequestException catch (e) {
      throw FetchDataException(e.error);
    } on SocketException {
      throw FetchDataException(ErrorModel().socektError());
    } on TimeoutException {
      throw FetchDataException(ErrorModel().timeOutError());
    } on Exception catch (_) {
      throw FetchDataException(ErrorModel().uncontrolledError());
    }
  }

  Future<Object?> get() async {
    try {
      final response = await http
          .get(
            Uri.http(ConstantEndpoints.baseUrl, endPoint),
            headers: await getHeaders(),
          )
          .timeout(const Duration(seconds: 20));

      if (response.statusCode != HttpStatus.ok) {
        throw BadRequestException(
            ErrorModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes))));
      }

      final generalModel =
          GeneralModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

      return generalModel.payload;
    } on BadRequestException catch (e) {
      throw FetchDataException(e.error);
    } on SocketException {
      throw FetchDataException(ErrorModel().socektError());
    } on TimeoutException {
      throw FetchDataException(ErrorModel().timeOutError());
    } on Exception catch (_) {
      throw FetchDataException(ErrorModel().uncontrolledError());
    }
  }

  Future<Map<String, String>> getHeaders() async {
    final Map<String, String> listaCabeceras = <String, String>{};

    listaCabeceras.putIfAbsent(
        HttpHeaders.contentTypeHeader, () => 'application/json');

    listaCabeceras.putIfAbsent(
        HttpHeaders.connectionHeader, () => 'Keep-Alive');

    if (!ConstantEndpoints.blackList.contains(endPoint)) {
      final String? token =
          await SecureStorage().read(ConstantSecureStorage.tokenSesion);

      if (token != null && token.isNotEmpty) {
        listaCabeceras.putIfAbsent(
            HttpHeaders.authorizationHeader, () => 'Bearer $token');
      }
    }

    return listaCabeceras;
  }
}
