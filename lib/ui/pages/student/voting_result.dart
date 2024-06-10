import 'dart:convert';

import 'package:app_vote/providers/results_provider.dart';
import 'package:app_vote/ui/main/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResultVotingPage extends ConsumerStatefulWidget {
  const ResultVotingPage({super.key});

  @override
  ConsumerState<ResultVotingPage> createState() => _ResultVotingPageState();
}

class _ResultVotingPageState extends ConsumerState<ResultVotingPage> {
  @override
  void initState() {
    super.initState();
    _fetchResults();
  }

  Future<void> _fetchResults() async {
    await ref.read(resultsProvider.notifier).fetchResults();
  }

  @override
  Widget build(BuildContext context) {
    final resultsState = ref.watch(resultsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultado de votación'),
      ),
      body: resultsState.when(
        data: (results) {
          results.sort(
            (a, b) => b.votes.compareTo(a.votes),
          ); // Ordenar de mayor a menor
          final totalVotes =
              results.fold<int>(0, (sum, item) => sum + item.votes);
          final validVotes = results
              .where(
                (result) =>
                    result.studentFront.name != 'Voto Blanco' &&
                    result.studentFront.name != 'Voto Nulo',
              )
              .fold<int>(0, (sum, item) => sum + item.votes);
          final validVotesPercentage =
              ((validVotes / totalVotes) * 100).toStringAsFixed(2);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'CANTIDAD DE VOTOS',
                  style: TextStyle(
                    color: primary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '$validVotes Votos de $totalVotes Votos',
                  style: const TextStyle(
                    fontSize: 18,
                    color: primary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '$validVotesPercentage% Votos',
                  style: const TextStyle(fontSize: 18, color: primary),
                ),
                const SizedBox(height: 16),
                Column(
                  children: results.map((result) {
                    final percentage =
                        ((result.votes / totalVotes) * 100).toStringAsFixed(2);
                    return Card(
                      color: secondary,
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: Image.memory(
                            base64Decode(result.studentFront.logo),
                            fit: BoxFit.cover,
                          ).image,
                        ),
                        title: Text(
                          result.studentFront.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('$percentage%'),
                            Text('${result.votes} Votos'),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
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
