import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeGenerator extends StatelessWidget {

  const QRCodeGenerator({required this.data, super.key});
  final String data;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: QrImageView(
        data: data,
        size: 200.0,
        gapless: false,
      ),
    );
  }
}
