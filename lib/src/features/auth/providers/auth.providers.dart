import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/main.dart';

import 'login_state.dart';
import 'login_state_controller.dart';

final loginStateProvider =
    StateNotifierProvider.autoDispose<LoginStateController, LoginState>(
        (ref) => LoginStateController(ref));

final serverRunningProvider = FutureProvider<bool>((ref) async {
  final timer = Timer(
    const Duration(seconds: 5),
    () {
      ref.invalidateSelf();
    },
  );
  ref.onDispose(timer.cancel);

  var response = await ref.watch(dioProvider).get('healthz');
  return response.statusCode == 200 && response.data.toString() == "Healthy";
});
