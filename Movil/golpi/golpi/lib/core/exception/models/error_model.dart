import 'dart:io';

class ErrorModel {
  dynamic status;
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

  ErrorModel timeOutError() => ErrorModel(
      status: HttpStatus.requestTimeout,
      error: "Se ha excedido el tiempo maximo de espera para la peticion",
      recommendation: "Intenta de nuevo en un momento");

  ErrorModel socektError() => ErrorModel(
      status: HttpStatus.networkConnectTimeoutError,
      error: "Fallas en la conexion a internet",
      recommendation: "Intenta de nuevo en un momento");
}
