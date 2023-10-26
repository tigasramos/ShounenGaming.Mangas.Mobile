// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/manga_metadata_source_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_metadata.dart';
import 'package:shounengaming_mangas_mobile/src/shared/components/manga_image.dart';

import 'package:shounengaming_mangas_mobile/src/shared/utils/theme.dart';

import '../providers/manga_add.providers.dart';

class AddMangaScreen extends ConsumerWidget {
  const AddMangaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var mangaAddState = ref.watch(mangaAddProvider);
    var functions = ref.read(mangaAddProvider.notifier);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Mangas'),
        ),
        floatingActionButton: mangaAddState.selectedMangas.isNotEmpty &&
                !mangaAddState.isAddingMangas
            ? FloatingActionButton(
                onPressed: () async {
                  await functions.addMangas();
                },
                child: const Icon(Icons.save),
              )
            : null,
        body: Column(
          children: [
            mangaAddState.isLoadingMangas || mangaAddState.isAddingMangas
                ? const LinearProgressIndicator(
                    minHeight: 2,
                  )
                : Container(
                    height: 2,
                  ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        onEditingComplete: () async => await functions.search(),
                        controller: functions.searchController,
                        style: const TextStyle(fontSize: 15),
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(8),
                            isDense: true,
                            label: const Text('Name'),
                            suffixIcon: IconButton(
                              onPressed: functions.searchController.clear,
                              icon: const Icon(Icons.clear),
                            ),
                            border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.zero))),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField<MangaMetadataSourceEnum>(
                          value: mangaAddState.selectedSource,
                          isExpanded: true,
                          decoration: const InputDecoration(
                            isDense: true,
                            label: Text('Source'),
                            contentPadding: EdgeInsets.only(
                                left: 10, right: 10, top: 18, bottom: 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.zero)),
                          ),
                          items: MangaMetadataSourceEnum.values
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e.name,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ))
                              .toList(),
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          onChanged: (value) async {
                            if (value == null) return;
                            functions.changeSelectedSource(value);
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      MaterialButton(
                          onPressed: mangaAddState.isAddingMangas ||
                                  mangaAddState.isLoadingMangas
                              ? null
                              : () async {
                                  await functions.search();
                                },
                          height: 38,
                          minWidth: double.infinity,
                          color: palette[0],
                          child: const Text('Search Manga')),
                      const SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: mangaAddState.searchedMangas.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => MangaMetadataTile(
                            mangaAddState.searchedMangas[index],
                            mangaAddState.selectedMangas.any((element) =>
                                element ==
                                mangaAddState.searchedMangas[index].id),
                            functions.changeMangaSelection),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

class MangaMetadataTile extends ConsumerWidget {
  final MangaMetadata manga;
  final Function(int) changeSelection;
  final bool selected;

  const MangaMetadataTile(this.manga, this.selected, this.changeSelection,
      {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: manga.alreadyExists
          ? null
          : () {
              changeSelection(manga.id);
            },
      child: Container(
        height: 100,
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        child: Row(
          children: [
            Checkbox(
              value: selected || manga.alreadyExists,
              onChanged: manga.alreadyExists
                  ? null
                  : (value) {
                      changeSelection(manga.id);
                    },
            ),
            const SizedBox(
              width: 10,
            ),
            MangaImage(manga.imageUrl),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(manga.titles[0],
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          height: 1.2)),
                  Text(
                    manga.tags.join(", "),
                    style: const TextStyle(color: Colors.grey, fontSize: 11),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  RichText(
                      text: TextSpan(
                          text: 'Status: ',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontSize: 10),
                          children: [
                        TextSpan(
                            text: manga.status,
                            style: const TextStyle(color: Colors.white)),
                      ])),
                  RichText(
                      text: TextSpan(
                          text: 'Type: ',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontSize: 10),
                          children: [
                        TextSpan(
                            text: manga.type.name,
                            style: const TextStyle(color: Colors.white)),
                      ])),
                  RichText(
                      text: TextSpan(
                          text: 'Dates: ',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontSize: 10),
                          children: [
                        TextSpan(
                            text:
                                "${manga.startedAt != null ? DateFormat("MM/yyyy").format(manga.startedAt!) : '?'} - ${manga.finishedAt != null ? DateFormat("MM/yyyy").format(manga.finishedAt!) : '?'}",
                            style: const TextStyle(color: Colors.white)),
                      ])),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
