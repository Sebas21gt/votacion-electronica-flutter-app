import 'package:app_vote/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GuardedPage extends ConsumerWidget {

  const GuardedPage({
    required this.child,
    required this.requiredRole,
    super.key,
  });

  final Widget child;
  final String requiredRole;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final userRole = authState['selectedRole'];

    if (userRole == requiredRole) {
      return child;
    } else {
      return const Center(
        child: Text('No tienes acceso a esta página'),
      );
    }
  }
}
