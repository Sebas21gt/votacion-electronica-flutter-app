import 'dart:convert';
import 'package:app_vote/providers/proposals_provider.dart';
import 'package:app_vote/ui/main/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudentFrontDetailPage extends ConsumerStatefulWidget {

  const StudentFrontDetailPage({required this.frontId, super.key});
  final String frontId;

  @override
  _StudentFrontDetailPageState createState() => _StudentFrontDetailPageState();
}

class _StudentFrontDetailPageState
    extends ConsumerState<StudentFrontDetailPage> {
  @override
  void initState() {
    super.initState();
    // Use Future.delayed to ensure it runs after build
    Future.delayed(Duration.zero, () {
      ref.read(proposalProvider.notifier).fetchProposals(widget.frontId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final proposalState = ref.watch(proposalProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del Frente Estudiantil'),
      ),
      body: proposalState.when(
        data: (proposal) {
          if (proposal == null) {
            return const Center(child: Text('No se encontraron datos'));
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: Image.memory(
                    base64Decode(proposal.studentFront.logo),
                    fit: BoxFit.cover,
                  ).image,
                  onBackgroundImageError: (_, __) {
                    print(
                        'Error loading image for ${proposal.studentFront.name}');
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  proposal.studentFront.name,
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Cartera del Frente Estudiantil',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 8),
                ...proposal.positions.map((position) {
                  return ListTile(
                    title: Text(position.positionName),
                    subtitle:
                        Text('${position.studentName}\n${position.studentCi}'),
                  );
                }).toList(),
                const SizedBox(height: 16),
                const Text(
                  'Propuestas',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 8),
                ...proposal.proposals.map((prop) {
                  return ListTile(
                    title: Text(prop.description),
                  );
                }).toList(),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
