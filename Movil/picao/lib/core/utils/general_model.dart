import 'dart:convert';

import 'package:picao/core/exception/custom_exception.dart';
import 'package:picao/core/exception/models/error_model.dart';

class GeneralModel {
  final int status;
  final Object payload;
  GeneralModel({
    required this.status,
    required this.payload,
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
}
