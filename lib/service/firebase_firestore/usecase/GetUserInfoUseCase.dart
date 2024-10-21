import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeleton/model/UserDataModel.dart';
import 'package:skeleton/service/firebase_firestore/provider/FirestoreProviders.dart';
import 'package:skeleton/service/firebase_firestore/repository/FirestoreRepository.dart';

final getUserInfoProvider = Provider.autoDispose<GetUserInfoUseCase>((ref) {
  final firestoreRepository = ref.watch(firestoreRepositoryProvider);
  return GetUserInfoUseCase(firestoreRepository);
});

final userInfoProvider = FutureProvider.autoDispose
    .family<UserDataModel?, String>((ref, userId) async {
  final getUserInfoUseCase = ref.watch(getUserInfoProvider);
  final userInforMap = await getUserInfoUseCase.execute(userId);
  if (userInforMap != null) {
    return UserDataModel.fromJson(userInforMap);
  }
  return null;
});

class GetUserInfoUseCase {
  final FirestoreRepository firestoreRepository;

  GetUserInfoUseCase(this.firestoreRepository);

  Future<Map<String, dynamic>?> execute(String userId) async {
    return await firestoreRepository.getUserInfo(userId);
  }
}
