import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'manga_add_controller.dart';
import 'manga_add_state.dart';

final mangaAddProvider =
    StateNotifierProvider.autoDispose<MangaAddController, MangaAddState>(
        (ref) => MangaAddController(ref));
