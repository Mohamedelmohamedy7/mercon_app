import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void showAwesomeSnackbar(BuildContext context, String title, String message, {ContentType contentType = ContentType.failure}) {
  Flushbar(
    padding: EdgeInsets.all(16),
    borderRadius: BorderRadius.circular(8),
    backgroundColor: _getColor(contentType),
    duration: Duration(seconds: 5),
    icon: Icon(_getIcon(contentType), color: Colors.white),
    title: title,animationDuration:Duration(seconds: 2) ,
    message: message,
    flushbarPosition: FlushbarPosition.TOP,
    onTap: (_) {
      Flushbar().dismiss();
    },
  ).show(context);
}

enum ContentType { success, warning, failure, help, }

Color _getColor(ContentType contentType) {
  switch (contentType) {
    case ContentType.success:
      return Colors.green;
    case ContentType.warning:
      return Colors.orange;
    case ContentType.failure:
      return Colors.red;
    case ContentType.help:
      return Colors.blue;
  }
}

IconData _getIcon(ContentType contentType) {
  switch (contentType) {
    case ContentType.success:
      return Icons.check_circle_outline;
    case ContentType.warning:
      return Icons.warning_amber_outlined;
    case ContentType.failure:
      return Icons.error_outline;
    case ContentType.help:
      return Icons.help_outline;
  }
}
