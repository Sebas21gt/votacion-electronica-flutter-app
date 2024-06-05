// ignore_for_file: deprecated_member_use, unnecessary_null_comparison

import 'package:app_vote/providers/auth_provider.dart';
import 'package:app_vote/providers/student_front_provider.dart';
import 'package:app_vote/providers/student_provider.dart';
import 'package:app_vote/ui/main/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:qr_flutter/qr_flutter.dart';

class StudentQrEnablePage extends ConsumerWidget {
  const StudentQrEnablePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final token = authState['token'];
    final userId = JwtDecoder.decode(token!)['userId'];

    ref.listen<StudentNotifier>(
      studentProvider.notifier,
      (_, __) {},
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(studentProvider.notifier).startPolling(
            userId as String,
            context,
          );
      ref.read(studentFrontProvider.notifier).fetchStudentFronts();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Votaciones Estudiantiles'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Muestra el QR en la mesa de sufragio para ser habilitado para la votación',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 20),
            if (token != null)
              QrImageView(
                data: token,
                size: MediaQuery.of(context).size.width * 0.7,
                foregroundColor: primary,
              ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
