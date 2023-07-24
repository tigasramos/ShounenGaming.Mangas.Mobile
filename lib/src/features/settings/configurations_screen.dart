// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dash_flags/dash_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shounengaming_mangas_mobile/main.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/change_user_mangas_configs.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/user_repository.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'package:shounengaming_mangas_mobile/src/data/models/enums/nsfw_behaviour_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/reading_mode_type_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/translation_language_enum.dart';
import 'package:shounengaming_mangas_mobile/src/others/enums_translation.dart';

final configurationsProvider = StateNotifierProvider.autoDispose<
    ConfigurationsController,
    ConfigurationsState>((ref) => ConfigurationsController(ref));

class ConfigurationsState {
  ReadingModeTypeEnum? readingMode;
  NSFWBehaviourEnum? nsfwBehaviour;
  TranslationLanguageEnum? language;
  bool? skipTranslations;
  bool? showRealProgress;

  bool isSaving;
  ConfigurationsState({
    this.readingMode,
    this.nsfwBehaviour,
    this.language,
    this.skipTranslations,
    this.showRealProgress,
    this.isSaving = false,
  });

  ConfigurationsState copyWith({
    ReadingModeTypeEnum? readingMode,
    NSFWBehaviourEnum? nsfwBehaviour,
    TranslationLanguageEnum? language,
    bool? skipTranslations,
    bool? showRealProgress,
    bool? isSaving,
  }) {
    return ConfigurationsState(
      readingMode: readingMode ?? this.readingMode,
      nsfwBehaviour: nsfwBehaviour ?? this.nsfwBehaviour,
      language: language ?? this.language,
      skipTranslations: skipTranslations ?? this.skipTranslations,
      showRealProgress: showRealProgress ?? this.showRealProgress,
      isSaving: isSaving ?? this.isSaving,
    );
  }
}

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

class ConfigurationsScreen extends ConsumerWidget {
  const ConfigurationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var configsState = ref.watch(configurationsProvider);
    var functions = ref.watch(configurationsProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurations'),
      ),
      floatingActionButton: configsState.isSaving
          ? null
          : FloatingActionButton(
              onPressed: () async {
                await functions.saveConfigs();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text(
                    'Configurations saved',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.green[800],
                  duration: const Duration(milliseconds: 1000),
                ));
              },
              child: const Icon(Icons.save)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: !functions.hasInitialData()
                ? [const LinearProgressIndicator()]
                : [
                    const Text(
                      'Reading Mode',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    ToggleSwitch(
                      initialLabelIndex: configsState.readingMode!.index,
                      minHeight: 40,
                      multiLineText: true,
                      centerText: true,
                      customTextStyles: const [TextStyle(fontSize: 10)],
                      totalSwitches: ReadingModeTypeEnum.values.length,
                      labels: ReadingModeTypeEnum.values
                          .map((e) => translateReadingModeType(e))
                          .toList(),
                      onToggle: (index) {
                        if (index == null) return;
                        functions.selectReadingMode(
                            ReadingModeTypeEnum.values[index]);
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'NSFW Behaviour ',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    ToggleSwitch(
                      initialLabelIndex: configsState.nsfwBehaviour!.index,
                      minHeight: 34,
                      minWidth: 80,
                      multiLineText: true,
                      centerText: true,
                      customTextStyles: const [TextStyle(fontSize: 10)],
                      totalSwitches: NSFWBehaviourEnum.values.length,
                      labels: NSFWBehaviourEnum.values
                          .map((e) => translateNSFWBehaviour(e))
                          .toList(),
                      onToggle: (index) {
                        if (index == null) return;
                        functions.selectNSFWBehaviour(
                            NSFWBehaviourEnum.values[index]);
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Language ',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            functions
                                .selectLanguage(TranslationLanguageEnum.EN);
                          },
                          child: Container(
                            decoration: configsState.language! ==
                                    TranslationLanguageEnum.EN
                                ? BoxDecoration(
                                    border: Border.all(color: Colors.white))
                                : null,
                            child: CountryFlag(
                              country: Country.gb,
                              height: 20,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        const Text(
                          '/',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        InkWell(
                          onTap: () {
                            functions
                                .selectLanguage(TranslationLanguageEnum.PT);
                          },
                          child: Container(
                            decoration: configsState.language ==
                                    TranslationLanguageEnum.PT
                                ? BoxDecoration(
                                    border: Border.all(color: Colors.white))
                                : null,
                            child: CountryFlag(
                              country: Country.pt,
                              height: 20,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Skip Translations ',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        FlutterSwitch(
                          valueFontSize: 12,
                          toggleSize: 20,
                          height: 30,
                          value: configsState.skipTranslations!,
                          showOnOff: true,
                          activeText: 'Yes',
                          inactiveText: 'No',
                          activeColor: Theme.of(context).primaryColor,
                          onToggle: (val) {
                            functions.changeSkipTranslations(val);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    const Text(
                      "When There's no Language for the Next Chapter Show Another Language",
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Show Real Progress ',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        FlutterSwitch(
                          valueFontSize: 12,
                          toggleSize: 20,
                          height: 30,
                          value: configsState.showRealProgress!,
                          showOnOff: true,
                          activeText: 'Yes',
                          inactiveText: 'No',
                          activeColor: Theme.of(context).primaryColor,
                          onToggle: (val) {
                            functions.changeShowRealProgress(val);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      "Yes: All Chapters Count\nNo: Progress Bars in Library only Count Chapters without Decimals",
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                  ],
          ),
        ),
      ),
    );
  }
}
