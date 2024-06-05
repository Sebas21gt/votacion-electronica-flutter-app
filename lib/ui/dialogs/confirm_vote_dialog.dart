// ignore_for_file: inference_failure_on_function_invocation

import 'package:app_vote/ui/dialogs/signature_dialog.dart';
import 'package:app_vote/ui/main/styles.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_windowmanager/flutter_windowmanager.dart';

void showConfirmVoteDialog(BuildContext context, String frontName, String frontId) {

  //! Para evitar capturas de pantalla (Probar en dispositivo Fisico de Android)
  // FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      backgroundColor: secondary,
      title: const Text(
        'Confirmar Voto',
        style: TextStyle(
          color: primary,
          fontSize: 20,
        ),
      ),
      content: Text(
        'Al presionar "Aceptar" su voto sera para "$frontName" y no podrá volver atrás. ¿Quiere continuar?',
        style: const TextStyle(
          color: primary,
          fontSize: 16,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('CANCELAR'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            showSignatureDialog(context, frontId);
          },
          child: const Text('ACEPTAR'),
        ),
      ],
    ),
  );
}
