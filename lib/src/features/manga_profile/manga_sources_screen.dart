// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shounengaming_mangas_mobile/src/data/models/manga.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_source.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/manga_repository.dart';

final mangaSourcesProvider = StateNotifierProvider.family
    .autoDispose<MangaSourcesController, MangaSourcesState, int>(
        (ref, id) => MangaSourcesController(ref, id));

class MangaSourcesState {
  Manga? manga;
  List<MangaSource> scrappedList;
  List<MangaSource> existingSources;
  List<MangaSource> selectedScrapped;

  bool isLoadingManga;
  bool isLoadingExistingSources;
  bool isLoadingNewScrappers;
  bool isSaving;

  MangaSourcesState(
      {this.manga,
      required this.scrappedList,
      required this.selectedScrapped,
      required this.existingSources,
      this.isLoadingManga = true,
      this.isLoadingExistingSources = true,
      this.isLoadingNewScrappers = false,
      this.isSaving = false});

  MangaSourcesState copyWith({
    Manga? manga,
    List<MangaSource>? existingSources,
    List<MangaSource>? scrappedList,
    List<MangaSource>? selectedScrapped,
    bool? isLoadingManga,
    bool? isLoadingExistingSources,
    bool? isLoadingNewScrappers,
    bool? isSaving,
  }) {
    return MangaSourcesState(
      manga: manga ?? this.manga,
      scrappedList: scrappedList ?? this.scrappedList,
      selectedScrapped: selectedScrapped ?? this.selectedScrapped,
      existingSources: existingSources ?? this.existingSources,
      isLoadingManga: isLoadingManga ?? this.isLoadingManga,
      isLoadingExistingSources:
          isLoadingExistingSources ?? this.isLoadingExistingSources,
      isLoadingNewScrappers:
          isLoadingNewScrappers ?? this.isLoadingNewScrappers,
      isSaving: isSaving ?? this.isSaving,
    );
  }
}

class MangaSourcesController extends StateNotifier<MangaSourcesState> {
  MangaSourcesController(this.ref, this.mangaId)
      : super(MangaSourcesState(
            scrappedList: [], selectedScrapped: [], existingSources: [])) {
    fetchMangaInfo();
    fetchMangaSources();
  }

  Ref ref;
  int mangaId;
  TextEditingController searchController = TextEditingController();

  Future fetchMangaInfo() async {
    state = state.copyWith(isLoadingManga: true);
    var manga = await ref.watch(mangaRepositoryProvider).getMangaById(mangaId);
    state = state.copyWith(isLoadingManga: false, manga: manga);

    searchController.value = TextEditingValue(text: manga.name);
    searchMangaScrappers();
  }

  Future fetchMangaSources() async {
    state = state.copyWith(isLoadingExistingSources: true);
    var sources =
        await ref.watch(mangaRepositoryProvider).getMangaSourcesById(mangaId);
    state = state.copyWith(
        isLoadingExistingSources: false,
        existingSources: sources.toList(),
        selectedScrapped: sources.toList());
  }

  Future searchMangaScrappers() async {
    state = state.copyWith(isLoadingNewScrappers: true);
    var scrappedList = await ref
        .watch(mangaRepositoryProvider)
        .searchMangaSource(searchController.text);
    scrappedList.sort((a, b) => a.name.compareTo(b.name));
    state = state.copyWith(
        isLoadingNewScrappers: false, scrappedList: scrappedList);
  }

  Future addMangaSources() async {
    state = state.copyWith(isSaving: true, isLoadingExistingSources: true);
    var existingSources = await ref
        .watch(mangaRepositoryProvider)
        .linkSourcesToManga(mangaId, state.selectedScrapped);
    state = state.copyWith(
        isSaving: false,
        isLoadingExistingSources: false,
        existingSources: existingSources);
  }

  void changeSelectionFromSource(bool selected, MangaSource manga) {
    if (selected) {
      state =
          state.copyWith(selectedScrapped: state.selectedScrapped..add(manga));
    } else {
      state = state.copyWith(
          selectedScrapped: state.selectedScrapped..remove(manga));
    }
  }
}

class MangaSourcesScreen extends ConsumerWidget {
  final int mangaId;
  const MangaSourcesScreen(this.mangaId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var mangaSourceState = ref.watch(mangaSourcesProvider(mangaId));
    var functions = ref.read(mangaSourcesProvider(mangaId).notifier);

    if (mangaSourceState.isLoadingManga) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Add Sources'),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Add Sources'),
        actions: [
          mangaSourceState.isSaving
              ? const CircularProgressIndicator()
              : IconButton(
                  onPressed: mangaSourceState.isLoadingNewScrappers
                      ? null
                      : () async {
                          try {
                            await functions.addMangaSources();

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: const Text(
                                'Sources Saved!',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.green[700],
                              duration: const Duration(seconds: 2),
                            ));
                          } on Exception catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                'Error: $e',
                                style: const TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.red[400],
                              duration: const Duration(seconds: 3),
                            ));
                          }
                        },
                  icon: const Icon(Icons.save))
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            'Sugestions:',
            style: TextStyle(fontSize: 15),
          ),
          const SizedBox(
            height: 2,
          ),
          SizedBox(
            height: 20,
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
              }),
              child: ListView.separated(
                separatorBuilder: (context, index) => const Text(", "),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var name = "";
                  if (index >=
                      mangaSourceState.manga!.alternativeNames.length) {
                    name = mangaSourceState.manga!.synonyms[index -
                        mangaSourceState.manga!.alternativeNames.length];
                  } else {
                    name =
                        mangaSourceState.manga!.alternativeNames[index].value;
                  }
                  return InkWell(
                      onTap: () {
                        functions.searchController.value =
                            TextEditingValue(text: name);
                      },
                      child: Text(
                        name,
                        style: TextStyle(color: Colors.lightBlue[200]),
                      ));
                },
                itemCount: mangaSourceState.manga!.alternativeNames.length +
                    mangaSourceState.manga!.synonyms.length,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            'Name:',
            style: TextStyle(fontSize: 15),
          ),
          const SizedBox(
            height: 4,
          ),
          TextFormField(
            controller: functions.searchController,
            style: const TextStyle(
              fontSize: 15,
            ),
            decoration: const InputDecoration(
                isCollapsed: true,
                contentPadding: EdgeInsets.all(8),
                isDense: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.zero))),
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialButton(
              onPressed: mangaSourceState.isLoadingNewScrappers
                  ? null
                  : () async {
                      await ref
                          .watch(mangaSourcesProvider(mangaId).notifier)
                          .searchMangaScrappers();
                    },
              minWidth: double.infinity,
              color: Theme.of(context).primaryColor,
              child: const Text('Search')),
          const SizedBox(
            height: 15,
          ),
          const Text(
            'Selected Sources',
            style: TextStyle(fontSize: 16),
          ),
          mangaSourceState.isLoadingExistingSources
              ? const SizedBox(
                  width: double.infinity,
                  child: Center(child: CircularProgressIndicator()))
              : ListView(
                  shrinkWrap: true,
                  children: mangaSourceState.existingSources
                      .map((e) => CheckboxListTile(
                            secondary: e.imageURL != null && e.imageURL != ""
                                ? CachedNetworkImage(
                                    imageUrl: e.imageURL!,
                                    width: 40,
                                    errorWidget: (context, url, error) =>
                                        const CircularProgressIndicator(),
                                  )
                                : null,
                            value:
                                mangaSourceState.selectedScrapped.contains(e),
                            onChanged: (value) => functions
                                .changeSelectionFromSource(value ?? false, e),
                            title: Text(e.name),
                            subtitle: Text(
                              e.source.name,
                              style: TextStyle(color: Colors.purple[200]),
                            ),
                          ))
                      .toList(),
                ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Searched Sources',
            style: TextStyle(fontSize: 16),
          ),
          mangaSourceState.isLoadingNewScrappers
              ? const SizedBox(
                  width: double.infinity,
                  child: Center(child: CircularProgressIndicator()))
              : ListView(
                  shrinkWrap: true,
                  children: mangaSourceState.scrappedList
                      .where((element) =>
                          !mangaSourceState.existingSources.contains(element))
                      .map((e) => CheckboxListTile(
                            secondary: e.imageURL != null && e.imageURL != ""
                                ? CachedNetworkImage(
                                    imageUrl: e.imageURL!,
                                    width: 40,
                                    errorWidget: (context, url, error) =>
                                        const CircularProgressIndicator(),
                                  )
                                : null,
                            value:
                                mangaSourceState.selectedScrapped.contains(e),
                            onChanged: (value) => functions
                                .changeSelectionFromSource(value ?? false, e),
                            title: Text(e.name),
                            subtitle: Text(
                              e.source.name,
                              style: TextStyle(color: Colors.purple[200]),
                            ),
                          ))
                      .toList(),
                ),
        ]),
      )),
    );
  }
}
