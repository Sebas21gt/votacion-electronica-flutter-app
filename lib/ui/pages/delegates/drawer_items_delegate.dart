import 'package:app_vote/providers/auth_provider.dart';
import 'package:app_vote/providers/delegate_provider.dart';
import 'package:app_vote/ui/main/routes.dart';
import 'package:app_vote/ui/widgets/atoms/drawer_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:routemaster/routemaster.dart';

final delegateDrawerItems = [
  DrawerItem(
    icon: Icons.qr_code,
    title: 'Habilitar Estudiantes',
    route: RoutePaths.enableStudents,
    onPressedAction: _checkSignatureAndNavigate,
  ),
  DrawerItem(
    icon: Icons.how_to_vote,
    title: 'Mesa de Sufragio',
    route: RoutePaths.votingTable,
    onPressedAction: _checkSignatureAndNavigate,
  ),
  DrawerItem(
    icon: Icons.info,
    title: 'Mi Información',
    route: '',
  ),
];

Future<void> _checkSignatureAndNavigate(
  BuildContext context,
  WidgetRef ref,
) async {
  final authState = ref.read(authProvider);
  final token = authState['token'];
  final userId = JwtDecoder.decode(token!)['userId'];

  await ref.read(delegateProvider.notifier).fetchDelegate(userId as String);

  final delegateState = ref.read(delegateProvider);

  delegateState.when(
    data: (delegate) {
      if (delegate?.signature != null) {
        Routemaster.of(context).push(RoutePaths.closingTable);
      } else {
        Routemaster.of(context).push(RoutePaths.votingTable);
      }
    },
    loading: () => ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Loading delegate data...')),
    ),
    error: (error, stack) => ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $error')),
    ),
  );
}
