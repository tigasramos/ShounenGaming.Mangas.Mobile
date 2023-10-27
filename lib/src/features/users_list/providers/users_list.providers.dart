import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/user_repository.dart';

final usersListProvider = FutureProvider.autoDispose((ref) async {
  var userRepo = ref.watch(userRepositoryProvider);
  var users = await userRepo.getAllUsers();
  return users
    ..sort((a, b) {
      return a.fullName.compareTo(b.fullName);
    });
});
