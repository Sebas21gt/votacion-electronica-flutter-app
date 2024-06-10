import 'dart:convert';
import 'package:app_vote/ui/main/global.dart';
import 'package:app_vote/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final electionProvider =
    StateNotifierProvider<ElectionNotifier, AsyncValue<void>>((ref) {
  return ElectionNotifier(ref);
});

class ElectionNotifier extends StateNotifier<AsyncValue<void>> {
  ElectionNotifier(this.ref) : super(const AsyncValue.data(null));

  final Ref ref;

  Future<void> closeElection(String signature) async {
    final authState = ref.read(authProvider);
    final token = authState['token'];

    if (token == null) {
      state = AsyncValue.error('Token is missing', StackTrace.current);
      return;
    }

    state = const AsyncValue.loading();
    try {
      final response = await http.post(
        Uri.parse('${GlobalConfig.baseUrl}/electoral-records/close-election'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'signature': signature}),
      );

      if (response.statusCode == 201) {
        state = const AsyncValue.data(null);
        const SnackBar(
          content: Text('Elecciones cerradas exitosamente.'),
          backgroundColor: Colors.green,
        );
      } else {
        state = AsyncValue.error(
          'Failed to close election: ${response.body}',
          StackTrace.current,
        );
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
