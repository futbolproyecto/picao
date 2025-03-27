import 'dart:io';

class ErrorModel {
  dynamic status;
  String? code;
  String? error;
  String? recommendation;

  ErrorModel({
    this.status,
    this.code,
    this.error,
    this.recommendation,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      status: json["status"],
      code: json["code"].toString(),
      error: json["error"],
      recommendation: json["recommendation"],
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "error": error,
        "recommendation": recommendation,
      };

  ErrorModel uncontrolledError() => ErrorModel(
      status: HttpStatus.badRequest,
      error: "Error no controlado",
      recommendation: "Intenta de nuevo en un momento");

  ErrorModel timeOutError() => ErrorModel(
      status: HttpStatus.requestTimeout,
      error: "Se ha excedido el tiempo maximo de espera para la peticion",
      recommendation: "Intenta de nuevo en un momento");

  ErrorModel socektError() => ErrorModel(
      status: HttpStatus.networkConnectTimeoutError,
      error: "Fallas en la conexion a internet",
      recommendation: "Intenta de nuevo en un momento");
}
