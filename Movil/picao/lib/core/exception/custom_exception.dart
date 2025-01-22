import 'package:picao/core/exception/models/error_model.dart';

class CustomException implements Exception {
  ErrorModel error;

  CustomException(this.error);

  ErrorModel errorResponse() {
    return error;
  }
}

class FetchDataException extends CustomException {
  FetchDataException(super.error);
}

class BadRequestException extends CustomException {
  BadRequestException(super.error);
}
