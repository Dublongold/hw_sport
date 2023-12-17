
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

bool onEscPressed(BuildContext context, KeyEvent event) {
  final key = event.logicalKey.keyLabel;

  if (event is KeyDownEvent && key.toLowerCase().contains("esc")) {
    if (Navigator.of(context).canPop()) {
      Logger().i("Esc pressed.");
      Navigator.of(context).pop();
    }
    else {
      Logger().i("Esc pressed, but can't pop.");
    }
    return true;
  }
  else {
    Logger().i("Esc not pressed. $key pressed.");
  }

  return false;
}