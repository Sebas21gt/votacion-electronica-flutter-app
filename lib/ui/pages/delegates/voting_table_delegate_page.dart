import 'dart:convert';
import 'dart:typed_data';
import 'package:app_vote/domain/entiti/delegate.model.dart';
import 'package:app_vote/domain/entiti/polling_table.model.dart';
import 'package:app_vote/providers/auth_provider.dart';
import 'package:app_vote/providers/delegate_provider.dart';
import 'package:app_vote/ui/main/styles.dart';
import 'package:app_vote/ui/widgets/atoms/signature_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class VotingTableDelegatePage extends ConsumerStatefulWidget {
  const VotingTableDelegatePage({super.key});

  @override
  ConsumerState<VotingTableDelegatePage> createState() =>
      _VotingTableDelegatePageState();
}

class _VotingTableDelegatePageState
    extends ConsumerState<VotingTableDelegatePage> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    final authState = ref.read(authProvider);
    final token = authState['token'];
    final userId = JwtDecoder.decode(token!)['userId'];
    await ref.read(delegateProvider.notifier).fetchDelegate(userId as String);
  }

  @override
  Widget build(BuildContext context) {
    final delegateState = ref.watch(delegateProvider);
    final pollingTableState = ref.watch(pollingTableProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mesa de Sufragio'),
      ),
      body: delegateState.when(
        data: (delegate) {
          if (delegate != null) {
            return pollingTableState.when(
              data: (pollingTable) => VotingTableContent(
                votingTable: pollingTable!,
                delegate: delegate,
                onConfirmSignature: (signature) async {
                  final signatureBase64 = base64Encode(signature);
                  await ref.read(delegateProvider.notifier).closePollingTable(
                        pollingTable.id,
                        signatureBase64,
                        context,
                      );
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
            );
          } else {
            return const Center(child: Text('No delegate data found'));
          }
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

class VotingTableContent extends StatelessWidget {
  const VotingTableContent({
    required this.votingTable,
    required this.delegate,
    required this.onConfirmSignature,
    super.key,
  });

  final PollingTableModel votingTable;
  final DelegateModel delegate;
  final void Function(Uint8List) onConfirmSignature;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'MESA DE SUFRAGIO',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Mesa Receptora Nº: ${votingTable.numberTable}',
            style: _infoStyle,
          ),
          const SizedBox(height: 8),
          Text(
            'Hora de Apertura: ${votingTable.dateOpen.hour}:${votingTable.dateOpen.minute}',
            style: _infoStyle,
          ),
          const SizedBox(height: 8),
          Text(
            'Fecha de Apertura: ${votingTable.dateOpen.day}/${votingTable.dateOpen.month}/${votingTable.dateOpen.year}',
            style: _infoStyle,
          ),
          const SizedBox(height: 8),
          Text(
            'Cantidad de estudiantes que votaron: ${votingTable.totalVotes}',
            style: _infoStyle,
          ),
          const SizedBox(height: 20),
          SignatureForm(
            title: 'Firma del Delegado',
            subtitle:
                'La firma se usará para cerrar y validar la mesa de sufragio',
            onConfirm: onConfirmSignature,
          ),
        ],
      ),
    );
  }

  TextStyle get _infoStyle => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: primary,
      );
}
