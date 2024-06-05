// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:app_vote/providers/enable_student_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class EnableStudentsDelegatePage extends ConsumerStatefulWidget {
  const EnableStudentsDelegatePage({super.key});

  @override
  _EnableStudentsDelegatePageState createState() =>
      _EnableStudentsDelegatePageState();
}

class _EnableStudentsDelegatePageState
    extends ConsumerState<EnableStudentsDelegatePage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  void _onQRViewCreated(QRViewController qrController) {
    setState(() {
      controller = qrController;
    });
    controller!.scannedDataStream.listen((scanData) {
      controller!.pauseCamera();
      ref
          .read(enableStudentProvider.notifier)
          .processQrCode(scanData.code!, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final userId = ref.watch(enableStudentProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Habilitar Estudiantes'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          const Expanded(
            flex: 1,
            child: Center(
              child: Text(
                'Escanea el código QR para habilitar al estudiante',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.blue),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
