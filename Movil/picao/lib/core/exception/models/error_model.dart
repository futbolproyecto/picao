import 'dart:io';

class ErrorModel {
  int? status;
  String? error;
  String? recommendation;

  ErrorModel({
    this.status,
    this.error,
    this.recommendation,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        status: json["status"],
        error: json["error"],
        recommendation: json["recommendation"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "error": error,
        "recommendation": recommendation,
      };

  ErrorModel uncontrolledError() => ErrorModel(
      status: HttpStatus.badRequest,
      error: "Error no controlado",
      recommendation: "Intenta de nuevo en un momento");
}
