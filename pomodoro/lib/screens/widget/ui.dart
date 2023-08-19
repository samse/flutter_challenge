import 'package:flutter/material.dart';

class AlertBuilder {
  String? title = "";
  String? message = "";
  BuildContext context;
  String positiveText = "OK";
  String negativeText = "Cancel";

  AlertBuilder({required this.context});

  Future<void> showAlert() async {
    if (context == null) return;
    await showDialog(
        context: context!,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title ?? ""),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Center(child: Text(message ?? ""))],
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(positiveText),
              ),
            ],
          );
        });
  }

  Future<bool> showConfirm(BuildContext context) async {
    final ret = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title ?? ""),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Center(child: Text(message ?? ""))],
            ),
            actionsAlignment: MainAxisAlignment.end,
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context, false);
                },
                child: Text(negativeText),
              ),
              SizedBox(
                height: 32,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context, true);
                },
                child: Text(positiveText),
              ),
            ],
          );
        });
    return ret as bool;
  }
}
