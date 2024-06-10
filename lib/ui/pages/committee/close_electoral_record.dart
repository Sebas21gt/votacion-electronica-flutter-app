import 'dart:convert';
import 'package:app_vote/providers/results_provider.dart';
import 'package:app_vote/providers/election_provider.dart';
import 'package:app_vote/ui/widgets/atoms/signature_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ElectoralRecordPage extends ConsumerStatefulWidget {
  const ElectoralRecordPage({super.key});

  @override
  ConsumerState<ElectoralRecordPage> createState() =>
      _ElectoralRecordPageState();
}

class _ElectoralRecordPageState extends ConsumerState<ElectoralRecordPage> {
  @override
  void initState() {
    super.initState();
    _fetchResults();
  }

  Future<void> _fetchResults() async {
    await ref.read(resultsProvider.notifier).fetchResults();
  }

  Future<void> _confirmAndCloseElection(
    BuildContext context,
    String signature,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar'),
        content: const Text('¿Está seguro de que desea cerrar la elección?, Todo el commité tiene que firmar para cerrar la elección.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('CANCELAR'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('ACEPTAR'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(electionProvider.notifier).closeElection(signature);
    }
  }

  @override
  Widget build(BuildContext context) {
    final resultsState = ref.watch(resultsProvider);
    final electionState = ref.watch(electionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Acta de Escrutinio'),
      ),
      body: resultsState.when(
        data: (results) {
          results.sort((a, b) {
            if (a.studentFront.name == 'Nulo' ||
                a.studentFront.name == 'Blanco') {
              return 1;
            } else if (b.studentFront.name == 'Nulo' ||
                b.studentFront.name == 'Blanco') {
              return -1;
            } else {
              return b.votes.compareTo(a.votes);
            }
          });

          final totalVotes =
              results.fold<int>(0, (sum, item) => sum + item.votes);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'ACTA DE ESCRUTINIO',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Candidato a: Centro de Estudiantes del área de las Tics',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                DataTable(
                  columns: const [
                    DataColumn(label: Text('Candidatos')),
                    DataColumn(label: Text('Nº de Votos')),
                  ],
                  rows: results.map((result) {
                    return DataRow(
                      cells: [
                        DataCell(Text(result.studentFront.name)),
                        DataCell(Text(result.votes.toString())),
                      ],
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                Text(
                  'Total Votos: $totalVotes',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 20),
                SignatureForm(
                  title: 'Firmar Acta',
                  subtitle: 'La firma se usará para cerrar y validar el acta',
                  onConfirm: (signature) {
                    final signatureBase64 = base64Encode(signature);
                    _confirmAndCloseElection(context, signatureBase64);
                  },
                ),
                if (electionState is AsyncLoading)
                  const Center(child: CircularProgressIndicator()),
                if (electionState is AsyncError)
                  Center(child: Text('Error: ${electionState.error}')),
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
