// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:app_vote/domain/entiti/students_front.model.dart';
import 'package:app_vote/providers/student_front_provider.dart';
import 'package:app_vote/ui/dialogs/confirm_vote_dialog.dart';
import 'package:app_vote/ui/main/styles.dart';
import 'package:app_vote/ui/widgets/atoms/button_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VotingPage extends ConsumerStatefulWidget {
  const VotingPage({super.key});

  @override
  _VotingPageState createState() => _VotingPageState();
}

class _VotingPageState extends ConsumerState<VotingPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(studentFrontProvider.notifier).fetchStudentFronts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final studentFrontState = ref.watch(studentFrontProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Votaciones Estudiantiles'),
      ),
      body: studentFrontState.when(
        data: (fronts) => VotingPageContent(fronts: fronts),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

class VotingPageContent extends StatelessWidget {
  const VotingPageContent({required this.fronts, super.key});
  final List<StudentFrontModel> fronts;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'CANDIDATOS',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Vota por tu candidato favorito para el centro de estudiantes',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          const Text(
            'Cierre de Votación en 5 Hrs',
            style: TextStyle(fontSize: 16, color: Colors.red),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: fronts.length,
              itemBuilder: (context, index) {
                final front = fronts[index];
                return StudentFrontCard(front: front);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class StudentFrontCard extends StatelessWidget {
  const StudentFrontCard({required this.front, super.key});
  final StudentFrontModel front;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: Image.memory(
              base64Decode(front.logo),
              fit: BoxFit.cover,
            ).image,
            onBackgroundImageError: (_, __) {
              print('Error loading image for ${front.name}');
            },
          ),
          const SizedBox(height: 8),
          Text(
            front.name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ButtonCustom(
            width: 100,
            onPressed: () async {
              showConfirmVoteDialog(context, front.name, front.id);
            },
            text: 'Votar',
          ),
        ],
      ),
    );
  }
}
