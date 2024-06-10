// ignore_for_file: inference_failure_on_function_invocation, use_build_context_synchronously, unused_local_variable

import 'dart:convert';

import 'package:app_vote/providers/vote_provider.dart';
import 'package:app_vote/ui/main/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:signature/signature.dart';

void showSignatureDialog(BuildContext context, String frontId) {
  final controller = SignatureController(
    penStrokeWidth: 2,
    exportBackgroundColor: Colors.white,
  );

  //! Para evitar capturas de pantalla (Probar en dispositivo Fisico de Android)
  // FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      backgroundColor: secondary,
      title: const Text(
        'Firma del votante',
        style: TextStyle(
          color: primary,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Signature(
              controller: controller,
              backgroundColor: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'La firma se usará para el carnet de sufragio y validar la votación',
            style: TextStyle(
              fontSize: 14,
              color: textColor,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: controller.clear,
          child: const Text('EDITAR'),
        ),
        TextButton(
          onPressed: () async {
            final container = ProviderScope.containerOf(context);
            final signatureBytes = await controller.toPngBytes();
            final signatureBase64 = base64Encode(signatureBytes!);

            await container.read(voteProvider).submitVote(
                  voteFrontId: frontId,
                  signatureController: controller,
                  context: context,
                );
          },
          child: const Text('ACEPTAR'),
        ),
      ],
    ),
  );
}
