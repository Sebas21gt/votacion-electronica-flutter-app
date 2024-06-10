// ignore_for_file: cascade_invocations

import 'package:app_vote/providers/auth_provider.dart';
import 'package:app_vote/providers/delegate_provider.dart';
import 'package:app_vote/ui/main/routes.dart';
import 'package:app_vote/ui/pages/delegates/drawer_items_delegate.dart';
import 'package:app_vote/ui/widgets/atoms/drawer_custom.dart';
import 'package:app_vote/ui/widgets/atoms/menu_button_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:routemaster/routemaster.dart';

class MenuDelegatePage extends ConsumerWidget {
  const MenuDelegatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú Delegado'),
      ),
      drawer: CustomDrawer(drawerItems: delegateDrawerItems),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            const MenuButton(
              title: 'Habilitar \nEstudiante',
              imagePath: 'assets/icons/qr-100.png',
              route: RoutePaths.enableStudents,
              // onPressedAction: () => _checkSignatureAndNavigate(context, ref),
            ),
            const SizedBox(height: 16),
            MenuButton(
              title: 'Mesa \nde Sufragio',
              imagePath: 'assets/icons/Table.png',
              route: RoutePaths.votingTable,
              onPressedAction: () => _checkSignatureAndNavigate(context, ref),
            ),
          ],
        ),
      ),
    );
  }

  void _checkSignatureAndNavigate(BuildContext context, WidgetRef ref) async {
    final authState = ref.read(authProvider);
    final token = authState['token'];
    final userId = JwtDecoder.decode(token!)['userId'];

    await ref.read(delegateProvider.notifier).fetchDelegate(userId as String);

    final delegateState = ref.read(delegateProvider);

    delegateState.when(
      data: (delegate) {
        print(delegate?.signature);

        if (delegate?.signature.trim() != '') {
          Routemaster.of(context).push(RoutePaths.closingTable);
        } else {
          Routemaster.of(context).push(RoutePaths.votingTable);
        }
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      ),
    );
  }
}
