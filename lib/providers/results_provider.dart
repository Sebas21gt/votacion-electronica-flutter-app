import 'dart:convert';
import 'package:app_vote/domain/entiti/results.model.dart';
import 'package:app_vote/providers/auth_provider.dart';
import 'package:app_vote/ui/main/global.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final resultsProvider =
    StateNotifierProvider<ResultsNotifier, AsyncValue<List<ResultsModel>>>(
        (ref) {
  final authState = ref.watch(authProvider);
  final token = authState['token'];
  return ResultsNotifier(token);
});

class ResultsNotifier extends StateNotifier<AsyncValue<List<ResultsModel>>> {
  ResultsNotifier(this.token) : super(const AsyncValue.loading());

  final String? token;

  Future<void> fetchResults() async {
    if (token == null) {
      state = AsyncValue.error('Token is missing', StackTrace.current);
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('${GlobalConfig.baseUrl}/results/all'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('Entró al fetchResults');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        final results = data
            .map((item) => ResultsModel.fromJson(item as Map<String, dynamic>))
            .toList();
        state = AsyncValue.data(results);
      } else {
        state = AsyncValue.error(
          'Failed to load voting results',
          StackTrace.current,
        );
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
