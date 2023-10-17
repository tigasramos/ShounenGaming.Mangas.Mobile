import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_state.dart';
import 'app_state_controller.dart';

final appStateProvider = StateNotifierProvider<AppStateController, AppState>(
    (ref) => AppStateController(ref));
