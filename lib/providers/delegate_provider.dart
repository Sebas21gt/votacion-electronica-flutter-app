// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:app_vote/domain/entiti/delegate.model.dart';
import 'package:app_vote/domain/entiti/polling_table.model.dart';
import 'package:app_vote/providers/auth_provider.dart';
import 'package:app_vote/ui/main/global.dart';
import 'package:app_vote/ui/main/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:routemaster/routemaster.dart';

final delegateProvider =
    StateNotifierProvider<DelegateNotifier, AsyncValue<DelegateModel?>>((ref) {
  final authState = ref.watch(authProvider);
  final token = authState['token'];
  return DelegateNotifier(ref, token);
});

class DelegateNotifier extends StateNotifier<AsyncValue<DelegateModel?>> {
  DelegateNotifier(this.ref, this.token) : super(const AsyncValue.loading());

  final Ref ref;
  final String? token;

  Future<void> fetchDelegate(String delegateId) async {
    if (token == null) {
      state = AsyncValue.error('Token is missing', StackTrace.current);
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('${GlobalConfig.baseUrl}/delegates/get/$delegateId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final delegate = DelegateModel.fromJson(data);
        state = AsyncValue.data(delegate);

        await ref
            .read(pollingTableProvider.notifier)
            .fetchPollingTable(delegate.pollingtableid);
      } else {
        state = AsyncValue.error(
          'Failed to load delegate data',
          StackTrace.current,
        );
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> closePollingTable(
    String pollingTableId,
    String signature,
    BuildContext context,
  ) async {
    if (token == null) {
      showSnackbar(context, 'Token is missing');
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('${GlobalConfig.baseUrl}/polling-tables/close-table'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'pollingTableId': pollingTableId,
          'signature': signature,
        }),
      );

      if (response.statusCode == 201) {
        showSnackbar(
          context,
          'Su firma fue registrada con éxito',
          Colors.green,
        );
        Routemaster.of(context).replace(RoutePaths.closingTable);
      } else {
        showSnackbar(
          context,
          'Error al cerrar la mesa de sufragio',
          Colors.red,
        );
      }
    } catch (e) {
      showSnackbar(
        context,
        'Error: $e',
        Colors.red,
      );
    }
  }

  void showSnackbar(BuildContext context, String message, [Color? color]) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }
}

final pollingTableProvider =
    StateNotifierProvider<PollingTableNotifier, AsyncValue<PollingTableModel?>>(
        (ref) {
  final authState = ref.watch(authProvider);
  final token = authState['token'];
  return PollingTableNotifier(token);
});

class PollingTableNotifier
    extends StateNotifier<AsyncValue<PollingTableModel?>> {
  PollingTableNotifier(this.token) : super(const AsyncValue.loading());

  final String? token;

  Future<void> fetchPollingTable(String tableId) async {
    if (token == null) {
      state = AsyncValue.error('Token is missing', StackTrace.current);
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('${GlobalConfig.baseUrl}/polling-tables/get/$tableId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final pollingTable = PollingTableModel.fromJson(data);
        state = AsyncValue.data(pollingTable);
      } else {
        state = AsyncValue.error(
          'Failed to load polling table data',
          StackTrace.current,
        );
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
