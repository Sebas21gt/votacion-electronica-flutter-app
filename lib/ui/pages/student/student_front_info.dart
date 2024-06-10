// ignore_for_file: unnecessary_null_comparison, library_private_types_in_public_api

import 'dart:convert';

import 'package:app_vote/providers/student_front_provider.dart';
import 'package:app_vote/ui/main/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudentFrontInfoPage extends ConsumerStatefulWidget {
  const StudentFrontInfoPage({super.key});

  @override
  _StudentFrontInfoPageState createState() => _StudentFrontInfoPageState();
}

class _StudentFrontInfoPageState extends ConsumerState<StudentFrontInfoPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(studentFrontProvider.notifier).fetchStudentFrontsList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final studentFrontState = ref.watch(studentFrontProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Información de Frentes Estudiantiles'),
      ),
      body: studentFrontState.when(
        data: (fronts) => ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: fronts.length,
          itemBuilder: (context, index) {
            final front = fronts[index];
            return Card(
              color: secondary,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30.0,
                  backgroundImage: Image.memory(
                    base64Decode(front.logo),
                    fit: BoxFit.cover,
                  ).image,
                  onBackgroundImageError: (_, __) {
                    print('Error loading image for ${front.name}');
                  },
                ),
                title: Text(
                  front.name,
                  style: const TextStyle(
                    color: primary,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(front.acronym),
                onTap: () {
                  print('Tapped on ${front.name}');
                  print('Tapped on ${front.id}');
                },
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
