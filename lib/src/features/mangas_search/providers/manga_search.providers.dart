import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'manga_search_controller.dart';
import 'manga_search_state.dart';

final mangaSearchProvider =
    StateNotifierProvider.autoDispose<MangaSearchController, MangaSearchState>(
        (ref) => MangaSearchController(ref));
