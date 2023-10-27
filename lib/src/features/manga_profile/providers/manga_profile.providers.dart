import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'manga_profile_controller.dart';
import 'manga_profile_state.dart';
import 'manga_sources_controller.dart';
import 'manga_sources_state.dart';

final mangaProfileProvider = StateNotifierProvider.family
    .autoDispose<MangaProfileController, MangaProfileState, int>(
        (ref, id) => MangaProfileController(ref, id));

final mangaSourcesProvider = StateNotifierProvider.family
    .autoDispose<MangaSourcesController, MangaSourcesState, int>(
        (ref, id) => MangaSourcesController(ref, id));
