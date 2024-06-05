import 'dart:convert';
import 'dart:typed_data';

import 'package:app_vote/providers/student_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';

class VotingCardPage extends ConsumerWidget {
  const VotingCardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final studentState = ref.watch(studentProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carnet de Sufragio'),
      ),
      body: studentState.when(
        data: (student) {
          final signatureBytes = base64Decode(student!.signature);
          final careers = student.careers.join(', ');

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nombre Completo: ${student.fullname}',
                        style: _infoStyle,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Carnet Identidad: ${student.ciNumber}',
                        style: _infoStyle,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Carnet Universitario: ${student.collegeNumber}',
                        style: _infoStyle,
                      ),
                      const SizedBox(height: 8),
                      Text('Carrera: $careers', style: _infoStyle),
                      const SizedBox(height: 8),
                      Text('Firma:', style: _infoStyle),
                      const SizedBox(height: 8),
                      Center(
                        child: Image.memory(
                          signatureBytes,
                          height: 80,
                          errorBuilder: (context, error, stackTrace) {
                            return const Text('Error al cargar la firma');
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: QrImageView(
                          data: student.fullname, // REEMPLAZAR POR LA BLOCKCHAIN
                          size: 100,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Add your download logic here
                  },
                  child: const Text('DESCARGAR'),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  TextStyle get _infoStyle => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
}
