// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dash_flags/dash_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/nsfw_behaviour_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/reading_mode_type_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/translation_language_enum.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/enums_translation.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../providers/configuration_controller.dart';
import '../providers/configurations.providers.dart';

class ConfigurationsScreen extends ConsumerWidget {
  const ConfigurationsScreen({super.key});

  Future saveConfigs(
      ConfigurationsController functions, BuildContext context) async {
    await functions.saveConfigs();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var configsState = ref.watch(configurationsProvider);
    var functions = ref.watch(configurationsProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurations'),
      ),
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
                      onToggle: (index) async {
                        if (index == null) return;
                        functions.selectReadingMode(
                            ReadingModeTypeEnum.values[index]);

                        await saveConfigs(functions, context);
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
                      onToggle: (index) async {
                        if (index == null) return;
                        functions.selectNSFWBehaviour(
                            NSFWBehaviourEnum.values[index]);
                        await saveConfigs(functions, context);
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
                          onTap: () async {
                            functions
                                .selectLanguage(TranslationLanguageEnum.EN);
                            await saveConfigs(functions, context);
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
                          onTap: () async {
                            functions
                                .selectLanguage(TranslationLanguageEnum.PT);
                            await saveConfigs(functions, context);
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
                          onToggle: (val) async {
                            functions.changeSkipTranslations(val);
                            await saveConfigs(functions, context);
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
                          onToggle: (val) async {
                            functions.changeShowRealProgress(val);
                            await saveConfigs(functions, context);
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
