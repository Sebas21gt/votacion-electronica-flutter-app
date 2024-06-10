import 'dart:typed_data';

import 'package:app_vote/ui/main/styles.dart';
import 'package:app_vote/ui/widgets/atoms/button_custom.dart';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class SignatureForm extends StatelessWidget {
  const SignatureForm({
    required this.title,
    required this.subtitle,
    required this.onConfirm,
    super.key,
  });

  final String title;
  final String subtitle;
  final void Function(Uint8List) onConfirm;

  @override
  Widget build(BuildContext context) {
    final controller = SignatureController(
      penStrokeWidth: 2,
      exportBackgroundColor: Colors.white,
    );

    return Column(
      children: [
        const SizedBox(height: 20),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: primary,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: Signature(
            controller: controller,
            backgroundColor: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 14,
            color: textColor,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ButtonCustom(
              onPressed: controller.clear,
              text: 'EDITAR',
              outlined: true,
            ),
            ButtonCustom(
              onPressed: () async {
                final signature = await controller.toPngBytes();
                if (signature != null) {
                  onConfirm(signature);
                }
              },
              text: 'ACEPTAR',
            ),
          ],
        ),
      ],
    );
  }
}
