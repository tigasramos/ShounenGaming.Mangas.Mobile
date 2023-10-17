import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/main.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/constants.dart';
import 'package:signalr_netcore/signalr_client.dart';

final mangasHubProvider = FutureProvider((ref) async {
  final httpConnectionOptions = HttpConnectionOptions(
    accessTokenFactory: () {
      var token = ref
          .watch(sharedPreferencesProvider)
          .getString(localStorageAccessTokenKey)!;
      return Future.value(token);
    },
  );

  var hub = HubConnectionBuilder()
      .withUrl("${ref.watch(serverUrlProvider)}mangasHub",
          options: httpConnectionOptions)
      .build();

  ref.onDispose(() async {
    await hub.stop();
  });

  hub.onclose((error) async {
    await Future.delayed(const Duration(seconds: 2));
    await hub.start();
  });

  await hub.start();
  return hub;
});
