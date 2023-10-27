import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'configuration_controller.dart';
import 'configurations_state.dart';

final configurationsProvider = StateNotifierProvider.autoDispose<
    ConfigurationsController,
    ConfigurationsState>((ref) => ConfigurationsController(ref));
