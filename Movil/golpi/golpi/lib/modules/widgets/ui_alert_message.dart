import 'package:flutter/material.dart';
import 'package:golpi/core/constants/constants.dart';
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
            backgroundColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
            insetPadding: const EdgeInsets.all(25),
            icon: const Icon(
              Icons.cancel_outlined,
              size: 50,
              color: Color.fromARGB(255, 255, 17, 0),
            ),
            content: Container(
              width: 400,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color.fromARGB(255, 245, 16, 0),
                    width: 5.0,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(message, textAlign: TextAlign.center),
              ),
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
            backgroundColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
            insetPadding: const EdgeInsets.all(25),
            icon: Icon(
              Icons.check_circle_outline,
              size: 50,
              color: Constants.primaryColor,
            ),
            content: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Constants.primaryColor,
                    width: 5.0,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(message, textAlign: TextAlign.center),
              ),
            ),
            actions: [
              UiButtoms(onPressed: () => actionButtom(), title: 'Cerrar')
                  .textButtom(Colors.black),
            ],
          );
        });
  }

  alert({VoidCallback? accion, required String message}) {
    FocusManager.instance.primaryFocus!.unfocus();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
            insetPadding: const EdgeInsets.all(25),
            icon: const Icon(
              Icons.error_outline,
              size: 50,
              color: Color.fromARGB(255, 252, 189, 0),
            ),
            content: Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color.fromARGB(255, 252, 189, 0),
                    width: 5.0,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(message, textAlign: TextAlign.center),
              ),
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

  custom({Widget? child, List<Widget>? actions}) {
    FocusManager.instance.primaryFocus!.unfocus();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
            insetPadding: const EdgeInsets.all(25),
            icon: SizedBox(
              width: 60,
              height: 60,
              child: Image.asset(
                'assets/img/golpilogo.png',
                fit: BoxFit.contain,
              ),
            ),
            content: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Constants.secondaryColor,
                    width: 5.0,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: child,
              ),
            ),
            actions: actions,
          );
        });
  }
}
