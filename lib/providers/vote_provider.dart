// ignore_for_file: use_build_context_synchronously, unnecessary_lambdas

import 'dart:convert';

import 'package:app_vote/providers/auth_provider.dart';
import 'package:app_vote/ui/main/global.dart';
import 'package:app_vote/ui/main/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:routemaster/routemaster.dart';
import 'package:signature/signature.dart';

final voteProvider = Provider((ref) => VoteNotifier(ref));

class VoteNotifier {
  VoteNotifier(this.ref);

  final Ref ref;

  Future<void> submitVote({
    required String voteFrontId,
    required SignatureController signatureController,
    required BuildContext context,
  }) async {
    try {
      final token = ref.read(authProvider)['token'];

      if (token == null) {
        throw Exception('Token is missing');
      }

      final signatureBytes = await signatureController.toPngBytes();
      final signatureBase64 = base64Encode(signatureBytes!);

      final response = await http.post(
        Uri.parse('${GlobalConfig.baseUrl}/votes/create'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'voteFrontId': voteFrontId,
          'signature': signatureBase64,
        }),
      );

      if (response.statusCode == 201) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Voto registrado exitosamente')),
        );
        Routemaster.of(context).replace(RoutePaths.studentsAlreadyVote);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
}
