import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/change_user_mangas_configs.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/nsfw_behaviour_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/reading_mode_type_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/translation_language_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/user_repository.dart';
import 'package:shounengaming_mangas_mobile/src/features/app/app_state.providers.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/constants.dart';

import 'configurations_state.dart';

class ConfigurationsController extends StateNotifier<ConfigurationsState> {
  ConfigurationsController(this.ref) : super(ConfigurationsState()) {
    fillInitialData();
  }

  Ref ref;

  bool hasInitialData() {
    return state.nsfwBehaviour != null &&
        state.readingMode != null &&
        state.showRealProgress != null &&
        state.skipTranslations != null &&
        state.language != null;
  }

  void fillInitialData() {
    var prevConfigs = ref.read(appStateProvider).userConfigs!;
    selectReadingMode(prevConfigs.readingMode);
    selectNSFWBehaviour(prevConfigs.nsfwBehaviour);
    selectLanguage(prevConfigs.translationLanguage);
    changeSkipTranslations(prevConfigs.skipChapterToAnotherTranslation);
    changeShowRealProgress(prevConfigs.showProgressForChaptersWithDecimals);
  }

  void selectReadingMode(ReadingModeTypeEnum readingMode) {
    state = state.copyWith(readingMode: readingMode);
  }

  void selectNSFWBehaviour(NSFWBehaviourEnum nsfwBehaviour) {
    state = state.copyWith(nsfwBehaviour: nsfwBehaviour);
  }

  void selectLanguage(TranslationLanguageEnum language) {
    state = state.copyWith(language: language);
  }

  void changeSkipTranslations(bool skipTranslations) {
    state = state.copyWith(skipTranslations: skipTranslations);
  }

  void changeShowRealProgress(bool showRealProgress) {
    state = state.copyWith(showRealProgress: showRealProgress);
  }

  Future saveConfigs() async {
    try {
      state = state.copyWith(isSaving: true);
      var updatedConfigs = await ref
          .watch(userRepositoryProvider)
          .updateUserConfigsForMangas(ChangeUserMangasConfigs(
              nsfwBehaviour: state.nsfwBehaviour,
              readingMode: state.readingMode,
              showProgressForChaptersWithDecimals: state.showRealProgress,
              skipChapterToAnotherTranslation: state.skipTranslations,
              translationLanguage: state.language));

      state = state.copyWith(isSaving: false);
      ref.watch(appStateProvider.notifier).setNewConfigs(updatedConfigs);
      fillInitialData();
    } catch (e, stackTrace) {
      await Sentry.captureException(e, stackTrace: stackTrace);
      snackbarKey.currentState?.showSnackBar(SnackBar(
        content: Text(
          'Error: $e',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red[400],
        duration: const Duration(seconds: 2),
      ));
      state = state.copyWith(isSaving: false);
    }
  }
}
