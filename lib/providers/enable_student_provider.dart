// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:app_vote/providers/student_provider.dart';
import 'package:app_vote/ui/main/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:routemaster/routemaster.dart';

final enableStudentProvider =
    StateNotifierProvider<EnableStudentNotifier, String?>((ref) {
  return EnableStudentNotifier(ref);
});

class EnableStudentNotifier extends StateNotifier<String?> {
  EnableStudentNotifier(this.ref) : super(null);

  final Ref ref;

  void processQrCode(String qrCode, BuildContext context) async {
    try {
      final decodedToken = JwtDecoder.decode(qrCode);
      final userId = decodedToken['userId'];
      state = userId as String;
      print('Decoded userId student: $userId');

      await ref.read(studentProvider.notifier).fetchStudent(userId);

      // Obtener los datos del estudiante
      final studentState = ref.read(studentProvider);
      final student = studentState.value;
      Routemaster.of(context).push(
        RoutePaths.studentDataEnable,
        queryParameters: {'student': jsonEncode(student)},
      );
      // Routemaster.of(context).push(RoutePaths.studentsVotingCard);
    } catch (e) {
      state = null;
      print('Error decoding QR code: $e');
    }
  }
}
