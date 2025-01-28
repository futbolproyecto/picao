import 'dart:convert';

import 'package:golpi/core/exception/custom_exception.dart';
import 'package:golpi/core/exception/models/error_model.dart';

class GeneralModel {
  final int? status;
  final Object? payload;

  GeneralModel({
    this.status,
    this.payload,
  });

  factory GeneralModel.fromJson(Map<String, dynamic> json) {
    return GeneralModel(
      status: json['status'],
      payload: json['payload'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'payload': payload,
    };
  }

  Map<String, dynamic> jsonStringifyToMaps(Object? object) {
    if (object == null) {
      throw CustomException(ErrorModel().uncontrolledError());
    }

    return jsonDecode(jsonEncode(object).toString());
  }

  List<dynamic> jsonStringifyToList(Object? object) {
    if (object == null) {
       throw CustomException(ErrorModel().uncontrolledError());
    }

    return json.decode(jsonEncode(object).toString());
  }
}
