import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/const/data.dart';
import '../model/user_model.dart';

final userProvider = StateNotifierProvider<UserStateNotifier, UserModelBase>(
  (ref) => UserStateNotifier(),
);

class UserStateNotifier extends StateNotifier<UserModelBase> {
  UserStateNotifier() : super(UserModelLoading()) {
    initItems();
  }

  void updateInfo({
    required String name,
    required String phone,
    required String email,
  }) {
    state = (state as UserModel).copyWith(
      name: name,
      phone: phone,
      email: email,
    );
  }

  void updateRecentlyViewedItems({
    required String recentlyViewedItem,
  }) {
    final user = state as UserModel;
    if (user.recentlyViewedItems.contains(recentlyViewedItem)) {
      print(1);
      state = user.copyWith(recentlyViewedItems: [
        ...user.recentlyViewedItems
            .where((element) => element != recentlyViewedItem),
        recentlyViewedItem,
      ]);
    } else {
      print(2);
      state = user.copyWith(recentlyViewedItems: [
        ...user.recentlyViewedItems,
        recentlyViewedItem,
      ]);
    }
    print(3);

    print((state as UserModel).recentlyViewedItems);
  }

  void initItems() {
    state = defaultUserModel;
  }
}