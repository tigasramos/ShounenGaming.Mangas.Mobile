import 'package:flutter/material.dart';

const String localStorageAccessTokenKey = "sg_mangas_accessToken";
const String localStorageRefreshTokenKey = "sg_mangas_refreshToken";
const String localStorageUsername = "sg_mangas_username";
const String localStorageChapterProgress = "chapter_progress_";
const String localStorageReadingListView =
    "sg_mangas_library_reading_list_view";

final navigationKey = GlobalKey<NavigatorState>();
final snackbarKey = GlobalKey<ScaffoldMessengerState>();
