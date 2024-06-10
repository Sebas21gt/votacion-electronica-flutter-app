// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:app_vote/domain/entiti/student.model.dart';
import 'package:app_vote/providers/auth_provider.dart';
import 'package:app_vote/ui/main/global.dart';
import 'package:app_vote/ui/main/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:routemaster/routemaster.dart';

final studentProvider =
    StateNotifierProvider<StudentNotifier, AsyncValue<StudentModel?>>((ref) {
  return StudentNotifier(ref);
});

class StudentNotifier extends StateNotifier<AsyncValue<StudentModel?>> {
  StudentNotifier(this.ref) : super(const AsyncValue.loading()) {
    _init();
  }

  final Ref ref;
  Timer? _pollingTimer;

  void _init() {
    final authState = ref.read(authProvider);
    final token = authState['token'];
    final userId = token != null ? JwtDecoder.decode(token)['userId'] : null;

    if (userId != null) {
      fetchStudent(userId as String);
    }
  }

  Future<void> fetchStudent(String userId) async {
    final authState = ref.read(authProvider);
    final token = authState['token'];

    try {
      final response = await http.get(
        Uri.parse('${GlobalConfig.baseUrl}/students/get-student/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        state = AsyncValue.data(
          StudentModel.fromJson(data as Map<String, dynamic>),
        );
      } else {
        state =
            AsyncValue.error('Failed to load student data', StackTrace.current);
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> enableStudent(String studentId) async {
    final authState = ref.read(authProvider);
    final token = authState['token'];
    if (token == null) {
      state = AsyncValue.error('Token is missing', StackTrace.current);
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('${GlobalConfig.baseUrl}/students/enable-student/$studentId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print(response.body);

      if (response.statusCode == 200) {
        print('Student enabled');
        // await fetchStudent(studentId);
      } else {
        state = AsyncValue.error(
          'Failed to enable student',
          StackTrace.current,
        );
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  void startPolling(String userId, BuildContext context) {
    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      await fetchStudent(userId);
      final studentState = state.value;

      if (studentState != null && studentState.isHabilitated) {
        timer.cancel();
        stopPolling();
        Routemaster.of(context).replace(RoutePaths.studentsVoting);
      }
    });
  }

  void stopPolling() {
    _pollingTimer?.cancel();
  }

  @override
  void dispose() {
    _pollingTimer?.cancel();
    super.dispose();
  }

  Future<void> checkStudentStatusAndNavigate(BuildContext context) async {
    final authState = ref.read(authProvider);
    final userId = JwtDecoder.decode(authState['token']!)['userId'];

    await fetchStudent(userId as String);

    state.when(
      data: (student) {
        if (student != null) {
          if (!student.isHabilitated && !student.isVoted) {
            Routemaster.of(context).push(RoutePaths.studentsEnableQrVoting);
          }
          if (student.isHabilitated && !student.isVoted) {
            Routemaster.of(context).push(RoutePaths.studentsVoting);
          }
          if (student.isVoted) {
            Routemaster.of(context).push(RoutePaths.studentsAlreadyVote);
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error: Student data is null')),
          );
        }
      },
      loading: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Loading student data...')),
        );
      },
      error: (error, stack) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al obtener datos del estudiante: $error'),
          ),
        );
      },
    );
  }

  Future<void> checkStudentIsVoteAndNavigate(BuildContext context) async {
    final authState = ref.read(authProvider);
    final userId = JwtDecoder.decode(authState['token']!)['userId'];

    await fetchStudent(userId as String);

    state.when(
      data: (student) {
        if (student != null) {
          if (student.isVoted) {
            Routemaster.of(context).push(RoutePaths.studentsVotingCard);
          } else {
            print('No ha votado');
            Routemaster.of(context).push(RoutePaths.studentsNothingVoted);
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error: Student data is null')),
          );
        }
      },
      loading: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Loading student data...')),
        );
      },
      error: (error, stack) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al obtener datos del estudiante: $error'),
          ),
        );
      },
    );
  }
}
