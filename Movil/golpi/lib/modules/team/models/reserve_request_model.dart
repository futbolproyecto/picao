class ReserveRequestModel {
  final List<String>? agendaId;
  final String? otp;

  ReserveRequestModel({
    this.agendaId,
    this.otp,
  });

  Map<String, dynamic> toJson() {
    return {
      'agenda_id': agendaId,
      'otp': otp,
    };
  }
}
