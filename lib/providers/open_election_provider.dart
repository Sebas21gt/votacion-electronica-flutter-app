import 'package:app_vote/providers/auth_provider.dart';
import 'package:app_vote/ui/main/global.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final openElectionProvider =
    StateNotifierProvider<OpenElectionNotifier, AsyncValue<void>>((ref) {
  return OpenElectionNotifier(ref);
});

class OpenElectionNotifier extends StateNotifier<AsyncValue<void>> {
  OpenElectionNotifier(this.ref) : super(const AsyncValue.data(null));

  final Ref ref;

  Future<void> openElection() async {
    final authState = ref.read(authProvider);
    final token = authState['token'];

    if (token == null) {
      state = AsyncValue.error('Token is missing', StackTrace.current);
      return;
    }

    state = const AsyncValue.loading();
    try {
      final response = await http.post(
        Uri.parse('${GlobalConfig.baseUrl}/electoral-records/open-election'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 201) {
        state = const AsyncValue.data(null);
      } else {
        state = AsyncValue.error(
          'Failed to open election: ${response.body}',
          StackTrace.current,
        );
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
