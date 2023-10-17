import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'chapter_profile_controller.dart';
import 'chapter_screen_parameters.dart';
import 'chapter_state.dart';

final chapterProfileProvider = StateNotifierProvider.autoDispose.family<
        ChapterProfileController, ChapterProfileState, ChapterScreenParameters>(
    (ref, args) => ChapterProfileController(ref, args));
