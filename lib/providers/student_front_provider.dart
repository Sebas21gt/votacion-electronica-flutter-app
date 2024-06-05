import 'dart:convert';
import 'package:app_vote/domain/entiti/students_front.model.dart';
import 'package:app_vote/providers/auth_provider.dart';
import 'package:app_vote/ui/main/global.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final studentFrontProvider = StateNotifierProvider<StudentFrontNotifier,
    AsyncValue<List<StudentFrontModel>>>((ref) {
  final authState = ref.watch(authProvider);
  final token = authState['token'];
  return StudentFrontNotifier(token);
});

class StudentFrontNotifier
    extends StateNotifier<AsyncValue<List<StudentFrontModel>>> {
  StudentFrontNotifier(this.token) : super(const AsyncValue.loading());

  final String? token;

  Future<void> fetchStudentFronts() async {
    if (token == null) {
      state = AsyncValue.error('Token is missing', StackTrace.current);
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('${GlobalConfig.baseUrl}/students-fronts/all'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print('LLAMA A LA API FETCH STUDENT FRONTS');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        final fronts = data
            .map(
              (item) =>
                  StudentFrontModel.fromJson(item as Map<String, dynamic>),
            )
            .toList();
        state = AsyncValue.data(fronts);
      } else {
        state = AsyncValue.error(
          'Failed to load student fronts',
          StackTrace.current,
        );
      }
    } catch (e) {
      state = AsyncValue.error(
        e,
        StackTrace.current,
      );
    }
  }

  Future<void> fetchStudentFrontsList() async {
    if (token == null) {
      state = AsyncValue.error('Token is missing', StackTrace.current);
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('${GlobalConfig.baseUrl}/students-fronts/all'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print('LLAMA A LA API FETCH STUDENT FRONTS');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        final fronts = data
            .map(
              (item) =>
                  StudentFrontModel.fromJson(item as Map<String, dynamic>),
            )
            .where((front) => front.name != 'Blanco' && front.name != 'Nulo')
            .toList();
        state = AsyncValue.data(fronts);
      } else {
        state = AsyncValue.error(
          'Failed to load student fronts',
          StackTrace.current,
        );
      }
    } catch (e) {
      state = AsyncValue.error(
        e,
        StackTrace.current,
      );
    }
  }
}
