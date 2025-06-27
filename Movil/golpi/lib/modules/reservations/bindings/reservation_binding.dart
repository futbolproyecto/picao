import 'package:get/get.dart';
import 'package:golpi/data/repositories/reservation/reservation_repository.dart';
import 'package:golpi/modules/reservations/controller/reservation_controller.dart';

class ReservationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReservationRepository>(() => ReservationRepository());
    Get.lazyPut<ReservationController>(
        () => ReservationController(reservationRepository: Get.find()));
  }
}
