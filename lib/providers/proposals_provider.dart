import 'dart:convert';

import 'package:app_vote/domain/entiti/student_front_info.model.dart';
import 'package:app_vote/providers/auth_provider.dart';
import 'package:app_vote/ui/main/global.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final proposalProvider =
    StateNotifierProvider<ProposalNotifier, AsyncValue<StudentFrontInfoModel?>>(
        (ref) {
  return ProposalNotifier(ref);
});

class ProposalNotifier
    extends StateNotifier<AsyncValue<StudentFrontInfoModel?>> {
  ProposalNotifier(this.ref) : super(const AsyncValue.loading());

  final Ref ref;

  Future<void> fetchProposals(String studentFrontId) async {
    // state = const AsyncValue.loading();

    final authState = ref.read(authProvider);
    final token = authState['token'];

    if (token == null) {
      state = AsyncValue.error('Token is missing', StackTrace.current);
      return;
    }

    studentFrontId = studentFrontId.replaceAll('"', '');

    try {
      final response = await http.get(
        Uri.parse(
          '${GlobalConfig.baseUrl}/proposals/get-proposal-by-student-front/$studentFrontId',
        ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        print('Data: $data');
        state = AsyncValue.data(StudentFrontInfoModel.fromJson(data));
      } else {
        state = AsyncValue.error(
          'Failed to load proposals: ${response.body}',
          StackTrace.current,
        );
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
