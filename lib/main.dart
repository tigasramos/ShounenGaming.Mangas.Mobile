// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sentry_dio/sentry_dio.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shounengaming_mangas_mobile/src/features/app/sg_mangas_app.dart';

/*
https://pub.dev/packages/flutter_autoupdate
 Current Version: package_info_plus
 Releases Website: https://api.github.com/repos/tigasramos/ShounenGaming.Mangas.Mobile/releases
*/

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  PlatformDispatcher.instance.onError = (error, stack) {
    Sentry.captureException(
      error,
      stackTrace: stack,
    );
    return true;
  };

  FlutterError.onError = (details) async {
    FlutterError.presentError(details);
    await Sentry.captureException(
      details.exception,
      stackTrace: details.stack,
    );
  };

  final sharedPreferences = await SharedPreferences.getInstance();

  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://415f2b7ffe5d463f99aba8029ff53b1a@glitch.shounengaming.xyz/1';
      options.tracesSampleRate = 1.0;
      options.attachScreenshot = true;
      options.environment = "local";

      options.release = "${packageInfo.version}.${packageInfo.buildNumber}";
    },
    appRunner: () => runApp(ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const SGMangasApp(),
    )),
  );
}

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final serverUrlProvider = StateProvider((ref) {
  return 'https://localhost:7252/';
  //return 'https://server-dev.shounengaming.xyz/';
  //return 'https://server.shounengaming.xyz/';
});

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(baseUrl: ref.watch(serverUrlProvider)));

  ref.onDispose(dio.close);

  dio.addSentry();
  return dio;
});
