import 'package:flutter/material.dart';
import 'package:golpi/modules/widgets/ui_buttoms.dart';

class UiAlertMessage {
  final BuildContext context;
  UiAlertMessage(this.context);

  error({VoidCallback? accionm, required String message}) {
    FocusManager.instance.primaryFocus!.unfocus();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            contentPadding: const EdgeInsets.all(2),
            titlePadding: EdgeInsets.zero,
            title: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.error,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: const Icon(
                  Icons.cancel_outlined,
                  size: 60,
                  color: Colors.white,
                )),
            content: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                  )),
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child:
                    const Text('Cerrar', style: TextStyle(color: Colors.black)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  success({
    required VoidCallback actionButtom,
    required String message,
    bool barrierDismissible = true,
  }) {
    FocusManager.instance.primaryFocus!.unfocus();
    showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            contentPadding: const EdgeInsets.all(2),
            titlePadding: EdgeInsets.zero,
            title: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.green[600],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: const Icon(
                  Icons.check_circle_outline,
                  size: 60,
                  color: Colors.white,
                )),
            content: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                  )),
            ),
            actions: [
              UiButtoms(onPressed: () => actionButtom(), title: 'Cerrar')
                  .textButtom(Colors.black),
            ],
          );
        });
  }

  alert({
    VoidCallback? accion,
    required String message,
    List<Widget>? actions,
  }) {
    FocusManager.instance.primaryFocus!.unfocus();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            contentPadding: const EdgeInsets.all(2),
            titlePadding: EdgeInsets.zero,
            title: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.amber[600],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: const Icon(
                  Icons.error_outline,
                  size: 60,
                  color: Colors.white,
                )),
            content: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                  )),
            ),
            actions: actions ??
                [
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const Text('Cerrar',
                        style: TextStyle(color: Colors.black)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
          );
        });
  }

  custom({Widget? child, List<Widget>? actions}) {
    FocusManager.instance.primaryFocus!.unfocus();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            contentPadding: const EdgeInsets.all(2),
            titlePadding: EdgeInsets.zero,
            title: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: Image.asset(
                    'assets/img/golpilogo.png',
                    fit: BoxFit.contain,
                  ),
                )),
            content: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: child,
            ),
            actions: actions,
          );
        });
  }
}
